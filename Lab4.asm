;--------------------------------------------------------
; File Created by C51
; Version 1.0.0 #1170 (Feb 16 2022) (MSVC)
; This file was generated Wed Feb 28 18:42:31 2024
;--------------------------------------------------------
$name Lab4
$optc51 --model-small
$printf_float
	R_DSEG    segment data
	R_CSEG    segment code
	R_BSEG    segment bit
	R_XSEG    segment xdata
	R_PSEG    segment xdata
	R_ISEG    segment idata
	R_OSEG    segment data overlay
	BIT_BANK  segment data overlay
	R_HOME    segment code
	R_GSINIT  segment code
	R_IXSEG   segment xdata
	R_CONST   segment code
	R_XINIT   segment code
	R_DINIT   segment code

;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	public _InitPinADC_PARM_2
	public _main
	public _Check_Mode_Button
	public _calculate_resistance_k0hms
	public _calculate_capacitance_nF
	public _calculate_freq_Hz
	public _calculate_period_s
	public _display_resistance_kOhms
	public _display_capacitance_nF
	public _display_freq_kHz
	public _display_period
	public _display_rx
	public _write_rx
	public _LCDprint
	public _LCD_4BIT
	public _WriteCommand
	public _WriteData
	public _LCD_byte
	public _LCD_pulse
	public _Serial_Init
	public _TIMER0_Init
	public _waitms
	public _Timer3us
	public _Volts_at_Pin
	public _ADC_at_Pin
	public _InitPinADC
	public _InitADC
	public __c51_external_startup
	public _LCDprint_PARM_3
	public _calculate_period_s_PARM_3
	public _calculate_period_s_PARM_2
	public _display_rx_PARM_2
	public _write_rx_PARM_2
	public _LCDprint_PARM_2
	public _LCD_BUFF
	public _overflow_count
;--------------------------------------------------------
; Special Function Registers
;--------------------------------------------------------
_ACC            DATA 0xe0
_ADC0ASAH       DATA 0xb6
_ADC0ASAL       DATA 0xb5
_ADC0ASCF       DATA 0xa1
_ADC0ASCT       DATA 0xc7
_ADC0CF0        DATA 0xbc
_ADC0CF1        DATA 0xb9
_ADC0CF2        DATA 0xdf
_ADC0CN0        DATA 0xe8
_ADC0CN1        DATA 0xb2
_ADC0CN2        DATA 0xb3
_ADC0GTH        DATA 0xc4
_ADC0GTL        DATA 0xc3
_ADC0H          DATA 0xbe
_ADC0L          DATA 0xbd
_ADC0LTH        DATA 0xc6
_ADC0LTL        DATA 0xc5
_ADC0MX         DATA 0xbb
_B              DATA 0xf0
_CKCON0         DATA 0x8e
_CKCON1         DATA 0xa6
_CLEN0          DATA 0xc6
_CLIE0          DATA 0xc7
_CLIF0          DATA 0xe8
_CLKSEL         DATA 0xa9
_CLOUT0         DATA 0xd1
_CLU0CF         DATA 0xb1
_CLU0FN         DATA 0xaf
_CLU0MX         DATA 0x84
_CLU1CF         DATA 0xb3
_CLU1FN         DATA 0xb2
_CLU1MX         DATA 0x85
_CLU2CF         DATA 0xb6
_CLU2FN         DATA 0xb5
_CLU2MX         DATA 0x91
_CLU3CF         DATA 0xbf
_CLU3FN         DATA 0xbe
_CLU3MX         DATA 0xae
_CMP0CN0        DATA 0x9b
_CMP0CN1        DATA 0x99
_CMP0MD         DATA 0x9d
_CMP0MX         DATA 0x9f
_CMP1CN0        DATA 0xbf
_CMP1CN1        DATA 0xac
_CMP1MD         DATA 0xab
_CMP1MX         DATA 0xaa
_CRC0CN0        DATA 0xce
_CRC0CN1        DATA 0x86
_CRC0CNT        DATA 0xd3
_CRC0DAT        DATA 0xcb
_CRC0FLIP       DATA 0xcf
_CRC0IN         DATA 0xca
_CRC0ST         DATA 0xd2
_DAC0CF0        DATA 0x91
_DAC0CF1        DATA 0x92
_DAC0H          DATA 0x85
_DAC0L          DATA 0x84
_DAC1CF0        DATA 0x93
_DAC1CF1        DATA 0x94
_DAC1H          DATA 0x8a
_DAC1L          DATA 0x89
_DAC2CF0        DATA 0x95
_DAC2CF1        DATA 0x96
_DAC2H          DATA 0x8c
_DAC2L          DATA 0x8b
_DAC3CF0        DATA 0x9a
_DAC3CF1        DATA 0x9c
_DAC3H          DATA 0x8e
_DAC3L          DATA 0x8d
_DACGCF0        DATA 0x88
_DACGCF1        DATA 0x98
_DACGCF2        DATA 0xa2
_DERIVID        DATA 0xad
_DEVICEID       DATA 0xb5
_DPH            DATA 0x83
_DPL            DATA 0x82
_EIE1           DATA 0xe6
_EIE2           DATA 0xf3
_EIP1           DATA 0xbb
_EIP1H          DATA 0xee
_EIP2           DATA 0xed
_EIP2H          DATA 0xf6
_EMI0CN         DATA 0xe7
_FLKEY          DATA 0xb7
_HFO0CAL        DATA 0xc7
_HFO1CAL        DATA 0xd6
_HFOCN          DATA 0xef
_I2C0ADM        DATA 0xff
_I2C0CN0        DATA 0xba
_I2C0DIN        DATA 0xbc
_I2C0DOUT       DATA 0xbb
_I2C0FCN0       DATA 0xad
_I2C0FCN1       DATA 0xab
_I2C0FCT        DATA 0xf5
_I2C0SLAD       DATA 0xbd
_I2C0STAT       DATA 0xb9
_IE             DATA 0xa8
_IP             DATA 0xb8
_IPH            DATA 0xf2
_IT01CF         DATA 0xe4
_LFO0CN         DATA 0xb1
_P0             DATA 0x80
_P0MASK         DATA 0xfe
_P0MAT          DATA 0xfd
_P0MDIN         DATA 0xf1
_P0MDOUT        DATA 0xa4
_P0SKIP         DATA 0xd4
_P1             DATA 0x90
_P1MASK         DATA 0xee
_P1MAT          DATA 0xed
_P1MDIN         DATA 0xf2
_P1MDOUT        DATA 0xa5
_P1SKIP         DATA 0xd5
_P2             DATA 0xa0
_P2MASK         DATA 0xfc
_P2MAT          DATA 0xfb
_P2MDIN         DATA 0xf3
_P2MDOUT        DATA 0xa6
_P2SKIP         DATA 0xcc
_P3             DATA 0xb0
_P3MDIN         DATA 0xf4
_P3MDOUT        DATA 0x9c
_PCA0CENT       DATA 0x9e
_PCA0CLR        DATA 0x9c
_PCA0CN0        DATA 0xd8
_PCA0CPH0       DATA 0xfc
_PCA0CPH1       DATA 0xea
_PCA0CPH2       DATA 0xec
_PCA0CPH3       DATA 0xf5
_PCA0CPH4       DATA 0x85
_PCA0CPH5       DATA 0xde
_PCA0CPL0       DATA 0xfb
_PCA0CPL1       DATA 0xe9
_PCA0CPL2       DATA 0xeb
_PCA0CPL3       DATA 0xf4
_PCA0CPL4       DATA 0x84
_PCA0CPL5       DATA 0xdd
_PCA0CPM0       DATA 0xda
_PCA0CPM1       DATA 0xdb
_PCA0CPM2       DATA 0xdc
_PCA0CPM3       DATA 0xae
_PCA0CPM4       DATA 0xaf
_PCA0CPM5       DATA 0xcc
_PCA0H          DATA 0xfa
_PCA0L          DATA 0xf9
_PCA0MD         DATA 0xd9
_PCA0POL        DATA 0x96
_PCA0PWM        DATA 0xf7
_PCON0          DATA 0x87
_PCON1          DATA 0xcd
_PFE0CN         DATA 0xc1
_PRTDRV         DATA 0xf6
_PSCTL          DATA 0x8f
_PSTAT0         DATA 0xaa
_PSW            DATA 0xd0
_REF0CN         DATA 0xd1
_REG0CN         DATA 0xc9
_REVID          DATA 0xb6
_RSTSRC         DATA 0xef
_SBCON1         DATA 0x94
_SBRLH1         DATA 0x96
_SBRLL1         DATA 0x95
_SBUF           DATA 0x99
_SBUF0          DATA 0x99
_SBUF1          DATA 0x92
_SCON           DATA 0x98
_SCON0          DATA 0x98
_SCON1          DATA 0xc8
_SFRPAGE        DATA 0xa7
_SFRPGCN        DATA 0xbc
_SFRSTACK       DATA 0xd7
_SMB0ADM        DATA 0xd6
_SMB0ADR        DATA 0xd7
_SMB0CF         DATA 0xc1
_SMB0CN0        DATA 0xc0
_SMB0DAT        DATA 0xc2
_SMB0FCN0       DATA 0xc3
_SMB0FCN1       DATA 0xc4
_SMB0FCT        DATA 0xef
_SMB0RXLN       DATA 0xc5
_SMB0TC         DATA 0xac
_SMOD1          DATA 0x93
_SP             DATA 0x81
_SPI0CFG        DATA 0xa1
_SPI0CKR        DATA 0xa2
_SPI0CN0        DATA 0xf8
_SPI0DAT        DATA 0xa3
_SPI0FCN0       DATA 0x9a
_SPI0FCN1       DATA 0x9b
_SPI0FCT        DATA 0xf7
_SPI0PCF        DATA 0xdf
_TCON           DATA 0x88
_TH0            DATA 0x8c
_TH1            DATA 0x8d
_TL0            DATA 0x8a
_TL1            DATA 0x8b
_TMOD           DATA 0x89
_TMR2CN0        DATA 0xc8
_TMR2CN1        DATA 0xfd
_TMR2H          DATA 0xcf
_TMR2L          DATA 0xce
_TMR2RLH        DATA 0xcb
_TMR2RLL        DATA 0xca
_TMR3CN0        DATA 0x91
_TMR3CN1        DATA 0xfe
_TMR3H          DATA 0x95
_TMR3L          DATA 0x94
_TMR3RLH        DATA 0x93
_TMR3RLL        DATA 0x92
_TMR4CN0        DATA 0x98
_TMR4CN1        DATA 0xff
_TMR4H          DATA 0xa5
_TMR4L          DATA 0xa4
_TMR4RLH        DATA 0xa3
_TMR4RLL        DATA 0xa2
_TMR5CN0        DATA 0xc0
_TMR5CN1        DATA 0xf1
_TMR5H          DATA 0xd5
_TMR5L          DATA 0xd4
_TMR5RLH        DATA 0xd3
_TMR5RLL        DATA 0xd2
_UART0PCF       DATA 0xd9
_UART1FCN0      DATA 0x9d
_UART1FCN1      DATA 0xd8
_UART1FCT       DATA 0xfa
_UART1LIN       DATA 0x9e
_UART1PCF       DATA 0xda
_VDM0CN         DATA 0xff
_WDTCN          DATA 0x97
_XBR0           DATA 0xe1
_XBR1           DATA 0xe2
_XBR2           DATA 0xe3
_XOSC0CN        DATA 0x86
_DPTR           DATA 0x8382
_TMR2RL         DATA 0xcbca
_TMR3RL         DATA 0x9392
_TMR4RL         DATA 0xa3a2
_TMR5RL         DATA 0xd3d2
_TMR0           DATA 0x8c8a
_TMR1           DATA 0x8d8b
_TMR2           DATA 0xcfce
_TMR3           DATA 0x9594
_TMR4           DATA 0xa5a4
_TMR5           DATA 0xd5d4
_SBRL1          DATA 0x9695
_PCA0           DATA 0xfaf9
_PCA0CP0        DATA 0xfcfb
_PCA0CP1        DATA 0xeae9
_PCA0CP2        DATA 0xeceb
_PCA0CP3        DATA 0xf5f4
_PCA0CP4        DATA 0x8584
_PCA0CP5        DATA 0xdedd
_ADC0ASA        DATA 0xb6b5
_ADC0GT         DATA 0xc4c3
_ADC0           DATA 0xbebd
_ADC0LT         DATA 0xc6c5
_DAC0           DATA 0x8584
_DAC1           DATA 0x8a89
_DAC2           DATA 0x8c8b
_DAC3           DATA 0x8e8d
;--------------------------------------------------------
; special function bits
;--------------------------------------------------------
_ACC_0          BIT 0xe0
_ACC_1          BIT 0xe1
_ACC_2          BIT 0xe2
_ACC_3          BIT 0xe3
_ACC_4          BIT 0xe4
_ACC_5          BIT 0xe5
_ACC_6          BIT 0xe6
_ACC_7          BIT 0xe7
_TEMPE          BIT 0xe8
_ADGN0          BIT 0xe9
_ADGN1          BIT 0xea
_ADWINT         BIT 0xeb
_ADBUSY         BIT 0xec
_ADINT          BIT 0xed
_IPOEN          BIT 0xee
_ADEN           BIT 0xef
_B_0            BIT 0xf0
_B_1            BIT 0xf1
_B_2            BIT 0xf2
_B_3            BIT 0xf3
_B_4            BIT 0xf4
_B_5            BIT 0xf5
_B_6            BIT 0xf6
_B_7            BIT 0xf7
_C0FIF          BIT 0xe8
_C0RIF          BIT 0xe9
_C1FIF          BIT 0xea
_C1RIF          BIT 0xeb
_C2FIF          BIT 0xec
_C2RIF          BIT 0xed
_C3FIF          BIT 0xee
_C3RIF          BIT 0xef
_D1SRC0         BIT 0x88
_D1SRC1         BIT 0x89
_D1AMEN         BIT 0x8a
_D01REFSL       BIT 0x8b
_D3SRC0         BIT 0x8c
_D3SRC1         BIT 0x8d
_D3AMEN         BIT 0x8e
_D23REFSL       BIT 0x8f
_D0UDIS         BIT 0x98
_D1UDIS         BIT 0x99
_D2UDIS         BIT 0x9a
_D3UDIS         BIT 0x9b
_EX0            BIT 0xa8
_ET0            BIT 0xa9
_EX1            BIT 0xaa
_ET1            BIT 0xab
_ES0            BIT 0xac
_ET2            BIT 0xad
_ESPI0          BIT 0xae
_EA             BIT 0xaf
_PX0            BIT 0xb8
_PT0            BIT 0xb9
_PX1            BIT 0xba
_PT1            BIT 0xbb
_PS0            BIT 0xbc
_PT2            BIT 0xbd
_PSPI0          BIT 0xbe
_P0_0           BIT 0x80
_P0_1           BIT 0x81
_P0_2           BIT 0x82
_P0_3           BIT 0x83
_P0_4           BIT 0x84
_P0_5           BIT 0x85
_P0_6           BIT 0x86
_P0_7           BIT 0x87
_P1_0           BIT 0x90
_P1_1           BIT 0x91
_P1_2           BIT 0x92
_P1_3           BIT 0x93
_P1_4           BIT 0x94
_P1_5           BIT 0x95
_P1_6           BIT 0x96
_P1_7           BIT 0x97
_P2_0           BIT 0xa0
_P2_1           BIT 0xa1
_P2_2           BIT 0xa2
_P2_3           BIT 0xa3
_P2_4           BIT 0xa4
_P2_5           BIT 0xa5
_P2_6           BIT 0xa6
_P3_0           BIT 0xb0
_P3_1           BIT 0xb1
_P3_2           BIT 0xb2
_P3_3           BIT 0xb3
_P3_4           BIT 0xb4
_P3_7           BIT 0xb7
_CCF0           BIT 0xd8
_CCF1           BIT 0xd9
_CCF2           BIT 0xda
_CCF3           BIT 0xdb
_CCF4           BIT 0xdc
_CCF5           BIT 0xdd
_CR             BIT 0xde
_CF             BIT 0xdf
_PARITY         BIT 0xd0
_F1             BIT 0xd1
_OV             BIT 0xd2
_RS0            BIT 0xd3
_RS1            BIT 0xd4
_F0             BIT 0xd5
_AC             BIT 0xd6
_CY             BIT 0xd7
_RI             BIT 0x98
_TI             BIT 0x99
_RB8            BIT 0x9a
_TB8            BIT 0x9b
_REN            BIT 0x9c
_CE             BIT 0x9d
_SMODE          BIT 0x9e
_RI1            BIT 0xc8
_TI1            BIT 0xc9
_RBX1           BIT 0xca
_TBX1           BIT 0xcb
_REN1           BIT 0xcc
_PERR1          BIT 0xcd
_OVR1           BIT 0xce
_SI             BIT 0xc0
_ACK            BIT 0xc1
_ARBLOST        BIT 0xc2
_ACKRQ          BIT 0xc3
_STO            BIT 0xc4
_STA            BIT 0xc5
_TXMODE         BIT 0xc6
_MASTER         BIT 0xc7
_SPIEN          BIT 0xf8
_TXNF           BIT 0xf9
_NSSMD0         BIT 0xfa
_NSSMD1         BIT 0xfb
_RXOVRN         BIT 0xfc
_MODF           BIT 0xfd
_WCOL           BIT 0xfe
_SPIF           BIT 0xff
_IT0            BIT 0x88
_IE0            BIT 0x89
_IT1            BIT 0x8a
_IE1            BIT 0x8b
_TR0            BIT 0x8c
_TF0            BIT 0x8d
_TR1            BIT 0x8e
_TF1            BIT 0x8f
_T2XCLK0        BIT 0xc8
_T2XCLK1        BIT 0xc9
_TR2            BIT 0xca
_T2SPLIT        BIT 0xcb
_TF2CEN         BIT 0xcc
_TF2LEN         BIT 0xcd
_TF2L           BIT 0xce
_TF2H           BIT 0xcf
_T4XCLK0        BIT 0x98
_T4XCLK1        BIT 0x99
_TR4            BIT 0x9a
_T4SPLIT        BIT 0x9b
_TF4CEN         BIT 0x9c
_TF4LEN         BIT 0x9d
_TF4L           BIT 0x9e
_TF4H           BIT 0x9f
_T5XCLK0        BIT 0xc0
_T5XCLK1        BIT 0xc1
_TR5            BIT 0xc2
_T5SPLIT        BIT 0xc3
_TF5CEN         BIT 0xc4
_TF5LEN         BIT 0xc5
_TF5L           BIT 0xc6
_TF5H           BIT 0xc7
_RIE            BIT 0xd8
_RXTO0          BIT 0xd9
_RXTO1          BIT 0xda
_RFRQ           BIT 0xdb
_TIE            BIT 0xdc
_TXHOLD         BIT 0xdd
_TXNF1          BIT 0xde
_TFRQ           BIT 0xdf
;--------------------------------------------------------
; overlayable register banks
;--------------------------------------------------------
	rbank0 segment data overlay
;--------------------------------------------------------
; internal ram data
;--------------------------------------------------------
	rseg R_DSEG
_overflow_count:
	ds 1
_LCD_BUFF:
	ds 16
_LCDprint_PARM_2:
	ds 1
_write_rx_PARM_2:
	ds 2
_write_rx_buff_1_55:
	ds 3
_write_rx_sloc0_1_0:
	ds 2
_display_rx_PARM_2:
	ds 2
_calculate_period_s_PARM_2:
	ds 2
_calculate_period_s_PARM_3:
	ds 2
_main_mode_1_85:
	ds 2
_main_V_R_1_85:
	ds 4
_main_R_kOhms_1_85:
	ds 4
_main_period_s_1_85:
	ds 4
_main_capacitance_nF_1_85:
	ds 4
_main_success_count_1_85:
	ds 2
;--------------------------------------------------------
; overlayable items in internal ram 
;--------------------------------------------------------
	rseg	R_OSEG
_InitPinADC_PARM_2:
	ds 1
	rseg	R_OSEG
	rseg	R_OSEG
;--------------------------------------------------------
; indirectly addressable internal ram data
;--------------------------------------------------------
	rseg R_ISEG
;--------------------------------------------------------
; absolute internal ram data
;--------------------------------------------------------
	DSEG
;--------------------------------------------------------
; bit data
;--------------------------------------------------------
	rseg R_BSEG
_LCDprint_PARM_3:
	DBIT	1
;--------------------------------------------------------
; paged external ram data
;--------------------------------------------------------
	rseg R_PSEG
;--------------------------------------------------------
; external ram data
;--------------------------------------------------------
	rseg R_XSEG
;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	XSEG
;--------------------------------------------------------
; external initialized ram data
;--------------------------------------------------------
	rseg R_IXSEG
	rseg R_HOME
	rseg R_GSINIT
	rseg R_CSEG
;--------------------------------------------------------
; Reset entry point and interrupt vectors
;--------------------------------------------------------
	CSEG at 0x0000
	ljmp	_crt0
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	rseg R_HOME
	rseg R_GSINIT
	rseg R_GSINIT
;--------------------------------------------------------
; data variables initialization
;--------------------------------------------------------
	rseg R_DINIT
	; The linker places a 'ret' at the end of segment R_DINIT.
;--------------------------------------------------------
; code
;--------------------------------------------------------
	rseg R_CSEG
;------------------------------------------------------------
;Allocation info for local variables in function '_c51_external_startup'
;------------------------------------------------------------
;------------------------------------------------------------
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:67: char _c51_external_startup(void) {
;	-----------------------------------------
;	 function _c51_external_startup
;	-----------------------------------------
__c51_external_startup:
	using	0
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:69: SFRPAGE = 0x00;
	mov	_SFRPAGE,#0x00
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:70: WDTCN = 0xDE; // First Key
	mov	_WDTCN,#0xDE
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:71: WDTCN = 0xAD; // Second Key
	mov	_WDTCN,#0xAD
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:73: VDM0CN |= 0x80;
	orl	_VDM0CN,#0x80
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:74: RSTSRC=0x02|0x04;  // Enable Reset on Missing Clock Detector and VDD
	mov	_RSTSRC,#0x06
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:82: SFRPAGE = 0x10;
	mov	_SFRPAGE,#0x10
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:83: PFE0CN  = 0x20; // SYSCLK < 75 MHz.
	mov	_PFE0CN,#0x20
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:84: SFRPAGE = 0x00;
	mov	_SFRPAGE,#0x00
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:106: CLKSEL = 0x00;
	mov	_CLKSEL,#0x00
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:107: CLKSEL = 0x00;
	mov	_CLKSEL,#0x00
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:108: while ((CLKSEL & 0x80) == 0);
L002001?:
	mov	a,_CLKSEL
	jnb	acc.7,L002001?
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:109: CLKSEL = 0x03;
	mov	_CLKSEL,#0x03
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:110: CLKSEL = 0x03;
	mov	_CLKSEL,#0x03
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:111: while ((CLKSEL & 0x80) == 0);
L002004?:
	mov	a,_CLKSEL
	jnb	acc.7,L002004?
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:116: P0MDOUT |= 0x10; // Enable UART0 TX As Push-Pull Output
	orl	_P0MDOUT,#0x10
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:117: XBR0     = 0x01; // Enable UART0 on P0.4 (TX) and P0.5 (RX)
	mov	_XBR0,#0x01
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:118: XBR1     = 0X00; // Enable T0 on P0.0
	mov	_XBR1,#0x00
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:119: XBR2     = 0x40; // Enable Crossbar and Weak Pull-Ups
	mov	_XBR2,#0x40
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:126: SCON0 = 0x10;
	mov	_SCON0,#0x10
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:127: CKCON0 |= 0b_0000_0000 ; // Timer 1 Uses SYSCLK / 12
	mov	_CKCON0,_CKCON0
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:128: TH1 = 0x100-((SYSCLK/BAUDRATE)/(2L*12L)); // Set Timer1 Reload Value, Initial Value
	mov	_TH1,#0xE6
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:129: TL1 = TH1; 	// Init Timer1
	mov	_TL1,_TH1
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:130: TMOD &= ~0xf0;  // TMOD: Timer 1 in 8-bit auto-reload
	anl	_TMOD,#0x0F
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:131: TMOD |=  0x20;
	orl	_TMOD,#0x20
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:132: TR1 = 1; // Start Timer1
	setb	_TR1
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:133: TI = 1;  // Indicate TX0 Ready
	setb	_TI
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:135: return 0;
	mov	dpl,#0x00
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'InitADC'
;------------------------------------------------------------
;------------------------------------------------------------
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:138: void InitADC(void) {
;	-----------------------------------------
;	 function InitADC
;	-----------------------------------------
_InitADC:
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:139: SFRPAGE = 0x00;
	mov	_SFRPAGE,#0x00
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:140: ADEN=0; // Disable ADC
	clr	_ADEN
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:145: (0x0 << 0) ; // Accumulate n conversions: 0x0: 1, 0x1:4, 0x2:8, 0x3:16, 0x4:32
	mov	_ADC0CN1,#0x80
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:149: (0x0 << 2); // 0:SYSCLK ADCCLK = SYSCLK. 1:HFOSC0 ADCCLK = HFOSC0.
	mov	_ADC0CF0,#0x20
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:153: (0x1E << 0); // Conversion Tracking Time. Tadtk = ADTK / (Fsarclk)
	mov	_ADC0CF1,#0x1E
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:162: (0x0 << 0) ; // TEMPE. 0: Disable the Temperature Sensor. 1: Enable the Temperature Sensor.
	mov	_ADC0CN0,#0x00
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:167: (0x1F << 0); // ADPWR. Power Up Delay Time. Tpwrtime = ((4 * (ADPWR + 1)) + 2) / (Fadcclk)
	mov	_ADC0CF2,#0x3F
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:171: (0x0 << 0) ; // ADCM. 0x0: ADBUSY, 0x1: TIMER0, 0x2: TIMER2, 0x3: TIMER3, 0x4: CNVSTR, 0x5: CEX5, 0x6: TIMER4, 0x7: TIMER5, 0x8: CLU0, 0x9: CLU1, 0xA: CLU2, 0xB: CLU3
	mov	_ADC0CN2,#0x00
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:173: ADEN=1; // Enable ADC
	setb	_ADEN
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'InitPinADC'
;------------------------------------------------------------
;pinno                     Allocated with name '_InitPinADC_PARM_2'
;portno                    Allocated to registers r2 
;mask                      Allocated to registers r3 
;------------------------------------------------------------
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:176: void InitPinADC(unsigned char portno, unsigned char pinno) {
;	-----------------------------------------
;	 function InitPinADC
;	-----------------------------------------
_InitPinADC:
	mov	r2,dpl
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:179: mask = 1 << pinno;
	mov	b,_InitPinADC_PARM_2
	inc	b
	mov	a,#0x01
	sjmp	L004013?
L004011?:
	add	a,acc
L004013?:
	djnz	b,L004011?
	mov	r3,a
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:181: SFRPAGE = 0x20;
	mov	_SFRPAGE,#0x20
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:182: switch(portno) {
	cjne	r2,#0x00,L004014?
	sjmp	L004001?
L004014?:
	cjne	r2,#0x01,L004015?
	sjmp	L004002?
L004015?:
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:183: case 0:
	cjne	r2,#0x02,L004005?
	sjmp	L004003?
L004001?:
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:184: P0MDIN &= (~mask); // Set Pin as Analog Input
	mov	a,r3
	cpl	a
	mov	r2,a
	anl	_P0MDIN,a
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:185: P0SKIP |= mask; // Skip Crossbar Decoding for this Pin
	mov	a,r3
	orl	_P0SKIP,a
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:186: break;
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:187: case 1:
	sjmp	L004005?
L004002?:
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:188: P1MDIN &= (~mask); // Set Pin as Analog Input
	mov	a,r3
	cpl	a
	mov	r2,a
	anl	_P1MDIN,a
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:189: P1SKIP |= mask; // Skip Crossbar Decoding for this Pin
	mov	a,r3
	orl	_P1SKIP,a
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:190: break;
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:191: case 2:
	sjmp	L004005?
L004003?:
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:192: P2MDIN &= (~mask); // Set Pin as Analog Input
	mov	a,r3
	cpl	a
	mov	r2,a
	anl	_P2MDIN,a
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:193: P2SKIP |= mask; // Skip Crossbar Decoding for this Pin
	mov	a,r3
	orl	_P2SKIP,a
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:197: }
L004005?:
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:198: SFRPAGE = 0x00;
	mov	_SFRPAGE,#0x00
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'ADC_at_Pin'
;------------------------------------------------------------
;pin                       Allocated to registers 
;------------------------------------------------------------
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:201: unsigned int ADC_at_Pin(unsigned char pin) {
;	-----------------------------------------
;	 function ADC_at_Pin
;	-----------------------------------------
_ADC_at_Pin:
	mov	_ADC0MX,dpl
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:203: ADINT = 0;
	clr	_ADINT
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:204: ADBUSY = 1;     // Convert Voltage at the Pin
	setb	_ADBUSY
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:205: while (!ADINT); // Wait for Conversion to Complete
L005001?:
	jnb	_ADINT,L005001?
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:206: return (ADC0);
	mov	dpl,_ADC0
	mov	dph,(_ADC0 >> 8)
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'Volts_at_Pin'
;------------------------------------------------------------
;pin                       Allocated to registers r2 
;------------------------------------------------------------
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:209: float Volts_at_Pin(unsigned char pin) {
;	-----------------------------------------
;	 function Volts_at_Pin
;	-----------------------------------------
_Volts_at_Pin:
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:211: (ADC_at_Pin(pin)*VDD) / 0b_0011_1111_1111_1111
	lcall	_ADC_at_Pin
	lcall	___uint2fs
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
	mov	r5,a
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	mov	dptr,#0x6C8B
	mov	b,#0x53
	mov	a,#0x40
	lcall	___fsmul
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
	mov	r5,a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	clr	a
	push	acc
	mov	a,#0xFC
	push	acc
	mov	a,#0x7F
	push	acc
	mov	a,#0x46
	push	acc
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	mov	a,r5
	lcall	___fsdiv
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
	mov	r5,a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	mov	a,r5
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'Timer3us'
;------------------------------------------------------------
;us                        Allocated to registers r2 
;i                         Allocated to registers r3 
;------------------------------------------------------------
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:218: void Timer3us(unsigned char us) {
;	-----------------------------------------
;	 function Timer3us
;	-----------------------------------------
_Timer3us:
	mov	r2,dpl
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:222: CKCON0 |= 0b_0100_0000;
	orl	_CKCON0,#0x40
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:224: TMR3RL = (-(SYSCLK)/1000000L); // Set Timer3 to Overflow in 1us
	mov	_TMR3RL,#0xB8
	mov	(_TMR3RL >> 8),#0xFF
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:225: TMR3 = TMR3RL;                 // Initialize Timer3 for First Overflow
	mov	_TMR3,_TMR3RL
	mov	(_TMR3 >> 8),(_TMR3RL >> 8)
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:227: TMR3CN0 = 0x04;                 // Start Timer3 and Clear Overflow Flag
	mov	_TMR3CN0,#0x04
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:228: for (i = 0; i < us; i++) {      // Count Overflows (#Microseconds)
	mov	r3,#0x00
L007004?:
	clr	c
	mov	a,r3
	subb	a,r2
	jnc	L007007?
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:229: while (!(TMR3CN0 & 0x80));  // Wait for Overflow
L007001?:
	mov	a,_TMR3CN0
	jnb	acc.7,L007001?
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:230: TMR3CN0 &= ~(0x80);         // Clear Overflow Indicator
	anl	_TMR3CN0,#0x7F
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:228: for (i = 0; i < us; i++) {      // Count Overflows (#Microseconds)
	inc	r3
	sjmp	L007004?
L007007?:
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:232: TMR3CN0 = 0 ;                   // Stop Timer3 and Clear Overflow Flag
	mov	_TMR3CN0,#0x00
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'waitms'
;------------------------------------------------------------
;ms                        Allocated to registers r2 r3 
;j                         Allocated to registers r4 r5 
;k                         Allocated to registers r6 
;------------------------------------------------------------
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:235: void waitms(unsigned int ms) {
;	-----------------------------------------
;	 function waitms
;	-----------------------------------------
_waitms:
	mov	r2,dpl
	mov	r3,dph
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:238: for (j=0; j<ms; j++)
	mov	r4,#0x00
	mov	r5,#0x00
L008005?:
	clr	c
	mov	a,r4
	subb	a,r2
	mov	a,r5
	subb	a,r3
	jnc	L008009?
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:239: for (k=0; k<4; k++) Timer3us(250);
	mov	r6,#0x00
L008001?:
	cjne	r6,#0x04,L008018?
L008018?:
	jnc	L008007?
	mov	dpl,#0xFA
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	push	ar6
	lcall	_Timer3us
	pop	ar6
	pop	ar5
	pop	ar4
	pop	ar3
	pop	ar2
	inc	r6
	sjmp	L008001?
L008007?:
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:238: for (j=0; j<ms; j++)
	inc	r4
	cjne	r4,#0x00,L008005?
	inc	r5
	sjmp	L008005?
L008009?:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'TIMER0_Init'
;------------------------------------------------------------
;------------------------------------------------------------
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:242: void TIMER0_Init(void) {
;	-----------------------------------------
;	 function TIMER0_Init
;	-----------------------------------------
_TIMER0_Init:
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:243: TMOD &= 0b_1111_0000; // Set the Bits of Timer/Counter 0 to 0
	anl	_TMOD,#0xF0
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:244: TMOD |= 0b_0000_0001; // Timer/Counter 0 Used As 16-Bit Timer
	orl	_TMOD,#0x01
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:245: TR0 = 0; // Stop Timer/Counter 0
	clr	_TR0
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'Serial_Init'
;------------------------------------------------------------
;------------------------------------------------------------
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:248: void Serial_Init(void) {
;	-----------------------------------------
;	 function Serial_Init
;	-----------------------------------------
_Serial_Init:
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:249: waitms(500); // Give Putty a chance to start.
	mov	dptr,#0x01F4
	lcall	_waitms
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:250: printf("\x1b[2J"); // Clear screen using ANSI escape sequence.
	mov	a,#__str_0
	push	acc
	mov	a,#(__str_0 >> 8)
	push	acc
	mov	a,#0x80
	push	acc
	lcall	_printf
	dec	sp
	dec	sp
	dec	sp
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'LCD_pulse'
;------------------------------------------------------------
;------------------------------------------------------------
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:253: void LCD_pulse(void) {
;	-----------------------------------------
;	 function LCD_pulse
;	-----------------------------------------
_LCD_pulse:
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:254: LCD_E = 1; // Pulse the Enable Pin
	setb	_P2_0
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:255: Timer3us(40); // Wait for 40us
	mov	dpl,#0x28
	lcall	_Timer3us
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:256: LCD_E = 0; // Pulse the Enable Pin
	clr	_P2_0
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'LCD_byte'
;------------------------------------------------------------
;x                         Allocated to registers r2 
;------------------------------------------------------------
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:259: void LCD_byte(unsigned char x) {
;	-----------------------------------------
;	 function LCD_byte
;	-----------------------------------------
_LCD_byte:
	mov	r2,dpl
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:262: ACC = x; // Send High Nibble
	mov	_ACC,r2
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:263: LCD_D7 = ACC_7;
	mov	c,_ACC_7
	mov	_P1_0,c
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:264: LCD_D6 = ACC_6;
	mov	c,_ACC_6
	mov	_P1_1,c
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:265: LCD_D5 = ACC_5;
	mov	c,_ACC_5
	mov	_P1_2,c
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:266: LCD_D4 = ACC_4;
	mov	c,_ACC_4
	mov	_P1_3,c
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:267: LCD_pulse();
	push	ar2
	lcall	_LCD_pulse
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:269: Timer3us(40); // Wait for 40us
	mov	dpl,#0x28
	lcall	_Timer3us
	pop	ar2
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:271: ACC = x; // Send Low Nibble
	mov	_ACC,r2
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:272: LCD_D7 = ACC_3;
	mov	c,_ACC_3
	mov	_P1_0,c
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:273: LCD_D6 = ACC_2;
	mov	c,_ACC_2
	mov	_P1_1,c
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:274: LCD_D5 = ACC_1;
	mov	c,_ACC_1
	mov	_P1_2,c
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:275: LCD_D4 = ACC_0;
	mov	c,_ACC_0
	mov	_P1_3,c
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:276: LCD_pulse();
	ljmp	_LCD_pulse
;------------------------------------------------------------
;Allocation info for local variables in function 'WriteData'
;------------------------------------------------------------
;x                         Allocated to registers r2 
;------------------------------------------------------------
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:279: void WriteData(unsigned char x) {
;	-----------------------------------------
;	 function WriteData
;	-----------------------------------------
_WriteData:
	mov	r2,dpl
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:280: LCD_RS = 1; // Set LCD to Data Mode
	setb	_P1_7
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:281: LCD_byte(x); // Write the Data
	mov	dpl,r2
	lcall	_LCD_byte
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:282: waitms(2); // Wait for 2ms
	mov	dptr,#0x0002
	ljmp	_waitms
;------------------------------------------------------------
;Allocation info for local variables in function 'WriteCommand'
;------------------------------------------------------------
;x                         Allocated to registers r2 
;------------------------------------------------------------
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:285: void WriteCommand(unsigned char x) {
;	-----------------------------------------
;	 function WriteCommand
;	-----------------------------------------
_WriteCommand:
	mov	r2,dpl
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:286: LCD_RS = 0; // Set LCD to Command Mode
	clr	_P1_7
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:287: LCD_byte(x); // Write the Command
	mov	dpl,r2
	lcall	_LCD_byte
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:288: waitms(5); // Wait for 5ms
	mov	dptr,#0x0005
	ljmp	_waitms
;------------------------------------------------------------
;Allocation info for local variables in function 'LCD_4BIT'
;------------------------------------------------------------
;------------------------------------------------------------
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:291: void LCD_4BIT(void) {
;	-----------------------------------------
;	 function LCD_4BIT
;	-----------------------------------------
_LCD_4BIT:
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:292: LCD_E = 0; // Resting State of LCD Enable Pin is 0.
	clr	_P2_0
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:293: waitms(20); // Wait for 20ms
	mov	dptr,#0x0014
	lcall	_waitms
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:296: WriteCommand(0x33); // Change to 8-bit Mode
	mov	dpl,#0x33
	lcall	_WriteCommand
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:297: WriteCommand(0x33); // Change to 8-bit Mode
	mov	dpl,#0x33
	lcall	_WriteCommand
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:298: WriteCommand(0x32); // Change to 4-bit Mode
	mov	dpl,#0x32
	lcall	_WriteCommand
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:301: WriteCommand(0x28); // 4-bit, 2 Line, 5x7 Dots
	mov	dpl,#0x28
	lcall	_WriteCommand
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:302: WriteCommand(0x0c); // Display On, No Cursor, No Blink
	mov	dpl,#0x0C
	lcall	_WriteCommand
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:303: WriteCommand(0x01); // Clear Screen Command (Takes Some Time)
	mov	dpl,#0x01
	lcall	_WriteCommand
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:304: waitms(20); // Wait 20ms for Clear Screen Command to Finish
	mov	dptr,#0x0014
	ljmp	_waitms
;------------------------------------------------------------
;Allocation info for local variables in function 'LCDprint'
;------------------------------------------------------------
;line                      Allocated with name '_LCDprint_PARM_2'
;string                    Allocated to registers r2 r3 r4 
;j                         Allocated to registers r5 r6 
;------------------------------------------------------------
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:307: void LCDprint(char * string, unsigned char line, bit clear) {
;	-----------------------------------------
;	 function LCDprint
;	-----------------------------------------
_LCDprint:
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:310: WriteCommand(line == 2 ? 0xc0 : 0x80); // Set Cursor
	mov	a,#0x02
	cjne	a,_LCDprint_PARM_2,L016013?
	mov	r5,#0xC0
	sjmp	L016014?
L016013?:
	mov	r5,#0x80
L016014?:
	mov	dpl,r5
	push	ar2
	push	ar3
	push	ar4
	lcall	_WriteCommand
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:311: waitms(5); // Wait for 5ms
	mov	dptr,#0x0005
	lcall	_waitms
	pop	ar4
	pop	ar3
	pop	ar2
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:312: for (j = 0; string[j] != 0; j++) WriteData(string[j]); // Write Message
	mov	r5,#0x00
	mov	r6,#0x00
L016003?:
	mov	a,r5
	add	a,r2
	mov	r7,a
	mov	a,r6
	addc	a,r3
	mov	r0,a
	mov	ar1,r4
	mov	dpl,r7
	mov	dph,r0
	mov	b,r1
	lcall	__gptrget
	mov	r7,a
	jz	L016006?
	mov	dpl,r7
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	push	ar6
	lcall	_WriteData
	pop	ar6
	pop	ar5
	pop	ar4
	pop	ar3
	pop	ar2
	inc	r5
	cjne	r5,#0x00,L016003?
	inc	r6
	sjmp	L016003?
L016006?:
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:313: if (clear) for (; j < CHARS_PER_LINE; j++) WriteData(' '); // Clear Rest of Line
	jnb	_LCDprint_PARM_3,L016011?
	mov	ar2,r5
	mov	ar3,r6
L016007?:
	clr	c
	mov	a,r2
	subb	a,#0x10
	mov	a,r3
	xrl	a,#0x80
	subb	a,#0x80
	jnc	L016011?
	mov	dpl,#0x20
	push	ar2
	push	ar3
	lcall	_WriteData
	pop	ar3
	pop	ar2
	inc	r2
	cjne	r2,#0x00,L016007?
	inc	r3
	sjmp	L016007?
L016011?:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'write_rx'
;------------------------------------------------------------
;len                       Allocated with name '_write_rx_PARM_2'
;buff                      Allocated with name '_write_rx_buff_1_55'
;j                         Allocated with name '_write_rx_sloc0_1_0'
;c                         Allocated to registers r3 
;sloc0                     Allocated with name '_write_rx_sloc0_1_0'
;------------------------------------------------------------
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:316: int write_rx(char* buff, int len) {
;	-----------------------------------------
;	 function write_rx
;	-----------------------------------------
_write_rx:
	mov	_write_rx_buff_1_55,dpl
	mov	(_write_rx_buff_1_55 + 1),dph
	mov	(_write_rx_buff_1_55 + 2),b
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:320: for (j = 0; j < (len-1); j++) {
	clr	a
	mov	_write_rx_sloc0_1_0,a
	mov	(_write_rx_sloc0_1_0 + 1),a
	mov	a,_write_rx_PARM_2
	add	a,#0xff
	mov	r7,a
	mov	a,(_write_rx_PARM_2 + 1)
	addc	a,#0xff
	mov	r0,a
	mov	r1,#0x00
	mov	r2,#0x00
L017005?:
	clr	c
	mov	a,r1
	subb	a,r7
	mov	a,r2
	xrl	a,#0x80
	mov	b,r0
	xrl	b,#0x80
	subb	a,b
	jnc	L017008?
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:321: c = getchar();
	push	ar2
	push	ar7
	push	ar0
	push	ar1
	lcall	_getchar
	mov	r3,dpl
	pop	ar1
	pop	ar0
	pop	ar7
	pop	ar2
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:322: if ( (c == '\n') || (c == '\r') ) {
	cjne	r3,#0x0A,L017015?
	sjmp	L017001?
L017015?:
	cjne	r3,#0x0D,L017002?
L017001?:
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:323: buff[j] = 0;
	mov	a,_write_rx_sloc0_1_0
	add	a,_write_rx_buff_1_55
	mov	r4,a
	mov	a,(_write_rx_sloc0_1_0 + 1)
	addc	a,(_write_rx_buff_1_55 + 1)
	mov	r5,a
	mov	r6,(_write_rx_buff_1_55 + 2)
	mov	dpl,r4
	mov	dph,r5
	mov	b,r6
	clr	a
	lcall	__gptrput
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:324: return j;
	mov	dpl,_write_rx_sloc0_1_0
	mov	dph,(_write_rx_sloc0_1_0 + 1)
	ret
L017002?:
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:326: buff[j] = c;
	mov	a,r1
	add	a,_write_rx_buff_1_55
	mov	r4,a
	mov	a,r2
	addc	a,(_write_rx_buff_1_55 + 1)
	mov	r5,a
	mov	r6,(_write_rx_buff_1_55 + 2)
	mov	dpl,r4
	mov	dph,r5
	mov	b,r6
	mov	a,r3
	lcall	__gptrput
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:320: for (j = 0; j < (len-1); j++) {
	inc	r1
	cjne	r1,#0x00,L017018?
	inc	r2
L017018?:
	mov	_write_rx_sloc0_1_0,r1
	mov	(_write_rx_sloc0_1_0 + 1),r2
	sjmp	L017005?
L017008?:
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:329: buff[j] = 0;
	mov	a,_write_rx_sloc0_1_0
	add	a,_write_rx_buff_1_55
	mov	r2,a
	mov	a,(_write_rx_sloc0_1_0 + 1)
	addc	a,(_write_rx_buff_1_55 + 1)
	mov	r3,a
	mov	r4,(_write_rx_buff_1_55 + 2)
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	clr	a
	lcall	__gptrput
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:330: return len;
	mov	dpl,_write_rx_PARM_2
	mov	dph,(_write_rx_PARM_2 + 1)
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'display_rx'
;------------------------------------------------------------
;len                       Allocated with name '_display_rx_PARM_2'
;buff                      Allocated to registers r2 r3 r4 
;------------------------------------------------------------
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:333: void display_rx(char* buff, int len) {
;	-----------------------------------------
;	 function display_rx
;	-----------------------------------------
_display_rx:
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:334: printf("Type Intended Display in Line 2 (16 Char Max): ");
	push	ar2
	push	ar3
	push	ar4
	mov	a,#__str_1
	push	acc
	mov	a,#(__str_1 >> 8)
	push	acc
	mov	a,#0x80
	push	acc
	lcall	_printf
	dec	sp
	dec	sp
	dec	sp
	pop	ar4
	pop	ar3
	pop	ar2
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:335: write_rx(buff, len);
	mov	_write_rx_PARM_2,_display_rx_PARM_2
	mov	(_write_rx_PARM_2 + 1),(_display_rx_PARM_2 + 1)
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	push	ar2
	push	ar3
	push	ar4
	lcall	_write_rx
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:336: printf("\n");
	mov	a,#__str_2
	push	acc
	mov	a,#(__str_2 >> 8)
	push	acc
	mov	a,#0x80
	push	acc
	lcall	_printf
	dec	sp
	dec	sp
	dec	sp
	pop	ar4
	pop	ar3
	pop	ar2
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:337: LCDprint(buff, 1, 1);
	mov	_LCDprint_PARM_2,#0x01
	setb	_LCDprint_PARM_3
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	ljmp	_LCDprint
;------------------------------------------------------------
;Allocation info for local variables in function 'display_period'
;------------------------------------------------------------
;period                    Allocated to registers r2 r3 r4 r5 
;------------------------------------------------------------
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:340: void display_period(float period) {
;	-----------------------------------------
;	 function display_period
;	-----------------------------------------
_display_period:
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
	mov	r5,a
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:341: sprintf(LCD_BUFF, "T: %.3f s", period); // Format the Period Value
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	mov	a,#__str_3
	push	acc
	mov	a,#(__str_3 >> 8)
	push	acc
	mov	a,#0x80
	push	acc
	mov	a,#_LCD_BUFF
	push	acc
	mov	a,#(_LCD_BUFF >> 8)
	push	acc
	mov	a,#0x40
	push	acc
	lcall	_sprintf
	mov	a,sp
	add	a,#0xf6
	mov	sp,a
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:342: LCDprint(LCD_BUFF, 2, 1); // Write to LCD
	mov	_LCDprint_PARM_2,#0x02
	setb	_LCDprint_PARM_3
	mov	dptr,#_LCD_BUFF
	mov	b,#0x40
	ljmp	_LCDprint
;------------------------------------------------------------
;Allocation info for local variables in function 'display_freq_kHz'
;------------------------------------------------------------
;freq_kHz                  Allocated to registers r2 r3 r4 r5 
;------------------------------------------------------------
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:345: void display_freq_kHz(float freq_kHz) {
;	-----------------------------------------
;	 function display_freq_kHz
;	-----------------------------------------
_display_freq_kHz:
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
	mov	r5,a
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:346: sprintf(LCD_BUFF, "F: %.3f kHz", freq_kHz); // Format the Frequency Value
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	mov	a,#__str_4
	push	acc
	mov	a,#(__str_4 >> 8)
	push	acc
	mov	a,#0x80
	push	acc
	mov	a,#_LCD_BUFF
	push	acc
	mov	a,#(_LCD_BUFF >> 8)
	push	acc
	mov	a,#0x40
	push	acc
	lcall	_sprintf
	mov	a,sp
	add	a,#0xf6
	mov	sp,a
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:347: LCDprint(LCD_BUFF, 1, 1); // Write to LCD
	mov	_LCDprint_PARM_2,#0x01
	setb	_LCDprint_PARM_3
	mov	dptr,#_LCD_BUFF
	mov	b,#0x40
	ljmp	_LCDprint
;------------------------------------------------------------
;Allocation info for local variables in function 'display_capacitance_nF'
;------------------------------------------------------------
;capacitance_nF            Allocated to registers r2 r3 r4 r5 
;------------------------------------------------------------
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:350: void display_capacitance_nF(float capacitance_nF) {
;	-----------------------------------------
;	 function display_capacitance_nF
;	-----------------------------------------
_display_capacitance_nF:
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
	mov	r5,a
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:351: sprintf(LCD_BUFF, "C: %.3f nF", capacitance_nF); // Format the Capacitance Value
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	mov	a,#__str_5
	push	acc
	mov	a,#(__str_5 >> 8)
	push	acc
	mov	a,#0x80
	push	acc
	mov	a,#_LCD_BUFF
	push	acc
	mov	a,#(_LCD_BUFF >> 8)
	push	acc
	mov	a,#0x40
	push	acc
	lcall	_sprintf
	mov	a,sp
	add	a,#0xf6
	mov	sp,a
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:352: LCDprint(LCD_BUFF, 2, 1); // Write to LCD
	mov	_LCDprint_PARM_2,#0x02
	setb	_LCDprint_PARM_3
	mov	dptr,#_LCD_BUFF
	mov	b,#0x40
	ljmp	_LCDprint
;------------------------------------------------------------
;Allocation info for local variables in function 'display_resistance_kOhms'
;------------------------------------------------------------
;resistance_kOhms          Allocated to registers r2 r3 r4 r5 
;------------------------------------------------------------
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:355: void display_resistance_kOhms(float resistance_kOhms) {
;	-----------------------------------------
;	 function display_resistance_kOhms
;	-----------------------------------------
_display_resistance_kOhms:
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
	mov	r5,a
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:356: sprintf(LCD_BUFF, "R: %.3f kOhms", resistance_kOhms); // Format the Resistance Value
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	mov	a,#__str_6
	push	acc
	mov	a,#(__str_6 >> 8)
	push	acc
	mov	a,#0x80
	push	acc
	mov	a,#_LCD_BUFF
	push	acc
	mov	a,#(_LCD_BUFF >> 8)
	push	acc
	mov	a,#0x40
	push	acc
	lcall	_sprintf
	mov	a,sp
	add	a,#0xf6
	mov	sp,a
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:357: LCDprint(LCD_BUFF, 1, 1); // Write to LCD
	mov	_LCDprint_PARM_2,#0x01
	setb	_LCDprint_PARM_3
	mov	dptr,#_LCD_BUFF
	mov	b,#0x40
	lcall	_LCDprint
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:358: LCDprint("                ", 2, 1); // Clear Second Line
	mov	_LCDprint_PARM_2,#0x02
	setb	_LCDprint_PARM_3
	mov	dptr,#__str_7
	mov	b,#0x80
	ljmp	_LCDprint
;------------------------------------------------------------
;Allocation info for local variables in function 'calculate_period_s'
;------------------------------------------------------------
;TH0                       Allocated with name '_calculate_period_s_PARM_2'
;TL0                       Allocated with name '_calculate_period_s_PARM_3'
;overflow_count            Allocated to registers r2 r3 
;------------------------------------------------------------
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:361: float calculate_period_s(int overflow_count, int TH0, int TL0) {
;	-----------------------------------------
;	 function calculate_period_s
;	-----------------------------------------
_calculate_period_s:
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:362: return ((overflow_count * MAX_16_BIT)  + (TH0 * MAX_8_BIT) + TL0) * (12.0 / SYSCLK);
	lcall	___sint2fs
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
	mov	r5,a
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	mov	dptr,#0x0000
	mov	b,#0x80
	mov	a,#0x47
	lcall	___fsmul
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
	mov	r5,a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	mov	dpl,_calculate_period_s_PARM_2
	mov	dph,(_calculate_period_s_PARM_2 + 1)
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	lcall	___sint2fs
	mov	r6,dpl
	mov	r7,dph
	mov	r0,b
	mov	r1,a
	push	ar6
	push	ar7
	push	ar0
	push	ar1
	mov	dptr,#0x0000
	mov	b,#0x80
	mov	a,#0x43
	lcall	___fsmul
	mov	r6,dpl
	mov	r7,dph
	mov	r0,b
	mov	r1,a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	pop	ar5
	pop	ar4
	pop	ar3
	pop	ar2
	push	ar6
	push	ar7
	push	ar0
	push	ar1
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	mov	a,r5
	lcall	___fsadd
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
	mov	r5,a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	mov	dpl,_calculate_period_s_PARM_3
	mov	dph,(_calculate_period_s_PARM_3 + 1)
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	lcall	___sint2fs
	mov	r6,dpl
	mov	r7,dph
	mov	r0,b
	mov	r1,a
	pop	ar5
	pop	ar4
	pop	ar3
	pop	ar2
	push	ar6
	push	ar7
	push	ar0
	push	ar1
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	mov	a,r5
	lcall	___fsadd
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
	mov	r5,a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	mov	dptr,#0xF4FC
	mov	b,#0x32
	mov	a,#0x34
	lcall	___fsmul
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
	mov	r5,a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	mov	a,r5
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'calculate_freq_Hz'
;------------------------------------------------------------
;period_s                  Allocated to registers r2 r3 r4 r5 
;------------------------------------------------------------
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:365: float calculate_freq_Hz(float period_s) {
;	-----------------------------------------
;	 function calculate_freq_Hz
;	-----------------------------------------
_calculate_freq_Hz:
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
	mov	r5,a
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:366: return (1.0 / period_s);
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	mov	dptr,#0x0000
	mov	b,#0x80
	mov	a,#0x3F
	lcall	___fsdiv
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
	mov	r5,a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	mov	a,r5
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'calculate_capacitance_nF'
;------------------------------------------------------------
;period_s                  Allocated to registers r2 r3 r4 r5 
;------------------------------------------------------------
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:369: float calculate_capacitance_nF(float period_s) {
;	-----------------------------------------
;	 function calculate_capacitance_nF
;	-----------------------------------------
_calculate_capacitance_nF:
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
	mov	r5,a
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:370: return (1.44 * period_s / (R_A + 2 * R_B)) * GIGA_MULTIPLIER; // Convert to Nanofarads
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	mov	dptr,#0x51EC
	mov	b,#0xB8
	mov	a,#0x3F
	lcall	___fsmul
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
	mov	r5,a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	clr	a
	push	acc
	mov	a,#0xA0
	push	acc
	mov	a,#0x8C
	push	acc
	mov	a,#0x45
	push	acc
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	mov	a,r5
	lcall	___fsdiv
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
	mov	r5,a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	mov	dptr,#0x6B28
	mov	b,#0x6E
	mov	a,#0x4E
	lcall	___fsmul
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
	mov	r5,a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	mov	a,r5
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'calculate_resistance_k0hms'
;------------------------------------------------------------
;voltage_across_resistor   Allocated to registers r2 r3 r4 r5 
;current                   Allocated to registers r6 r7 r0 r1 
;------------------------------------------------------------
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:373: float calculate_resistance_k0hms(float voltage_across_resistor) {
;	-----------------------------------------
;	 function calculate_resistance_k0hms
;	-----------------------------------------
_calculate_resistance_k0hms:
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
	mov	r5,a
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:374: float current = ((VSS - voltage_across_resistor) / R_REF) / MEGA_MULTIPLIER; // Calculate Current (Amps)
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	mov	dptr,#0x999A
	mov	b,#0x99
	mov	a,#0x40
	lcall	___fssub
	mov	r6,dpl
	mov	r7,dph
	mov	r0,b
	mov	r1,a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	clr	a
	push	acc
	push	acc
	mov	a,#0xC8
	push	acc
	mov	a,#0x42
	push	acc
	mov	dpl,r6
	mov	dph,r7
	mov	b,r0
	mov	a,r1
	lcall	___fsdiv
	mov	r6,dpl
	mov	r7,dph
	mov	r0,b
	mov	r1,a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	push	ar6
	push	ar7
	push	ar0
	push	ar1
	mov	dptr,#0x0000
	mov	b,#0x7A
	mov	a,#0x44
	lcall	___fsmul
	mov	r6,dpl
	mov	r7,dph
	mov	r0,b
	mov	r1,a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	clr	a
	push	acc
	mov	a,#0x24
	push	acc
	mov	a,#0x74
	push	acc
	mov	a,#0x49
	push	acc
	mov	dpl,r6
	mov	dph,r7
	mov	b,r0
	mov	a,r1
	lcall	___fsdiv
	mov	r6,dpl
	mov	r7,dph
	mov	r0,b
	mov	r1,a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	pop	ar5
	pop	ar4
	pop	ar3
	pop	ar2
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:379: return (voltage_across_resistor / current) / KILO_MULTIPLIER; // Calculate Resistance (Kilohms)
	push	ar6
	push	ar7
	push	ar0
	push	ar1
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	mov	a,r5
	lcall	___fsdiv
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
	mov	r5,a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	clr	a
	push	acc
	push	acc
	mov	a,#0x7A
	push	acc
	mov	a,#0x44
	push	acc
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	mov	a,r5
	lcall	___fsdiv
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
	mov	r5,a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	mov	a,r5
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'Check_Mode_Button'
;------------------------------------------------------------
;mode                      Allocated to registers r2 r3 
;current_mode              Allocated to registers 
;------------------------------------------------------------
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:395: int Check_Mode_Button(int mode) {
;	-----------------------------------------
;	 function Check_Mode_Button
;	-----------------------------------------
_Check_Mode_Button:
	mov	r2,dpl
	mov	r3,dph
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:397: if (MODE_PIN == 0) waitms(50); // De-bounce
	jb	_P3_1,L027002?
	mov	dptr,#0x0032
	push	ar2
	push	ar3
	lcall	_waitms
	pop	ar3
	pop	ar2
	sjmp	L027003?
L027002?:
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:398: else return current_mode;
	mov	dpl,r2
	mov	dph,r3
	ret
L027003?:
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:400: if(MODE_PIN == 0) {
	jb	_P3_1,L027011?
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:401: while(MODE_PIN==0);
L027004?:
	jnb	_P3_1,L027004?
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:403: if (mode == MODE_CAPACITANCE) {
	mov	a,r2
	orl	a,r3
	jnz	L027008?
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:404: return MODE_RESISTANCE;
	mov	dptr,#0x0001
	ret
L027008?:
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:406: return MODE_CAPACITANCE;
	mov	dptr,#0x0000
	ret
L027011?:
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:409: return current_mode;
	mov	dpl,r2
	mov	dph,r3
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'main'
;------------------------------------------------------------
;mode                      Allocated with name '_main_mode_1_85'
;V_LED                     Allocated to registers 
;V_R                       Allocated with name '_main_V_R_1_85'
;R_kOhms                   Allocated with name '_main_R_kOhms_1_85'
;period_s                  Allocated with name '_main_period_s_1_85'
;freq_Hz                   Allocated to registers r6 r7 r4 r5 
;capacitance_nF            Allocated with name '_main_capacitance_nF_1_85'
;success_count             Allocated with name '_main_success_count_1_85'
;------------------------------------------------------------
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:413: void main(void) {
;	-----------------------------------------
;	 function main
;	-----------------------------------------
_main:
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:414: int mode = MODE_CAPACITANCE;
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:417: int success_count = 0;
	clr	a
	mov	_main_mode_1_85,a
	mov	(_main_mode_1_85 + 1),a
	mov	_main_success_count_1_85,a
	mov	(_main_success_count_1_85 + 1),a
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:420: TIMER0_Init(); // Initialize Timer 0
	lcall	_TIMER0_Init
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:421: Serial_Init(); // Initialize Serial Communication
	lcall	_Serial_Init
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:422: LCD_4BIT();	// Configure the LCD
	lcall	_LCD_4BIT
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:425: InitPinADC(0, 1); // Configure P0.1 as Analog Input
	mov	_InitPinADC_PARM_2,#0x01
	mov	dpl,#0x00
	lcall	_InitPinADC
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:426: InitPinADC(2, 1); // Configure P2.1 as Analog Input
	mov	_InitPinADC_PARM_2,#0x01
	mov	dpl,#0x02
	lcall	_InitPinADC
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:427: InitADC();
	lcall	_InitADC
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:429: while(1) {
L028041?:
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:430: mode = Check_Mode_Button(mode);
	mov	dpl,_main_mode_1_85
	mov	dph,(_main_mode_1_85 + 1)
	lcall	_Check_Mode_Button
	mov	_main_mode_1_85,dpl
	mov	(_main_mode_1_85 + 1),dph
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:432: V_LED = Volts_at_Pin(QFP32_MUX_P0_1); // Measure the Voltage at the LED
	mov	dpl,#0x00
	lcall	_Volts_at_Pin
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:433: V_R = Volts_at_Pin(QFP32_MUX_P2_1); // Measure the Voltage at the Resistor
	mov	dpl,#0x0E
	lcall	_Volts_at_Pin
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:434: R_kOhms = calculate_resistance_k0hms(V_R);
	mov	_main_V_R_1_85,dpl
	mov	(_main_V_R_1_85 + 1),dph
	mov	(_main_V_R_1_85 + 2),b
	mov	(_main_V_R_1_85 + 3),a
	lcall	_calculate_resistance_k0hms
	mov	_main_R_kOhms_1_85,dpl
	mov	(_main_R_kOhms_1_85 + 1),dph
	mov	(_main_R_kOhms_1_85 + 2),b
	mov	(_main_R_kOhms_1_85 + 3),a
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:441: TL0 = 0;
	mov	_TL0,#0x00
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:442: TH0 = 0;
	mov	_TH0,#0x00
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:443: TF0 = 0;
	clr	_TF0
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:444: overflow_count = 0;
	mov	_overflow_count,#0x00
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:446: while (EFM8_SIGNAL != 0); // Wait for Signal == 0
L028001?:
	jb	_P3_3,L028001?
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:447: while (EFM8_SIGNAL != 1); // Wait for Signal == 1
L028004?:
	jnb	_P3_3,L028004?
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:449: TR0 = 1; // Start Timer
	setb	_TR0
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:451: while (EFM8_SIGNAL != 0) { // Wait for Signal == 0
L028009?:
	jnb	_P3_3,L028014?
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:452: if (TF0 == 1) { // Did 16-Bit Timer Overflow?
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:453: TF0 = 0;
	jbc	_TF0,L028069?
	sjmp	L028009?
L028069?:
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:454: overflow_count++;
	inc	_overflow_count
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:457: while (EFM8_SIGNAL != 1) { // Wait for Signal == 1
	sjmp	L028009?
L028014?:
	jb	_P3_3,L028016?
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:458: if (TF0 == 1) { // Did 16-Bit Timer Overflow?
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:459: TF0 = 0;
	jbc	_TF0,L028071?
	sjmp	L028014?
L028071?:
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:460: overflow_count++;
	inc	_overflow_count
	sjmp	L028014?
L028016?:
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:464: TR0 = 0; // Stop Timer 0. The 24-bit number [overflow_count-TH0-TL0] has the period!
	clr	_TR0
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:465: period_s = calculate_period_s(overflow_count, TH0, TL0);
	mov	r0,_overflow_count
	mov	r1,#0x00
	mov	_calculate_period_s_PARM_2,_TH0
	mov	(_calculate_period_s_PARM_2 + 1),#0x00
	mov	_calculate_period_s_PARM_3,_TL0
	mov	(_calculate_period_s_PARM_3 + 1),#0x00
	mov	dpl,r0
	mov	dph,r1
	lcall	_calculate_period_s
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:466: freq_Hz = calculate_freq_Hz(period_s);
	mov	_main_period_s_1_85,dpl
	mov	(_main_period_s_1_85 + 1),dph
	mov	(_main_period_s_1_85 + 2),b
	mov	(_main_period_s_1_85 + 3),a
	lcall	_calculate_freq_Hz
	mov	r6,dpl
	mov	r7,dph
	mov	r4,b
	mov	r5,a
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:467: capacitance_nF = calculate_capacitance_nF(period_s);
	mov	dpl,_main_period_s_1_85
	mov	dph,(_main_period_s_1_85 + 1)
	mov	b,(_main_period_s_1_85 + 2)
	mov	a,(_main_period_s_1_85 + 3)
	push	ar4
	push	ar5
	push	ar6
	push	ar7
	lcall	_calculate_capacitance_nF
	mov	_main_capacitance_nF_1_85,dpl
	mov	(_main_capacitance_nF_1_85 + 1),dph
	mov	(_main_capacitance_nF_1_85 + 2),b
	mov	(_main_capacitance_nF_1_85 + 3),a
	pop	ar7
	pop	ar6
	pop	ar5
	pop	ar4
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:469: if ((mode == MODE_RESISTANCE) && (V_R < VDD)) display_resistance_kOhms(R_kOhms);
	mov	a,#0x01
	cjne	a,_main_mode_1_85,L028072?
	clr	a
	cjne	a,(_main_mode_1_85 + 1),L028072?
	mov	a,#0x01
	sjmp	L028073?
L028072?:
	clr	a
L028073?:
	mov	r0,a
	jz	L028018?
	push	ar4
	push	ar5
	push	ar6
	push	ar7
	push	ar0
	mov	a,#0x8B
	push	acc
	mov	a,#0x6C
	push	acc
	mov	a,#0x53
	push	acc
	mov	a,#0x40
	push	acc
	mov	dpl,_main_V_R_1_85
	mov	dph,(_main_V_R_1_85 + 1)
	mov	b,(_main_V_R_1_85 + 2)
	mov	a,(_main_V_R_1_85 + 3)
	lcall	___fslt
	mov	r1,dpl
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	pop	ar0
	pop	ar7
	pop	ar6
	pop	ar5
	pop	ar4
	mov	a,r1
	jz	L028018?
	mov	dpl,_main_R_kOhms_1_85
	mov	dph,(_main_R_kOhms_1_85 + 1)
	mov	b,(_main_R_kOhms_1_85 + 2)
	mov	a,(_main_R_kOhms_1_85 + 3)
	push	ar4
	push	ar5
	push	ar6
	push	ar7
	push	ar0
	lcall	_display_resistance_kOhms
	pop	ar0
	pop	ar7
	pop	ar6
	pop	ar5
	pop	ar4
L028018?:
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:477: if ((mode == MODE_CAPACITANCE) && (freq_Hz <= MIN_FREQ_HZ || freq_Hz >= MAX_FREQ_HZ)) {
	mov	a,_main_mode_1_85
	orl	a,(_main_mode_1_85 + 1)
	jz	L028076?
	ljmp	L028030?
L028076?:
	push	ar4
	push	ar5
	push	ar6
	push	ar7
	push	ar0
	clr	a
	push	acc
	push	acc
	mov	a,#0x48
	push	acc
	mov	a,#0x43
	push	acc
	mov	dpl,r6
	mov	dph,r7
	mov	b,r4
	mov	a,r5
	lcall	___fsgt
	mov	r1,dpl
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	pop	ar0
	pop	ar7
	pop	ar6
	pop	ar5
	pop	ar4
	mov	a,r1
	jz	L028029?
	push	ar4
	push	ar5
	push	ar6
	push	ar7
	push	ar0
	push	ar1
	clr	a
	push	acc
	mov	a,#0x50
	push	acc
	mov	a,#0xC3
	push	acc
	mov	a,#0x48
	push	acc
	mov	dpl,r6
	mov	dph,r7
	mov	b,r4
	mov	a,r5
	lcall	___fslt
	mov	r2,dpl
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	pop	ar1
	pop	ar0
	pop	ar7
	pop	ar6
	pop	ar5
	pop	ar4
	mov	a,r2
	jz	L028078?
	ljmp	L028030?
L028078?:
L028029?:
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:478: success_count = 0;
	clr	a
	mov	_main_success_count_1_85,a
	mov	(_main_success_count_1_85 + 1),a
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:479: if (freq_Hz >= MAX_FREQ_HZ) LCDprint("ERROR : LOW C", 1, 1);
	push	ar4
	push	ar5
	push	ar6
	push	ar7
	push	ar0
	push	ar1
	clr	a
	push	acc
	mov	a,#0x50
	push	acc
	mov	a,#0xC3
	push	acc
	mov	a,#0x48
	push	acc
	mov	dpl,r6
	mov	dph,r7
	mov	b,r4
	mov	a,r5
	lcall	___fslt
	mov	r2,dpl
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	pop	ar1
	pop	ar0
	pop	ar7
	pop	ar6
	pop	ar5
	pop	ar4
	mov	a,r2
	jnz	L028023?
	mov	_LCDprint_PARM_2,#0x01
	setb	_LCDprint_PARM_3
	mov	dptr,#__str_8
	mov	b,#0x80
	push	ar4
	push	ar5
	push	ar6
	push	ar7
	push	ar0
	lcall	_LCDprint
	pop	ar0
	pop	ar7
	pop	ar6
	pop	ar5
	pop	ar4
	sjmp	L028024?
L028023?:
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:480: else if (freq_Hz <= MIN_FREQ_HZ) LCDprint("ERROR : HIGH C", 1, 1);
	mov	a,r1
	jnz	L028024?
	mov	_LCDprint_PARM_2,#0x01
	setb	_LCDprint_PARM_3
	mov	dptr,#__str_9
	mov	b,#0x80
	push	ar4
	push	ar5
	push	ar6
	push	ar7
	push	ar0
	lcall	_LCDprint
	pop	ar0
	pop	ar7
	pop	ar6
	pop	ar5
	pop	ar4
L028024?:
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:482: LCDprint("                ", 2, 1);
	mov	_LCDprint_PARM_2,#0x02
	setb	_LCDprint_PARM_3
	mov	dptr,#__str_7
	mov	b,#0x80
	push	ar4
	push	ar5
	push	ar6
	push	ar7
	push	ar0
	lcall	_LCDprint
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:483: waitms(500); // Wait for 500 ms
	mov	dptr,#0x01F4
	lcall	_waitms
	pop	ar0
	pop	ar7
	pop	ar6
	pop	ar5
	pop	ar4
	ljmp	L028031?
L028030?:
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:484: } else if ((mode == MODE_RESISTANCE) && (V_R >= VDD)) {
	mov	a,r0
	jz	L028026?
	push	ar4
	push	ar5
	push	ar6
	push	ar7
	push	ar0
	mov	a,#0x8B
	push	acc
	mov	a,#0x6C
	push	acc
	mov	a,#0x53
	push	acc
	mov	a,#0x40
	push	acc
	mov	dpl,_main_V_R_1_85
	mov	dph,(_main_V_R_1_85 + 1)
	mov	b,(_main_V_R_1_85 + 2)
	mov	a,(_main_V_R_1_85 + 3)
	lcall	___fslt
	mov	r2,dpl
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	pop	ar0
	pop	ar7
	pop	ar6
	pop	ar5
	pop	ar4
	mov	a,r2
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:485: success_count = 0;
	jnz	L028026?
	mov	_main_success_count_1_85,a
	mov	(_main_success_count_1_85 + 1),a
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:486: LCDprint("ERROR : HIGH R", 1, 1);
	mov	_LCDprint_PARM_2,#0x01
	setb	_LCDprint_PARM_3
	mov	dptr,#__str_10
	mov	b,#0x80
	push	ar4
	push	ar5
	push	ar6
	push	ar7
	push	ar0
	lcall	_LCDprint
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:488: LCDprint("                ", 2, 1);
	mov	_LCDprint_PARM_2,#0x02
	setb	_LCDprint_PARM_3
	mov	dptr,#__str_7
	mov	b,#0x80
	lcall	_LCDprint
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:489: waitms(500); // Wait for 500 ms
	mov	dptr,#0x01F4
	lcall	_waitms
	pop	ar0
	pop	ar7
	pop	ar6
	pop	ar5
	pop	ar4
	sjmp	L028031?
L028026?:
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:491: success_count += 1;
	inc	_main_success_count_1_85
	clr	a
	cjne	a,_main_success_count_1_85,L028083?
	inc	(_main_success_count_1_85 + 1)
L028083?:
L028031?:
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:494: if (success_count >= SUCCESS_THRESHOLD) {
	clr	c
	mov	a,_main_success_count_1_85
	subb	a,#0x03
	mov	a,(_main_success_count_1_85 + 1)
	xrl	a,#0x80
	subb	a,#0x80
	jnc	L028084?
	ljmp	L028041?
L028084?:
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:495: if (mode == MODE_RESISTANCE) {
	mov	a,r0
	jz	L028035?
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:496: waitms(166); // Wait for 166 ms
	mov	dptr,#0x00A6
	push	ar4
	push	ar5
	push	ar6
	push	ar7
	lcall	_waitms
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:497: printf("\rR(kOhms) = %f\r\n", R_kOhms); // Print Resistance in Kilohms
	push	_main_R_kOhms_1_85
	push	(_main_R_kOhms_1_85 + 1)
	push	(_main_R_kOhms_1_85 + 2)
	push	(_main_R_kOhms_1_85 + 3)
	mov	a,#__str_11
	push	acc
	mov	a,#(__str_11 >> 8)
	push	acc
	mov	a,#0x80
	push	acc
	lcall	_printf
	mov	a,sp
	add	a,#0xf9
	mov	sp,a
	pop	ar7
	pop	ar6
	pop	ar5
	pop	ar4
L028035?:
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:500: waitms(166); // Wait for 166 ms
	mov	dptr,#0x00A6
	push	ar4
	push	ar5
	push	ar6
	push	ar7
	lcall	_waitms
	pop	ar7
	pop	ar6
	pop	ar5
	pop	ar4
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:501: printf("\rF(kHz) = %f\r\n", freq_Hz / KILO_MULTIPLIER); // Print Frequency to Serial Port
	clr	a
	push	acc
	push	acc
	mov	a,#0x7A
	push	acc
	mov	a,#0x44
	push	acc
	mov	dpl,r6
	mov	dph,r7
	mov	b,r4
	mov	a,r5
	lcall	___fsdiv
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
	mov	r5,a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	mov	a,#__str_12
	push	acc
	mov	a,#(__str_12 >> 8)
	push	acc
	mov	a,#0x80
	push	acc
	lcall	_printf
	mov	a,sp
	add	a,#0xf9
	mov	sp,a
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:503: waitms(166); // Wait for 166 ms
	mov	dptr,#0x00A6
	lcall	_waitms
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:504: printf("\rC(nF) = %f\r\n", capacitance_nF); // Print Capacitance in Nanofarads
	push	_main_capacitance_nF_1_85
	push	(_main_capacitance_nF_1_85 + 1)
	push	(_main_capacitance_nF_1_85 + 2)
	push	(_main_capacitance_nF_1_85 + 3)
	mov	a,#__str_13
	push	acc
	mov	a,#(__str_13 >> 8)
	push	acc
	mov	a,#0x80
	push	acc
	lcall	_printf
	mov	a,sp
	add	a,#0xf9
	mov	sp,a
	pop	ar5
	pop	ar4
	pop	ar3
	pop	ar2
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:506: if (mode == MODE_CAPACITANCE) {
	mov	a,_main_mode_1_85
	orl	a,(_main_mode_1_85 + 1)
	jz	L028086?
	ljmp	L028041?
L028086?:
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:507: display_freq_kHz(freq_Hz / KILO_MULTIPLIER); // Display Frequency on LCD
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	mov	a,r5
	lcall	_display_freq_kHz
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:508: display_capacitance_nF(capacitance_nF);
	mov	dpl,_main_capacitance_nF_1_85
	mov	dph,(_main_capacitance_nF_1_85 + 1)
	mov	b,(_main_capacitance_nF_1_85 + 2)
	mov	a,(_main_capacitance_nF_1_85 + 3)
	lcall	_display_capacitance_nF
	ljmp	L028041?
	rseg R_CSEG

	rseg R_XINIT

	rseg R_CONST
__str_0:
	db 0x1B
	db '[2J'
	db 0x00
__str_1:
	db 'Type Intended Display in Line 2 (16 Char Max): '
	db 0x00
__str_2:
	db 0x0A
	db 0x00
__str_3:
	db 'T: %.3f s'
	db 0x00
__str_4:
	db 'F: %.3f kHz'
	db 0x00
__str_5:
	db 'C: %.3f nF'
	db 0x00
__str_6:
	db 'R: %.3f kOhms'
	db 0x00
__str_7:
	db '                '
	db 0x00
__str_8:
	db 'ERROR : LOW C'
	db 0x00
__str_9:
	db 'ERROR : HIGH C'
	db 0x00
__str_10:
	db 'ERROR : HIGH R'
	db 0x00
__str_11:
	db 0x0D
	db 'R(kOhms) = %f'
	db 0x0D
	db 0x0A
	db 0x00
__str_12:
	db 0x0D
	db 'F(kHz) = %f'
	db 0x0D
	db 0x0A
	db 0x00
__str_13:
	db 0x0D
	db 'C(nF) = %f'
	db 0x0D
	db 0x0A
	db 0x00

	CSEG

end
