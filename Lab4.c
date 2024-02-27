/*
 * Lab4.c : EFM8 Period Measurement At Pin P0.1 using Timer 0
 * and Displaying the Frequency and 555 Timer Calculated Capacitance on LCD.
 */

/* Include Headers */
#include <EFM8LB1.h>
#include <stdio.h>

#define MAX_16_BIT 65536.0 // 16-Bit Maximum Value
#define MAX_8_BIT 256.0 // 8-Bit Maximum Value

/* Define Multipliers */
#define KILO_MULTIPLIER 1000.0 // Kilo Multiplier
#define MEGA_MULTIPLIER 1000000.0 // Mega Multiplier
#define GIGA_MULTIPLIER 1000000000.0 // Giga Multiplier
#define TERA_MULTIPLIER 1000000000000.0 // Tera Multiplier

/* Clock Frequency and Baud Rate */
#define SYSCLK    72000000L // SYSCLK Frequency in Hz
#define BAUDRATE    115200L // Baudrate of UART in BPS

/* Define Pins */
#define EFM8_SIGNAL P0_1 // Signal to Measure

#define LCD_RS P1_7 // LCD Register Select
#define LCD_E  P2_0 // LCD Enable

#define LCD_D4 P1_3 // LCD Data 4
#define LCD_D5 P1_2 // LCD Data 5
#define LCD_D6 P1_1 // LCD Data 6
#define LCD_D7 P1_0 // LCD Data 7

/* Define Constants for Resistances */
#define R_A 1.5 * KILO_MULTIPLIER
#define R_B 1.5 * KILO_MULTIPLIER

#define CHARS_PER_LINE 16

unsigned char overflow_count; // Timer 0 Overflow Counter

/*
 * External Startup Function
 */
char _c51_external_startup(void) {
	// Disable Watchdog With Key Sequence
	SFRPAGE = 0x00;
	WDTCN = 0xDE; // First Key
	WDTCN = 0xAD; // Second Key

	VDM0CN |= 0x80;
	RSTSRC = 0x02;

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

void waitms (unsigned int ms) {
	unsigned int j;
	for (j = ms; j != 0; j--) {
		Timer3us(249);
		Timer3us(249);
		Timer3us(249);
		Timer3us(250);
	}
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
	char buff[CHARS_PER_LINE];
	sprintf(buff, "T: %.3f s", period); // Format the Period Value
	LCDprint(buff, 2, 1); // Write to LCD
}

void display_freq_kHz(float freq_kHz) {
	char buff[CHARS_PER_LINE];
	sprintf(buff, "F: %.3f kHz", freq_kHz); // Format the Frequency Value
	LCDprint(buff, 1, 1); // Write to LCD
}

void display_capacitance_nF(float capacitance_nF) {
	char buff[CHARS_PER_LINE];

	sprintf(buff, "C: %.3f nF", capacitance_nF); // Format the Capacitance Value
	LCDprint(buff, 2, 1); // Write to LCD
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

void main(void) {
	float period_s, freq_Hz, capacitance_nF;
	// char rx_buff[CHARS_PER_LINE];

	TIMER0_Init(); // Initialize Timer 0
    Serial_Init(); // Initialize Serial Communication
	LCD_4BIT();	// Configure the LCD

	printf(
        "\rEFM8 Period measurement at pin P0.1 using Timer 0.\n"
	    "File: %s\n"
	    "Compiled: %s, %s\n\r\n",
	    __FILE__, __DATE__, __TIME__
    );

    while(1) {
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

		// display_rx(rx_buff, sizeof(rx_buff)); // Display User Input on LCD

		/*
		 * Print Frequency & Capacitance to Serial Port. Display on LCD.
		 */

		waitms(250); // Wait for 250 ms
		printf("\nF(kHz) = %f\r\n", freq_Hz / KILO_MULTIPLIER); // Print Frequency to Serial Port
		display_freq_kHz(freq_Hz / KILO_MULTIPLIER); // Display Frequency on LCD

		waitms(250); // Wait for 250 ms
		printf("\rC(nF) = %f\r\n", capacitance_nF); // Print Capacitance in Nanofarads
		// printf("C(µF)=%f\r\n", (capacitance_nF / MEGA_MULTIPLIER)); // Print Capacitance in Microfarads

		display_capacitance_nF(capacitance_nF);
	}
}