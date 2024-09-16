/*
 * Meter.c : EFM8 Period Measurement At Pin P0.1 using Timer 0.
 * This is used to Display the Frequency and 555 Timer Calculated Capacitance on LCD.
 * Circuitry also used to Measure Resistance via Voltage Divider at Pin P2.1.
 */

/* Include Headers */
#include <EFM8LB1.h>
#include <stdio.h>

#define MODE_CAPACITANCE 0
#define MODE_RESISTANCE 1

#define MAX_16_BIT 65536.0 // 16-Bit Maximum Value
#define MAX_8_BIT 256.0 // 8-Bit Maximum Value

#define MIN_FREQ_HZ 200.0 // Minimum Frequency in Hz
#define MAX_FREQ_HZ 400000.0 // Maximum Frequency in Hz

#define MIN_CAPACITANCE_NF 1.0 // Minimum Capacitance in Nanofarads
#define MAX_CAPACITANCE_NF 1000.0 // Maximum Capacitance in Nanofarads

#define SUCCESS_THRESHOLD 10 // Success Threshold

/* Define Multipliers */
#define KILO_MULTIPLIER 1000.0 // Kilo Multiplier
#define MEGA_MULTIPLIER 1000000.0 // Mega Multiplier
#define GIGA_MULTIPLIER 1000000000.0 // Giga Multiplier
#define TERA_MULTIPLIER 1000000000000.0 // Tera Multiplier

/* Clock Frequency and Baud Rate */
#define SYSCLK    72000000L // SYSCLK Frequency in Hz
#define BAUDRATE    115200L // Baudrate of UART in BPS
#define SARCLK 18000000L // SARCLK Frequency in Hz

/* Define Pins */
#define MODE_PIN P3_1 // Mode Button

#define EFM8_SIGNAL P0_1 // Signal to Measure
#define ADC_R P2_1 // ADC Resistor

#define LCD_RS P1_7 // LCD Register Select
#define LCD_E  P2_0 // LCD Enable

#define LCD_D4 P1_3 // LCD Data 4
#define LCD_D5 P1_2 // LCD Data 5
#define LCD_D6 P1_1 // LCD Data 6
#define LCD_D7 P1_0 // LCD Data 7

/* Define Constants for Resistances */
#define R_A 1.5 * KILO_MULTIPLIER
#define R_B 1.5 * KILO_MULTIPLIER
#define R_REF 98.62 * KILO_MULTIPLIER

#define VSS 4.8 // The measured value of VSS in volts
#define VDD 3.3035 // The measured value of VDD in volts

#define CHARS_PER_LINE 16

unsigned char overflow_count; // Timer 0 Overflow Counter

char LCD_BUFF[CHARS_PER_LINE]; // Buffer for LCD Display

/* Function Prototypes */
unsigned int ADC_at_Pin(unsigned char pin);
float Volts_at_Pin(unsigned char pin);

void Timer3us(unsigned char us);
void waitms(unsigned int ms);

void LCD_pulse(void);
void LCD_byte(unsigned char x);
void WriteData(unsigned char x);
void WriteCommand(unsigned char x);
void LCD_4BIT(void);
void LCDprint(char * string, unsigned char line, bit clear);

int write_rx(char* buff, int len);
void display_rx(char* buff, int len);
void display_period(float period);
void display_freq_kHz(float freq_kHz);
void display_capacitance_nF(float capacitance_nF);
void display_resistance_kOhms(float resistance_kOhms);

float calculate_period_s(int overflow_count, int TH0, int TL0);
float calculate_freq_Hz(float period_s);
float calculate_capacitance_nF(float period_s);
float calculate_resistance_k0hms(float voltage_across_resistor);

int Check_Mode_Button(int mode);

/*
 * External Startup Function
 */
char _c51_external_startup(void) {
	// Disable Watchdog With Key Sequence
	SFRPAGE = 0x00;
	WDTCN = 0xDE; // First Key
	WDTCN = 0xAD; // Second Key

	VDM0CN |= 0x80;
	RSTSRC=0x02|0x04;  // Enable Reset on Missing Clock Detector and VDD

	#if (SYSCLK == 48000000L)
		SFRPAGE = 0x10;
		PFE0CN  = 0x10; // SYSCLK < 50 MHz.
		SFRPAGE = 0x00;
    /* Effective SYSCLK */
	#elif (SYSCLK == 72000000L)
		SFRPAGE = 0x10;
		PFE0CN  = 0x20; // SYSCLK < 75 MHz.
		SFRPAGE = 0x00;
	#endif

	#if (SYSCLK == 12250000L)
		CLKSEL = 0x10;
		CLKSEL = 0x10;
		while ((CLKSEL & 0x80) == 0);
	#elif (SYSCLK == 24500000L)
		CLKSEL = 0x00;
		CLKSEL = 0x00;
		while ((CLKSEL & 0x80) == 0);
	#elif (SYSCLK == 48000000L)
		// Before Setting Clock to 48 MHz, Must Transition to 24.5 MHz First
		CLKSEL = 0x00;
		CLKSEL = 0x00;
		while ((CLKSEL & 0x80) == 0);
		CLKSEL = 0x07;
		CLKSEL = 0x07;
		while ((CLKSEL & 0x80) == 0);
    /* Effective SYSCLK */
	#elif (SYSCLK == 72000000L)
		// Before Setting Clock to 72 MHz, Must Transition to 24.5 MHz First
		CLKSEL = 0x00;
		CLKSEL = 0x00;
		while ((CLKSEL & 0x80) == 0);
		CLKSEL = 0x03;
		CLKSEL = 0x03;
		while ((CLKSEL & 0x80) == 0);
	#else
		#error SYSCLK must be either 12250000L, 24500000L, 48000000L, or 72000000L
	#endif

	P0MDOUT |= 0x10; // Enable UART0 TX As Push-Pull Output
	XBR0     = 0x01; // Enable UART0 on P0.4 (TX) and P0.5 (RX)
	XBR1     = 0X00; // Enable T0 on P0.0
	XBR2     = 0x40; // Enable Crossbar and Weak Pull-Ups

	#if (((SYSCLK/BAUDRATE)/(2L*12L))>0xFFL)
		#error Timer 0 reload value is incorrect because (SYSCLK/BAUDRATE)/(2L*12L) > 0xFF
	#endif

	// Configure UART 0
	SCON0 = 0x10;
	CKCON0 |= 0b_0000_0000 ; // Timer 1 Uses SYSCLK / 12
	TH1 = 0x100-((SYSCLK/BAUDRATE)/(2L*12L)); // Set Timer1 Reload Value, Initial Value
	TL1 = TH1; 	// Init Timer1
	TMOD &= ~0xf0;  // TMOD: Timer 1 in 8-bit auto-reload
	TMOD |=  0x20;
	TR1 = 1; // Start Timer1
	TI = 1;  // Indicate TX0 Ready

	return 0;
}

void InitADC(void) {
	SFRPAGE = 0x00;
	ADEN=0; // Disable ADC

	ADC0CN1=
		(0x2 << 6) | // 0x0: 10-bit, 0x1: 12-bit, 0x2: 14-bit
        (0x0 << 3) | // 0x0: No shift. 0x1: Shift right 1 bit. 0x2: Shift right 2 bits. 0x3: Shift right 3 bits.
		(0x0 << 0) ; // Accumulate n conversions: 0x0: 1, 0x1:4, 0x2:8, 0x3:16, 0x4:32

	ADC0CF0=
	    ((SYSCLK/SARCLK) << 3) | // SAR Clock Divider. Max is 18MHz. Fsarclk = (Fadcclk) / (ADSC + 1)
		(0x0 << 2); // 0:SYSCLK ADCCLK = SYSCLK. 1:HFOSC0 ADCCLK = HFOSC0.

	ADC0CF1=
		(0 << 7)   | // 0: Disable low power mode. 1: Enable low power mode.
		(0x1E << 0); // Conversion Tracking Time. Tadtk = ADTK / (Fsarclk)

	ADC0CN0 =
		(0x0 << 7) | // ADEN. 0: Disable ADC0. 1: Enable ADC0.
		(0x0 << 6) | // IPOEN. 0: Keep ADC powered on when ADEN is 1. 1: Power down when ADC is idle.
		(0x0 << 5) | // ADINT. Set by hardware upon completion of a data conversion. Must be cleared by firmware.
		(0x0 << 4) | // ADBUSY. Writing 1 to this bit initiates an ADC conversion when ADCM = 000. This bit should not be polled to indicate when a conversion is complete. Instead, the ADINT bit should be used when polling for conversion completion.
		(0x0 << 3) | // ADWINT. Set by hardware when the contents of ADC0H:ADC0L fall within the window specified by ADC0GTH:ADC0GTL and ADC0LTH:ADC0LTL. Can trigger an interrupt. Must be cleared by firmware.
		(0x0 << 2) | // ADGN (Gain Control). 0x0: PGA gain=1. 0x1: PGA gain=0.75. 0x2: PGA gain=0.5. 0x3: PGA gain=0.25.
		(0x0 << 0) ; // TEMPE. 0: Disable the Temperature Sensor. 1: Enable the Temperature Sensor.

	ADC0CF2=
		(0x0 << 7) | // GNDSL. 0: reference is the GND pin. 1: reference is the AGND pin.
		(0x1 << 5) | // REFSL. 0x0: VREF pin (external or on-chip). 0x1: VDD pin. 0x2: 1.8V. 0x3: internal voltage reference.
		(0x1F << 0); // ADPWR. Power Up Delay Time. Tpwrtime = ((4 * (ADPWR + 1)) + 2) / (Fadcclk)

	ADC0CN2 =
		(0x0 << 7) | // PACEN. 0x0: The ADC accumulator is over-written.  0x1: The ADC accumulator adds to results.
		(0x0 << 0) ; // ADCM. 0x0: ADBUSY, 0x1: TIMER0, 0x2: TIMER2, 0x3: TIMER3, 0x4: CNVSTR, 0x5: CEX5, 0x6: TIMER4, 0x7: TIMER5, 0x8: CLU0, 0x9: CLU1, 0xA: CLU2, 0xB: CLU3

	ADEN=1; // Enable ADC
}

void InitPinADC(unsigned char portno, unsigned char pinno) {
	unsigned char mask;

	mask = 1 << pinno;

	SFRPAGE = 0x20;
	switch(portno) {
		case 0:
			P0MDIN &= (~mask); // Set Pin as Analog Input
			P0SKIP |= mask; // Skip Crossbar Decoding for this Pin
			break;
		case 1:
			P1MDIN &= (~mask); // Set Pin as Analog Input
			P1SKIP |= mask; // Skip Crossbar Decoding for this Pin
			break;
		case 2:
			P2MDIN &= (~mask); // Set Pin as Analog Input
			P2SKIP |= mask; // Skip Crossbar Decoding for this Pin
			break;
		default:
			break;
	}
	SFRPAGE = 0x00;
}

void TIMER0_Init(void) {
	TMOD &= 0b_1111_0000; // Set the Bits of Timer/Counter 0 to 0
	TMOD |= 0b_0000_0001; // Timer/Counter 0 Used As 16-Bit Timer
	TR0 = 0; // Stop Timer/Counter 0
}

void Serial_Init(void) {
	waitms(500); // Give Putty a chance to start.
	printf("\x1b[2J"); // Clear screen using ANSI escape sequence.
}

unsigned int ADC_at_Pin(unsigned char pin) {
	ADC0MX = pin;   // Select the Pin for the ADC
	ADINT = 0;
	ADBUSY = 1;     // Convert Voltage at the Pin
	while (!ADINT); // Wait for Conversion to Complete
	return (ADC0);
}

float Volts_at_Pin(unsigned char pin) {
	 return (
		(ADC_at_Pin(pin)*VDD) / 0b_0011_1111_1111_1111
	);
}

/*
 * Uses Timer 3 to delay <us> micro-seconds.
 */
void Timer3us(unsigned char us) {
	unsigned char i; // Microsecond Counter

	// Input for Timer 3 is Selected as SYSCLK by Setting T3ML (Bit 6) of CKCON0
	CKCON0 |= 0b_0100_0000;

	TMR3RL = (-(SYSCLK)/1000000L); // Set Timer3 to Overflow in 1us
	TMR3 = TMR3RL;                 // Initialize Timer3 for First Overflow

	TMR3CN0 = 0x04;                 // Start Timer3 and Clear Overflow Flag
	for (i = 0; i < us; i++) {      // Count Overflows (#Microseconds)
		while (!(TMR3CN0 & 0x80));  // Wait for Overflow
		TMR3CN0 &= ~(0x80);         // Clear Overflow Indicator
	}
	TMR3CN0 = 0 ;                   // Stop Timer3 and Clear Overflow Flag
}

/*
 * Uses Timer 3 to delay <ms> milli-seconds.
 */
void waitms(unsigned int ms) {
	unsigned int j;
	unsigned char k;
	for (j=0; j<ms; j++)
		for (k=0; k<4; k++) Timer3us(250);
}

void LCD_pulse(void) {
	LCD_E = 1; // Pulse the Enable Pin
	Timer3us(40); // Wait for 40us
	LCD_E = 0; // Pulse the Enable Pin
}

void LCD_byte(unsigned char x) {
	// Note: Accumulator in the C8051Fxxx is Bit Addressable

	ACC = x; // Send High Nibble
	LCD_D7 = ACC_7;
	LCD_D6 = ACC_6;
	LCD_D5 = ACC_5;
	LCD_D4 = ACC_4;
	LCD_pulse();

	Timer3us(40); // Wait for 40us

	ACC = x; // Send Low Nibble
	LCD_D7 = ACC_3;
	LCD_D6 = ACC_2;
	LCD_D5 = ACC_1;
	LCD_D4 = ACC_0;
	LCD_pulse();
}

void WriteData(unsigned char x) {
	LCD_RS = 1; // Set LCD to Data Mode
	LCD_byte(x); // Write the Data
	waitms(2); // Wait for 2ms
}

void WriteCommand(unsigned char x) {
	LCD_RS = 0; // Set LCD to Command Mode
	LCD_byte(x); // Write the Command
	waitms(5); // Wait for 5ms
}

void LCD_4BIT(void) {
	LCD_E = 0; // Resting State of LCD Enable Pin is 0.
	waitms(20); // Wait for 20ms

	// First Ensure the LCD is in 8-Bit Mode and Then Change to 4-Bit Mode
	WriteCommand(0x33); // Change to 8-bit Mode
	WriteCommand(0x33); // Change to 8-bit Mode
	WriteCommand(0x32); // Change to 4-bit Mode

	// Configure the LCD
	WriteCommand(0x28); // 4-bit, 2 Line, 5x7 Dots
	WriteCommand(0x0c); // Display On, No Cursor, No Blink
	WriteCommand(0x01); // Clear Screen Command (Takes Some Time)
	waitms(20); // Wait 20ms for Clear Screen Command to Finish
}

void LCDprint(char * string, unsigned char line, bit clear) {
	int j;

	WriteCommand(line == 2 ? 0xc0 : 0x80); // Set Cursor
	waitms(5); // Wait for 5ms
	for (j = 0; string[j] != 0; j++) WriteData(string[j]); // Write Message
	if (clear) for (; j < CHARS_PER_LINE; j++) WriteData(' '); // Clear Rest of Line
}

int write_rx(char* buff, int len) {
	int j;
	char c;

	for (j = 0; j < (len-1); j++) {
		c = getchar();
		if ( (c == '\n') || (c == '\r') ) {
			buff[j] = 0;
			return j;
		} else {
			buff[j] = c;
		}
	}
	buff[j] = 0;
	return len;
}

void display_rx(char* buff, int len) {
	printf("Type Intended Display in Line 2 (16 Char Max): ");
	write_rx(buff, len);
	printf("\n");
	LCDprint(buff, 1, 1);
}

void display_period(float period) {
	sprintf(LCD_BUFF, "T: %.3f s", period); // Format the Period Value
	LCDprint(LCD_BUFF, 2, 1); // Write to LCD
}

void display_freq_kHz(float freq_kHz) {
	sprintf(LCD_BUFF, "F: %.3f kHz", freq_kHz); // Format the Frequency Value
	LCDprint(LCD_BUFF, 1, 1); // Write to LCD
}

void display_capacitance_nF(float capacitance_nF) {
	sprintf(LCD_BUFF, "C: %.3f nF", capacitance_nF); // Format the Capacitance Value
	LCDprint(LCD_BUFF, 2, 1); // Write to LCD
}

void display_resistance_kOhms(float resistance_kOhms) {
	sprintf(LCD_BUFF, "R: %.3f kOhms", resistance_kOhms); // Format the Resistance Value
	LCDprint(LCD_BUFF, 1, 1); // Write to LCD
	LCDprint("                ", 2, 1); // Clear Second Line
}

float calculate_period_s(int overflow_count, int TH0, int TL0) {
	return ((overflow_count * MAX_16_BIT)  + (TH0 * MAX_8_BIT) + TL0) * (12.0 / SYSCLK);
}

float calculate_freq_Hz(float period_s) {
	return (1.0 / period_s);
}

float calculate_capacitance_nF(float period_s) {
	return (1.44 * period_s / (R_A + 2 * R_B)) * GIGA_MULTIPLIER; // Convert to Nanofarads
}

float calculate_resistance_k0hms(float voltage_across_resistor) {
    float current = ((VSS - voltage_across_resistor) / R_REF) / MEGA_MULTIPLIER; // Calculate Current (Amps)

	// printf("\nVoltage Across Resistor = %f\r\n", voltage_across_resistor); // Print Voltage Across Resistor
	// printf("\nCurrent = %f\r\n", current); // Print Current (Amps)

    return (voltage_across_resistor / current) / KILO_MULTIPLIER; // Calculate Resistance (Kilohms)
}

int Check_Mode_Button(int mode) {
	int current_mode = mode;
	if (MODE_PIN == 0) waitms(50); // De-bounce
	else return current_mode;

    if(MODE_PIN == 0) {
    	while(MODE_PIN==0);

		printf("\rMode: %d\r\n", !current_mode);
		if (mode == MODE_CAPACITANCE) {
			return MODE_RESISTANCE;
		} else {
			return MODE_CAPACITANCE;
		}
    } else {
		return current_mode;
	}
}

void main(void) {
	int mode = MODE_CAPACITANCE;
	float V_LED, V_R, R_kOhms;
	float period_s, freq_Hz, capacitance_nF;
	int success_count = 0;
	// char rx_buff[CHARS_PER_LINE];

	TIMER0_Init(); // Initialize Timer 0
    Serial_Init(); // Initialize Serial Communication
	LCD_4BIT();	// Configure the LCD

	// Initialize ADC
	InitPinADC(2, 1); // Configure P2.1 as Analog Input
	InitADC();

    while(1) {
		mode = Check_Mode_Button(mode);
		// Measure the Voltage at the LED and Resistor
		V_LED = Volts_at_Pin(QFP32_MUX_P0_1); // Measure the Voltage at the LED
		V_R = Volts_at_Pin(QFP32_MUX_P2_1); // Measure the Voltage at the Resistor
		R_kOhms = calculate_resistance_k0hms(V_R);

		// Display the Voltage at the LED and Resistor
		// printf("V_LED = %f\r\n", V_LED); // Print Voltage at the LED
		// printf("V_R = %f\r\n", V_R); // Print Voltage at the Resistor

        // Reset Counter
		TL0 = 0;
		TH0 = 0;
		TF0 = 0;
		overflow_count = 0;

		while (EFM8_SIGNAL != 0); // Wait for Signal == 0
		while (EFM8_SIGNAL != 1); // Wait for Signal == 1

        TR0 = 1; // Start Timer

		while (EFM8_SIGNAL != 0) { // Wait for Signal == 0
			if (TF0 == 1) { // Did 16-Bit Timer Overflow?
				TF0 = 0;
				overflow_count++;
			}
        }
        while (EFM8_SIGNAL != 1) { // Wait for Signal == 1
			if (TF0 == 1) { // Did 16-Bit Timer Overflow?
				TF0 = 0;
				overflow_count++;
			}
        }

		TR0 = 0; // Stop Timer 0. The 24-bit number [overflow_count-TH0-TL0] has the period!
		period_s = calculate_period_s(overflow_count, TH0, TL0);
		freq_Hz = calculate_freq_Hz(period_s);
		capacitance_nF = calculate_capacitance_nF(period_s);

		if ((mode == MODE_RESISTANCE) && (V_R < VDD)) display_resistance_kOhms(R_kOhms);

		// display_rx(rx_buff, sizeof(rx_buff)); // Display User Input on LCD

		/*
		 * Print Frequency & Capacitance to Serial Port. Display on LCD.
		 */

		if ((mode == MODE_CAPACITANCE) && (freq_Hz <= MIN_FREQ_HZ || freq_Hz >= MAX_FREQ_HZ)) {
			success_count = 0;
			if (freq_Hz >= MAX_FREQ_HZ) LCDprint("ERROR : SMALL C", 1, 1);
			else if (freq_Hz <= MIN_FREQ_HZ) LCDprint("ERROR : LARGE C", 1, 1);

			LCDprint("                ", 2, 1);
			waitms(125); // Wait for 125 ms
		} else if ((mode == MODE_RESISTANCE) && (V_R >= VDD)) {
			success_count = 0;
			LCDprint("ERROR : LARGE R", 1, 1);

			LCDprint("                ", 2, 1);
			waitms(250); // Wait for 250 ms
		} else {
			success_count += 1;
		}

		if (success_count >= SUCCESS_THRESHOLD) {
			waitms(200); // Wait for 200 ms
			if (mode == MODE_RESISTANCE) {
				printf("\rR(kOhm) = %f\r\n", R_kOhms); // Print Resistance in Kilohms
			}
			printf("\rF(kHz) = %f\r\n", freq_Hz / KILO_MULTIPLIER); // Print Frequency to Serial Port
			printf("\rC(nF) = %f\r\n", capacitance_nF); // Print Capacitance in Nanofarads

			if (mode == MODE_CAPACITANCE) {
				display_freq_kHz(freq_Hz / KILO_MULTIPLIER); // Display Frequency on LCD
				display_capacitance_nF(capacitance_nF);
			}
		}
	}
}