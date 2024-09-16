// LQFP32 pinout
//                    ----------
//              VDD -|1       32|- VSS
//             PC14 -|2       31|- BOOT0
//             PC15 -|3       30|- PB7
//             NRST -|4       29|- PB6
//             VDDA -|5       28|- PB5
// LCD_RS      PA0 -|6       27|- PB4
// LCD_E       PA1 -|7       26|- PB3
// LCD_D4      PA2 -|8       25|- PA15
// LCD_D5      PA3 -|9       24|- PA14
// LCD_D6      PA4 -|10      23|- PA13
// LCD_D7      PA5 -|11      22|- PA12 Button
//             PA6 -|12      21|- PA11
//             PA7 -|13      20|- PA10 (Reserved for RXD)
//             PB0 -|14      19|- PA9  (Reserved for TXD)
//   (ADC_IN9) PB1 -|15      18|- PA8  (Measure the period at this pin)
//             VSS -|16      17|- VDD
//                    ----------

#include <stdio.h>
#include <stdlib.h>
#include <math.h>

#include "Common/Include/serial.h"
#include "Common/Include/stm32l051xx.h"
#include "lcd.h"

#define F_CPU 32000000L
#define PIN_PERIOD (GPIOA->IDR&BIT8)
#define BUTTON_PIN (GPIOA->IDR&BIT12)

#define MODE_CAPACITANCE 0
#define MODE_RESISTANCE 1

#define CHARS_PER_LINE 16

char LCD_BUFF[CHARS_PER_LINE]; // Buffer for LCD Display
char TX_BUFF[CHARS_PER_LINE+1];
char RX_BUFF[CHARS_PER_LINE+1];

#define MAX_16_BIT 65536.0 // 16-Bit Maximum Value
#define MAX_8_BIT 256.0 // 8-Bit Maximum Value

/* Define Multipliers */
#define KILO_MULTIPLIER 1000.0 // Kilo Multiplier
#define MEGA_MULTIPLIER 1000000.0 // Mega Multiplier
#define GIGA_MULTIPLIER 1000000000.0 // Giga Multiplier
#define TERA_MULTIPLIER 1000000000000.0 // Tera Multiplier

#define MIN_FREQ_HZ 300.0 // Minimum Frequency in Hz
#define MAX_FREQ_HZ 400 * KILO_MULTIPLIER // Maximum Frequency in Hz

#define MIN_CAPACITANCE_NF 1.0 // Minimum Capacitance in Nanofarads
#define MAX_CAPACITANCE_NF 1000.0 // Maximum Capacitance in Nanofarads

#define SUCCESS_THRESHOLD 10 // Success Threshold

/* Define Constants for Resistances */
#define R_A 1.5 * KILO_MULTIPLIER
#define R_B 1.5 * KILO_MULTIPLIER
#define R_REF 98.62 * KILO_MULTIPLIER

#define VSS 3.3 // VSS Voltage

long int GetPeriod(int n);

void ConfigPinsLCD(void);
void InitSystickCounter(void);
void ConfigPinButton(void);
void ConfigPinADC(void);

int Check_Mode_Button(int mode);

float calculate_period_s(int count);
float calculate_freq_Hz(float period_s);
float calculate_capacitance_nF(float period_s);
float calculate_resistance_k0hms(float voltage_across_resistor);

void display_period(float period);
void display_freq_kHz(float freq_kHz);
void display_capacitance_nF(float capacitance_nF);
void display_resistance_kOhms(float resistance_kOhms);

void delay(int dly) {
	while( dly--);
}

void wait_1ms(void) {
	// For SysTick info check the STM32L0xxx Cortex-M0 programming manual page 85.
	SysTick->LOAD = (F_CPU/1000L) - 1;  // set reload register, counter rolls over from zero, hence -1
	SysTick->VAL = 0; // load the SysTick counter
	SysTick->CTRL  = SysTick_CTRL_CLKSOURCE_Msk | SysTick_CTRL_ENABLE_Msk; // Enable SysTick IRQ and SysTick Timer */
	while((SysTick->CTRL & BIT16)==0); // Bit 16 is the COUNTFLAG.  True when counter rolls over from zero.
	SysTick->CTRL = 0x00; // Disable Systick counter
}

void waitms(unsigned int ms) {
	unsigned int j;
	for(j=0; j<ms; j++) wait_1ms();
}

void Delay_us(unsigned char us) {
	// For SysTick info check the STM32L0xxx Cortex-M0 programming manual page 85.
	SysTick->LOAD = (F_CPU/(1000000L/us)) - 1;  // set reload register, counter rolls over from zero, hence -1
	SysTick->VAL = 0; // load the SysTick counter
	SysTick->CTRL  = SysTick_CTRL_CLKSOURCE_Msk | SysTick_CTRL_ENABLE_Msk; // Enable SysTick IRQ and SysTick Timer */
	while((SysTick->CTRL & BIT16)==0); // Bit 16 is the COUNTFLAG.  True when counter rolls over from zero.
	SysTick->CTRL = 0x00; // Disable Systick counter
}

/*
 * GetPeriod() seems to work fine for frequencies between 300Hz and 600kHz.
 *'n' is used to measure the time of 'n' periods; this increases accuracy.
 */
long int GetPeriod(int n) {
	int i;
	unsigned int saved_TCNT1a, saved_TCNT1b;

	SysTick->LOAD = 0xffffff;  // 24-bit counter set to check for signal present
	SysTick->VAL = 0xffffff; // load the SysTick counter
	SysTick->CTRL  = SysTick_CTRL_CLKSOURCE_Msk | SysTick_CTRL_ENABLE_Msk; // Enable SysTick IRQ and SysTick Timer */
	while (PIN_PERIOD!=0) // Wait for square wave to be 0
	{
		if(SysTick->CTRL & BIT16) return 0;
	}
	SysTick->CTRL = 0x00; // Disable Systick counter

	SysTick->LOAD = 0xffffff;  // 24-bit counter set to check for signal present
	SysTick->VAL = 0xffffff; // load the SysTick counter
	SysTick->CTRL  = SysTick_CTRL_CLKSOURCE_Msk | SysTick_CTRL_ENABLE_Msk; // Enable SysTick IRQ and SysTick Timer */
	while (PIN_PERIOD==0) // Wait for square wave to be 1
	{
		if(SysTick->CTRL & BIT16) return 0;
	}
	SysTick->CTRL = 0x00; // Disable Systick counter

	SysTick->LOAD = 0xffffff;  // 24-bit counter reset
	SysTick->VAL = 0xffffff; // load the SysTick counter to initial value
	SysTick->CTRL  = SysTick_CTRL_CLKSOURCE_Msk | SysTick_CTRL_ENABLE_Msk; // Enable SysTick IRQ and SysTick Timer */
	for (i=0; i<n; i++) { // Measure the time of 'n' periods
		while (PIN_PERIOD!=0) { // Wait for square wave to be 0
			if (SysTick->CTRL & BIT16) return 0;
		}
		while (PIN_PERIOD==0) { // Wait for square wave to be 1
			if (SysTick->CTRL & BIT16) return 0;
		}
	}
	SysTick->CTRL = 0x00; // Disable Systick counter

	return 0xffffff-SysTick->VAL;
}

void initADC(void) {
	RCC->APB2ENR |= BIT9; // peripheral clock enable for ADC (page 175 or RM0451)

	// ADC clock selection procedure (page 746 of RM0451)
	/* (1) Select PCLK by writing 11 in CKMODE */
	ADC1->CFGR2 |= ADC_CFGR2_CKMODE; /* (1) */

	// ADC enable sequence procedure (page 745 of RM0451)
	/* (1) Clear the ADRDY bit */
	/* (2) Enable the ADC */
	/* (3) Wait until ADC ready */
	ADC1->ISR |= ADC_ISR_ADRDY; /* (1) */
	ADC1->CR |= ADC_CR_ADEN; /* (2) */
	if ((ADC1->CFGR1 & ADC_CFGR1_AUTOFF) == 0)
	{
		while ((ADC1->ISR & ADC_ISR_ADRDY) == 0) /* (3) */
		{
			/* For robust implementation, add here time-out management */
		}
	}

	// Calibration code procedure (page 745 of RM0451)
	/* (1) Ensure that ADEN = 0 */
	/* (2) Clear ADEN */
	/* (3) Set ADCAL=1 */
	/* (4) Wait until EOCAL=1 */
	/* (5) Clear EOCAL */
	if ((ADC1->CR & ADC_CR_ADEN) != 0) /* (1) */
	{
		ADC1->CR |= ADC_CR_ADDIS; /* (2) */
	}
	ADC1->CR |= ADC_CR_ADCAL; /* (3) */
	while ((ADC1->ISR & ADC_ISR_EOCAL) == 0) /* (4) */
	{
		/* For robust implementation, add here time-out management */
	}
	ADC1->ISR |= ADC_ISR_EOCAL; /* (5) */
}

int readADC(unsigned int channel) {
	// Single conversion sequence code example - Software trigger (page 746 of RM0451)
	/* (1) Select HSI16 by writing 00 in CKMODE (reset value) */
	/* (2) Select the auto off mode */
	/* (3) Select channel */
	/* (4) Select a sampling mode of 111 i.e. 239.5 ADC clk to be greater than17.1us */
	/* (5) Wake-up the VREFINT (only for VRefInt) */
	//ADC1->CFGR2 &= ~ADC_CFGR2_CKMODE; /* (1) */
	ADC1->CFGR1 |= ADC_CFGR1_AUTOFF; /* (2) */
	ADC1->CHSELR = channel; /* (3) */
	ADC1->SMPR |= ADC_SMPR_SMP_0 | ADC_SMPR_SMP_1 | ADC_SMPR_SMP_2; /* (4) */
	if(channel==ADC_CHSELR_CHSEL17)
	{
		ADC->CCR |= ADC_CCR_VREFEN; /* (5) */
	}

	/* Performs the AD conversion */
	ADC1->CR |= ADC_CR_ADSTART; /* start the ADC conversion */
	while ((ADC1->ISR & ADC_ISR_EOC) == 0) /* wait end of conversion */
	{
		/* For robust implementation, add here time-out management */
	}

	return ADC1->DR; // ADC_DR has the 12 bits out of the ADC
}

float Volts_at_Pin(uint32_t ch) {
	return readADC(ch) * VSS/0x1000;
}


void ConfigPinsLCD(void) {
	RCC->IOPENR |= BIT0; // peripheral clock enable for port A

	// Make pins PA0 to PA5 outputs (page 200 of RM0451, two bits used to configure: bit0=1, bit1=0)
    GPIOA->MODER = (GPIOA->MODER & ~(BIT0|BIT1)) | BIT0; // PA0
	GPIOA->OTYPER &= ~BIT0; // Push-pull

    GPIOA->MODER = (GPIOA->MODER & ~(BIT2|BIT3)) | BIT2; // PA1
	GPIOA->OTYPER &= ~BIT1; // Push-pull

    GPIOA->MODER = (GPIOA->MODER & ~(BIT4|BIT5)) | BIT4; // PA2
	GPIOA->OTYPER &= ~BIT2; // Push-pull

    GPIOA->MODER = (GPIOA->MODER & ~(BIT6|BIT7)) | BIT6; // PA3
	GPIOA->OTYPER &= ~BIT3; // Push-pull

    GPIOA->MODER = (GPIOA->MODER & ~(BIT8|BIT9)) | BIT8; // PA4
	GPIOA->OTYPER &= ~BIT4; // Push-pull

    GPIOA->MODER = (GPIOA->MODER & ~(BIT10|BIT11)) | BIT10; // PA5
	GPIOA->OTYPER &= ~BIT5; // Push-pull
}

void InitSystickCounter() {
	RCC->IOPENR |= RCC_IOPENR_GPIOAEN; // Peripheral Clock Enable for Port A

	GPIOA->MODER &= ~(BIT16 | BIT17); // Make Pin PA8 Input

	// Activate Pull-Up Resistor for Pin PA8
	GPIOA->PUPDR |= BIT16;
	GPIOA->PUPDR &= ~(BIT17);
}

void ConfigPinButton() {
	RCC->IOPENR |= RCC_IOPENR_GPIOAEN; // Peripheral Clock Enable for Port A

	GPIOA->MODER &= ~(BIT24 | BIT25); // Make Pin PA12 Input

	// Activate Pull-Up Resistor for Pin PA12
	GPIOA->PUPDR |= BIT24;
	GPIOA->PUPDR &= ~(BIT25);
}

void ConfigPinADC(void) {
	// Configure the pin used for analog input: PB1 (pin 15)
	RCC->IOPENR  |= BIT1;         // peripheral clock enable for port B
	GPIOB->MODER |= (BIT2|BIT3);  // Select analog mode for PB1 (pin 15 of LQFP32 package)
}

void LCD_pulse(void) {
	LCD_E_1;
	Delay_us(40);
	LCD_E_0;
}

void LCD_byte(unsigned char x) {
	//Send high nible
	if(x&0x80) LCD_D7_1; else LCD_D7_0;
	if(x&0x40) LCD_D6_1; else LCD_D6_0;
	if(x&0x20) LCD_D5_1; else LCD_D5_0;
	if(x&0x10) LCD_D4_1; else LCD_D4_0;
	LCD_pulse();
	Delay_us(40);
	//Send low nible
	if(x&0x08) LCD_D7_1; else LCD_D7_0;
	if(x&0x04) LCD_D6_1; else LCD_D6_0;
	if(x&0x02) LCD_D5_1; else LCD_D5_0;
	if(x&0x01) LCD_D4_1; else LCD_D4_0;
	LCD_pulse();
}

void WriteData (unsigned char x) {
	LCD_RS_1;
	LCD_byte(x);
	waitms(2);
}

void WriteCommand (unsigned char x) {
	LCD_RS_0;
	LCD_byte(x);
	waitms(5);
}

void LCD_4BIT(void) {
	LCD_E_0; // Resting state of LCD's enable is zero
	//LCD_RW=0; // We are only writing to the LCD in this program
	waitms(20);
	// First make sure the LCD is in 8-bit mode and then change to 4-bit mode
	WriteCommand(0x33);
	WriteCommand(0x33);
	WriteCommand(0x32); // Change to 4-bit mode

	// Configure the LCD
	WriteCommand(0x28);
	WriteCommand(0x0c);
	WriteCommand(0x01); // Clear screen command (takes some time)
	waitms(20); // Wait for clear screen command to finsih.
}

void LCDprint(char * string, unsigned char line, unsigned char clear) {
	int j;

	WriteCommand(line==2?0xc0:0x80);
	waitms(5);
	for(j=0; string[j]!=0; j++)	WriteData(string[j]);// Write the message
	if(clear) for(; j<CHARS_PER_LINE; j++) WriteData(' '); // Clear the rest of the line
}

void display_rx() {
	printf("Send to LCD (16 Char Mac): ");
	fflush(stdout); // GCC peculiarities: need to flush stdout to get string out without a '\n'
	egets_echo(RX_BUFF, sizeof(RX_BUFF));

	printf("\r\n");
	for (int i=0; i<sizeof(RX_BUFF); i++) {
		if (RX_BUFF[i]=='\n') RX_BUFF[i]=0;
		if (RX_BUFF[i]=='\r') RX_BUFF[i]=0;
	}

	sprintf(LCD_BUFF, "%s", RX_BUFF);

	LCDprint(LCD_BUFF, 2, 1);
}

int Check_Mode_Button(int mode) {
	int current_mode = mode;
	if (BUTTON_PIN == 0) waitms(20); // De-bounce
	else return current_mode;

    if (BUTTON_PIN == 0) {
    	while(BUTTON_PIN == 0);

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

float calculate_period_s(int count) {
	return count / (F_CPU * 100.0); // Calculate Period (Seconds)
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
}

void main(void) {
	long int count;

	int mode = MODE_CAPACITANCE;
	float V_R, R_kOhms;
	float period_s, freq_Hz, capacitance_nF;
	int success_count = 0;

	ConfigPinsLCD();
	LCD_4BIT();
	InitSystickCounter();
	ConfigPinButton();
	ConfigPinADC();

	initADC();

	waitms(500); // Wait for putty to start.
	printf("\x1b[2J\x1b[1;1H"); // Clear screen using ANSI escape sequence.
	printf("Connect Signal to PA8 (Pin 18).\r\n");

	while (1) {
		mode = Check_Mode_Button(mode);
		// display_rx();

		V_R = Volts_at_Pin(ADC_CHSELR_CHSEL9);
		R_kOhms = calculate_resistance_k0hms(V_R);

		count = GetPeriod(100);
		period_s = calculate_period_s(count);
		freq_Hz = calculate_freq_Hz(period_s);
		capacitance_nF = calculate_capacitance_nF(period_s);

		/*
		 * Print Frequency & Capacitance to Serial Port. Display on LCD.
		 */
		if ((mode == MODE_CAPACITANCE) && (freq_Hz <= MIN_FREQ_HZ || freq_Hz >= MAX_FREQ_HZ)) {
			success_count = 0;
			if (freq_Hz >= MAX_FREQ_HZ) LCDprint("ERROR : SMALL C", 1, 1);
			else if (freq_Hz <= MIN_FREQ_HZ) LCDprint("ERROR : LARGE C", 1, 1);

			LCDprint("                ", 2, 1);
			waitms(125); // Wait for 125 ms
		} else if ((mode == MODE_RESISTANCE) && (V_R >= VSS)) {
			success_count = 0;
			LCDprint("ERROR : LARGE R", 1, 1);

			LCDprint("                ", 2, 1);
			waitms(250); // Wait for 250 ms
		} else {
			success_count += 1;
		}

		if ((mode == MODE_RESISTANCE) && (V_R < VSS)) display_resistance_kOhms(R_kOhms);
		if (success_count >= SUCCESS_THRESHOLD) {
			waitms(200); // Wait for 200 ms
			display_capacitance_nF(capacitance_nF);

			printf("R(kOhm) = %f\r\n", R_kOhms); // Print Resistance in Kilohms
			printf("F(kHz) = %f\r\n", freq_Hz / KILO_MULTIPLIER); // Print Frequency to Serial Port
			printf("C(nF) = %f\r\n", capacitance_nF); // Print Capacitance in Nanofarads

			if (mode == MODE_CAPACITANCE) {
				display_freq_kHz(freq_Hz / KILO_MULTIPLIER); // Display Frequency on LCD
			}
		}

		fflush(stdout); // GCC printf wants a \n in order to send something.  If \n is not present, we fflush(stdout)
		waitms(200);
	}
}
