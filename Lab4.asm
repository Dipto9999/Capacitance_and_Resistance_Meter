;--------------------------------------------------------
; File Created by C51
; Version 1.0.0 #1170 (Feb 16 2022) (MSVC)
; This file was generated Mon Feb 26 17:07:10 2024
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
	public _main
	public _calculate_capacitance
	public _calculate_freq_kHz
	public _calculate_period
	public _display_capacitance_microF
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
	public __c51_external_startup
	public _LCDprint_PARM_3
	public _calculate_freq_kHz_PARM_3
	public _calculate_freq_kHz_PARM_2
	public _calculate_period_PARM_3
	public _calculate_period_PARM_2
	public _display_rx_PARM_2
	public _write_rx_PARM_2
	public _LCDprint_PARM_2
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
_LCDprint_PARM_2:
	ds 1
_write_rx_PARM_2:
	ds 2
_write_rx_buff_1_47:
	ds 3
_write_rx_sloc0_1_0:
	ds 2
_display_rx_PARM_2:
	ds 2
_display_period_buff_1_55:
	ds 16
_display_freq_kHz_buff_1_57:
	ds 16
_display_capacitance_microF_buff_1_59:
	ds 16
_calculate_period_PARM_2:
	ds 2
_calculate_period_PARM_3:
	ds 2
_calculate_freq_kHz_PARM_2:
	ds 2
_calculate_freq_kHz_PARM_3:
	ds 2
;--------------------------------------------------------
; overlayable items in internal ram 
;--------------------------------------------------------
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
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:40: char _c51_external_startup(void) {
;	-----------------------------------------
;	 function _c51_external_startup
;	-----------------------------------------
__c51_external_startup:
	using	0
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:42: SFRPAGE = 0x00;
	mov	_SFRPAGE,#0x00
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:43: WDTCN = 0xDE; // First Key
	mov	_WDTCN,#0xDE
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:44: WDTCN = 0xAD; // Second Key
	mov	_WDTCN,#0xAD
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:46: VDM0CN |= 0x80;
	orl	_VDM0CN,#0x80
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:47: RSTSRC = 0x02;
	mov	_RSTSRC,#0x02
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:55: SFRPAGE = 0x10;
	mov	_SFRPAGE,#0x10
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:56: PFE0CN  = 0x20; // SYSCLK < 75 MHz.
	mov	_PFE0CN,#0x20
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:57: SFRPAGE = 0x00;
	mov	_SFRPAGE,#0x00
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:79: CLKSEL = 0x00;
	mov	_CLKSEL,#0x00
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:80: CLKSEL = 0x00;
	mov	_CLKSEL,#0x00
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:81: while ((CLKSEL & 0x80) == 0);
L002001?:
	mov	a,_CLKSEL
	jnb	acc.7,L002001?
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:82: CLKSEL = 0x03;
	mov	_CLKSEL,#0x03
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:83: CLKSEL = 0x03;
	mov	_CLKSEL,#0x03
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:84: while ((CLKSEL & 0x80) == 0);
L002004?:
	mov	a,_CLKSEL
	jnb	acc.7,L002004?
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:89: P0MDOUT |= 0x10; // Enable UART0 TX As Push-Pull Output
	orl	_P0MDOUT,#0x10
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:90: XBR0     = 0x01; // Enable UART0 on P0.4 (TX) and P0.5 (RX)
	mov	_XBR0,#0x01
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:91: XBR1     = 0X00; // Enable T0 on P0.0
	mov	_XBR1,#0x00
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:92: XBR2     = 0x40; // Enable Crossbar and Weak Pull-Ups
	mov	_XBR2,#0x40
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:99: SCON0 = 0x10;
	mov	_SCON0,#0x10
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:100: CKCON0 |= 0b_0000_0000 ; // Timer 1 Uses SYSCLK / 12
	mov	_CKCON0,_CKCON0
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:101: TH1 = 0x100-((SYSCLK/BAUDRATE)/(2L*12L)); // Set Timer1 Reload Value, Initial Value
	mov	_TH1,#0xE6
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:102: TL1 = TH1; 	// Init Timer1
	mov	_TL1,_TH1
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:103: TMOD &= ~0xf0;  // TMOD: Timer 1 in 8-bit auto-reload
	anl	_TMOD,#0x0F
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:104: TMOD |=  0x20;
	orl	_TMOD,#0x20
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:105: TR1 = 1; // Start Timer1
	setb	_TR1
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:106: TI = 1;  // Indicate TX0 Ready
	setb	_TI
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:108: return 0;
	mov	dpl,#0x00
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'Timer3us'
;------------------------------------------------------------
;us                        Allocated to registers r2 
;i                         Allocated to registers r3 
;------------------------------------------------------------
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:114: void Timer3us(unsigned char us) {
;	-----------------------------------------
;	 function Timer3us
;	-----------------------------------------
_Timer3us:
	mov	r2,dpl
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:118: CKCON0 |= 0b_0100_0000;
	orl	_CKCON0,#0x40
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:120: TMR3RL = (-(SYSCLK)/1000000L); // Set Timer3 to Overflow in 1us
	mov	_TMR3RL,#0xB8
	mov	(_TMR3RL >> 8),#0xFF
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:121: TMR3 = TMR3RL;                 // Initialize Timer3 for First Overflow
	mov	_TMR3,_TMR3RL
	mov	(_TMR3 >> 8),(_TMR3RL >> 8)
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:123: TMR3CN0 = 0x04;                 // Start Timer3 and Clear Overflow Flag
	mov	_TMR3CN0,#0x04
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:124: for (i = 0; i < us; i++) {      // Count Overflows (#Microseconds)
	mov	r3,#0x00
L003004?:
	clr	c
	mov	a,r3
	subb	a,r2
	jnc	L003007?
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:125: while (!(TMR3CN0 & 0x80));  // Wait for Overflow
L003001?:
	mov	a,_TMR3CN0
	jnb	acc.7,L003001?
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:126: TMR3CN0 &= ~(0x80);         // Clear Overflow Indicator
	anl	_TMR3CN0,#0x7F
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:124: for (i = 0; i < us; i++) {      // Count Overflows (#Microseconds)
	inc	r3
	sjmp	L003004?
L003007?:
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:128: TMR3CN0 = 0 ;                   // Stop Timer3 and Clear Overflow Flag
	mov	_TMR3CN0,#0x00
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'waitms'
;------------------------------------------------------------
;ms                        Allocated to registers r2 r3 
;j                         Allocated to registers r2 r3 
;------------------------------------------------------------
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:131: void waitms (unsigned int ms) {
;	-----------------------------------------
;	 function waitms
;	-----------------------------------------
_waitms:
	mov	r2,dpl
	mov	r3,dph
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:133: for (j = ms; j != 0; j--) {
L004001?:
	cjne	r2,#0x00,L004010?
	cjne	r3,#0x00,L004010?
	ret
L004010?:
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:134: Timer3us(249);
	mov	dpl,#0xF9
	push	ar2
	push	ar3
	lcall	_Timer3us
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:135: Timer3us(249);
	mov	dpl,#0xF9
	lcall	_Timer3us
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:136: Timer3us(249);
	mov	dpl,#0xF9
	lcall	_Timer3us
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:137: Timer3us(250);
	mov	dpl,#0xFA
	lcall	_Timer3us
	pop	ar3
	pop	ar2
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:133: for (j = ms; j != 0; j--) {
	dec	r2
	cjne	r2,#0xff,L004011?
	dec	r3
L004011?:
	sjmp	L004001?
;------------------------------------------------------------
;Allocation info for local variables in function 'TIMER0_Init'
;------------------------------------------------------------
;------------------------------------------------------------
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:141: void TIMER0_Init(void) {
;	-----------------------------------------
;	 function TIMER0_Init
;	-----------------------------------------
_TIMER0_Init:
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:142: TMOD &= 0b_1111_0000; // Set the Bits of Timer/Counter 0 to 0
	anl	_TMOD,#0xF0
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:143: TMOD |= 0b_0000_0001; // Timer/Counter 0 Used As 16-Bit Timer
	orl	_TMOD,#0x01
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:144: TR0 = 0; // Stop Timer/Counter 0
	clr	_TR0
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'Serial_Init'
;------------------------------------------------------------
;------------------------------------------------------------
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:147: void Serial_Init(void) {
;	-----------------------------------------
;	 function Serial_Init
;	-----------------------------------------
_Serial_Init:
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:148: waitms(500); // Give Putty a chance to start.
	mov	dptr,#0x01F4
	lcall	_waitms
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:149: printf("\x1b[2J"); // Clear screen using ANSI escape sequence.
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
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:152: void LCD_pulse(void) {
;	-----------------------------------------
;	 function LCD_pulse
;	-----------------------------------------
_LCD_pulse:
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:153: LCD_E = 1; // Pulse the Enable Pin
	setb	_P2_5
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:154: Timer3us(40); // Wait for 40us
	mov	dpl,#0x28
	lcall	_Timer3us
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:155: LCD_E = 0; // Pulse the Enable Pin
	clr	_P2_5
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'LCD_byte'
;------------------------------------------------------------
;x                         Allocated to registers r2 
;------------------------------------------------------------
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:158: void LCD_byte(unsigned char x) {
;	-----------------------------------------
;	 function LCD_byte
;	-----------------------------------------
_LCD_byte:
	mov	r2,dpl
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:161: ACC = x; // Send High Nibble
	mov	_ACC,r2
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:162: LCD_D7 = ACC_7;
	mov	c,_ACC_7
	mov	_P2_1,c
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:163: LCD_D6 = ACC_6;
	mov	c,_ACC_6
	mov	_P2_2,c
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:164: LCD_D5 = ACC_5;
	mov	c,_ACC_5
	mov	_P2_3,c
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:165: LCD_D4 = ACC_4;
	mov	c,_ACC_4
	mov	_P2_4,c
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:166: LCD_pulse();
	push	ar2
	lcall	_LCD_pulse
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:168: Timer3us(40); // Wait for 40us
	mov	dpl,#0x28
	lcall	_Timer3us
	pop	ar2
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:170: ACC = x; // Send Low Nibble
	mov	_ACC,r2
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:171: LCD_D7 = ACC_3;
	mov	c,_ACC_3
	mov	_P2_1,c
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:172: LCD_D6 = ACC_2;
	mov	c,_ACC_2
	mov	_P2_2,c
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:173: LCD_D5 = ACC_1;
	mov	c,_ACC_1
	mov	_P2_3,c
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:174: LCD_D4 = ACC_0;
	mov	c,_ACC_0
	mov	_P2_4,c
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:175: LCD_pulse();
	ljmp	_LCD_pulse
;------------------------------------------------------------
;Allocation info for local variables in function 'WriteData'
;------------------------------------------------------------
;x                         Allocated to registers r2 
;------------------------------------------------------------
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:178: void WriteData(unsigned char x) {
;	-----------------------------------------
;	 function WriteData
;	-----------------------------------------
_WriteData:
	mov	r2,dpl
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:179: LCD_RS = 1; // Set LCD to Data Mode
	setb	_P2_6
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:180: LCD_byte(x); // Write the Data
	mov	dpl,r2
	lcall	_LCD_byte
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:181: waitms(2); // Wait for 2ms
	mov	dptr,#0x0002
	ljmp	_waitms
;------------------------------------------------------------
;Allocation info for local variables in function 'WriteCommand'
;------------------------------------------------------------
;x                         Allocated to registers r2 
;------------------------------------------------------------
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:184: void WriteCommand(unsigned char x) {
;	-----------------------------------------
;	 function WriteCommand
;	-----------------------------------------
_WriteCommand:
	mov	r2,dpl
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:185: LCD_RS = 0; // Set LCD to Command Mode
	clr	_P2_6
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:186: LCD_byte(x); // Write the Command
	mov	dpl,r2
	lcall	_LCD_byte
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:187: waitms(5); // Wait for 5ms
	mov	dptr,#0x0005
	ljmp	_waitms
;------------------------------------------------------------
;Allocation info for local variables in function 'LCD_4BIT'
;------------------------------------------------------------
;------------------------------------------------------------
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:190: void LCD_4BIT(void) {
;	-----------------------------------------
;	 function LCD_4BIT
;	-----------------------------------------
_LCD_4BIT:
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:191: LCD_E = 0; // Resting State of LCD Enable Pin is 0.
	clr	_P2_5
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:192: waitms(20); // Wait for 20ms
	mov	dptr,#0x0014
	lcall	_waitms
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:195: WriteCommand(0x33); // Change to 8-bit Mode
	mov	dpl,#0x33
	lcall	_WriteCommand
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:196: WriteCommand(0x33); // Change to 8-bit Mode
	mov	dpl,#0x33
	lcall	_WriteCommand
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:197: WriteCommand(0x32); // Change to 4-bit Mode
	mov	dpl,#0x32
	lcall	_WriteCommand
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:200: WriteCommand(0x28); // 4-bit, 2 Line, 5x7 Dots
	mov	dpl,#0x28
	lcall	_WriteCommand
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:201: WriteCommand(0x0c); // Display On, No Cursor, No Blink
	mov	dpl,#0x0C
	lcall	_WriteCommand
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:202: WriteCommand(0x01); // Clear Screen Command (Takes Some Time)
	mov	dpl,#0x01
	lcall	_WriteCommand
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:203: waitms(20); // Wait 20ms for Clear Screen Command to Finish
	mov	dptr,#0x0014
	ljmp	_waitms
;------------------------------------------------------------
;Allocation info for local variables in function 'LCDprint'
;------------------------------------------------------------
;line                      Allocated with name '_LCDprint_PARM_2'
;string                    Allocated to registers r2 r3 r4 
;j                         Allocated to registers r5 r6 
;------------------------------------------------------------
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:206: void LCDprint(char * string, unsigned char line, bit clear) {
;	-----------------------------------------
;	 function LCDprint
;	-----------------------------------------
_LCDprint:
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:209: WriteCommand(line == 2 ? 0xc0 : 0x80); // Set Cursor
	mov	a,#0x02
	cjne	a,_LCDprint_PARM_2,L012013?
	mov	r5,#0xC0
	sjmp	L012014?
L012013?:
	mov	r5,#0x80
L012014?:
	mov	dpl,r5
	push	ar2
	push	ar3
	push	ar4
	lcall	_WriteCommand
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:210: waitms(5); // Wait for 5ms
	mov	dptr,#0x0005
	lcall	_waitms
	pop	ar4
	pop	ar3
	pop	ar2
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:211: for (j = 0; string[j] != 0; j++) WriteData(string[j]); // Write Message
	mov	r5,#0x00
	mov	r6,#0x00
L012003?:
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
	jz	L012006?
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
	cjne	r5,#0x00,L012003?
	inc	r6
	sjmp	L012003?
L012006?:
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:212: if (clear) for (; j < CHARS_PER_LINE; j++) WriteData(' '); // Clear Rest of Line
	jnb	_LCDprint_PARM_3,L012011?
	mov	ar2,r5
	mov	ar3,r6
L012007?:
	clr	c
	mov	a,r2
	subb	a,#0x10
	mov	a,r3
	xrl	a,#0x80
	subb	a,#0x80
	jnc	L012011?
	mov	dpl,#0x20
	push	ar2
	push	ar3
	lcall	_WriteData
	pop	ar3
	pop	ar2
	inc	r2
	cjne	r2,#0x00,L012007?
	inc	r3
	sjmp	L012007?
L012011?:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'write_rx'
;------------------------------------------------------------
;len                       Allocated with name '_write_rx_PARM_2'
;buff                      Allocated with name '_write_rx_buff_1_47'
;j                         Allocated with name '_write_rx_sloc0_1_0'
;c                         Allocated to registers r3 
;sloc0                     Allocated with name '_write_rx_sloc0_1_0'
;------------------------------------------------------------
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:215: int write_rx(char* buff, int len) {
;	-----------------------------------------
;	 function write_rx
;	-----------------------------------------
_write_rx:
	mov	_write_rx_buff_1_47,dpl
	mov	(_write_rx_buff_1_47 + 1),dph
	mov	(_write_rx_buff_1_47 + 2),b
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:219: for (j = 0; j < (len-1); j++) {
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
L013005?:
	clr	c
	mov	a,r1
	subb	a,r7
	mov	a,r2
	xrl	a,#0x80
	mov	b,r0
	xrl	b,#0x80
	subb	a,b
	jnc	L013008?
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:220: c = getchar();
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
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:221: if ( (c == '\n') || (c == '\r') ) {
	cjne	r3,#0x0A,L013015?
	sjmp	L013001?
L013015?:
	cjne	r3,#0x0D,L013002?
L013001?:
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:222: buff[j] = 0;
	mov	a,_write_rx_sloc0_1_0
	add	a,_write_rx_buff_1_47
	mov	r4,a
	mov	a,(_write_rx_sloc0_1_0 + 1)
	addc	a,(_write_rx_buff_1_47 + 1)
	mov	r5,a
	mov	r6,(_write_rx_buff_1_47 + 2)
	mov	dpl,r4
	mov	dph,r5
	mov	b,r6
	clr	a
	lcall	__gptrput
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:223: return j;
	mov	dpl,_write_rx_sloc0_1_0
	mov	dph,(_write_rx_sloc0_1_0 + 1)
	ret
L013002?:
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:225: buff[j] = c;
	mov	a,r1
	add	a,_write_rx_buff_1_47
	mov	r4,a
	mov	a,r2
	addc	a,(_write_rx_buff_1_47 + 1)
	mov	r5,a
	mov	r6,(_write_rx_buff_1_47 + 2)
	mov	dpl,r4
	mov	dph,r5
	mov	b,r6
	mov	a,r3
	lcall	__gptrput
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:219: for (j = 0; j < (len-1); j++) {
	inc	r1
	cjne	r1,#0x00,L013018?
	inc	r2
L013018?:
	mov	_write_rx_sloc0_1_0,r1
	mov	(_write_rx_sloc0_1_0 + 1),r2
	sjmp	L013005?
L013008?:
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:228: buff[j] = 0;
	mov	a,_write_rx_sloc0_1_0
	add	a,_write_rx_buff_1_47
	mov	r2,a
	mov	a,(_write_rx_sloc0_1_0 + 1)
	addc	a,(_write_rx_buff_1_47 + 1)
	mov	r3,a
	mov	r4,(_write_rx_buff_1_47 + 2)
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	clr	a
	lcall	__gptrput
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:229: return len;
	mov	dpl,_write_rx_PARM_2
	mov	dph,(_write_rx_PARM_2 + 1)
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'display_rx'
;------------------------------------------------------------
;len                       Allocated with name '_display_rx_PARM_2'
;buff                      Allocated to registers r2 r3 r4 
;------------------------------------------------------------
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:232: void display_rx(char* buff, int len) {
;	-----------------------------------------
;	 function display_rx
;	-----------------------------------------
_display_rx:
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:233: printf("Type Intended Display in Line 2 (16 Char Max): ");
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
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:234: write_rx(buff, len);
	mov	_write_rx_PARM_2,_display_rx_PARM_2
	mov	(_write_rx_PARM_2 + 1),(_display_rx_PARM_2 + 1)
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	push	ar2
	push	ar3
	push	ar4
	lcall	_write_rx
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:235: printf("\n");
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
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:236: LCDprint(buff, 1, 1);
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
;buff                      Allocated with name '_display_period_buff_1_55'
;------------------------------------------------------------
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:239: void display_period(float period) {
;	-----------------------------------------
;	 function display_period
;	-----------------------------------------
_display_period:
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
	mov	r5,a
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:241: sprintf(buff, "T: %f s", (float)(period)); // Format the Period Value
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
	mov	a,#_display_period_buff_1_55
	push	acc
	mov	a,#(_display_period_buff_1_55 >> 8)
	push	acc
	mov	a,#0x40
	push	acc
	lcall	_sprintf
	mov	a,sp
	add	a,#0xf6
	mov	sp,a
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:242: LCDprint(buff, 2, 1); // Write to LCD
	mov	_LCDprint_PARM_2,#0x02
	setb	_LCDprint_PARM_3
	mov	dptr,#_display_period_buff_1_55
	mov	b,#0x40
	ljmp	_LCDprint
;------------------------------------------------------------
;Allocation info for local variables in function 'display_freq_kHz'
;------------------------------------------------------------
;freq_kHz                  Allocated to registers r2 r3 r4 r5 
;buff                      Allocated with name '_display_freq_kHz_buff_1_57'
;------------------------------------------------------------
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:245: void display_freq_kHz(float freq_kHz) {
;	-----------------------------------------
;	 function display_freq_kHz
;	-----------------------------------------
_display_freq_kHz:
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:247: sprintf(buff, "F: %i kHz", (int)(freq_kHz)); // Format the Frequency Value
	lcall	___fs2sint
	mov	r2,dpl
	mov	r3,dph
	push	ar2
	push	ar3
	mov	a,#__str_4
	push	acc
	mov	a,#(__str_4 >> 8)
	push	acc
	mov	a,#0x80
	push	acc
	mov	a,#_display_freq_kHz_buff_1_57
	push	acc
	mov	a,#(_display_freq_kHz_buff_1_57 >> 8)
	push	acc
	mov	a,#0x40
	push	acc
	lcall	_sprintf
	mov	a,sp
	add	a,#0xf8
	mov	sp,a
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:248: LCDprint(buff, 2, 1); // Write to LCD
	mov	_LCDprint_PARM_2,#0x02
	setb	_LCDprint_PARM_3
	mov	dptr,#_display_freq_kHz_buff_1_57
	mov	b,#0x40
	ljmp	_LCDprint
;------------------------------------------------------------
;Allocation info for local variables in function 'display_capacitance_microF'
;------------------------------------------------------------
;capacitance_microF        Allocated to registers r2 r3 r4 r5 
;buff                      Allocated with name '_display_capacitance_microF_buff_1_59'
;------------------------------------------------------------
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:251: void display_capacitance_microF(float capacitance_microF) {
;	-----------------------------------------
;	 function display_capacitance_microF
;	-----------------------------------------
_display_capacitance_microF:
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:254: sprintf(buff, "C: %i µF", (int)(capacitance_microF)); // Format the Capacitance Value
	lcall	___fs2sint
	mov	r2,dpl
	mov	r3,dph
	push	ar2
	push	ar3
	mov	a,#__str_5
	push	acc
	mov	a,#(__str_5 >> 8)
	push	acc
	mov	a,#0x80
	push	acc
	mov	a,#_display_capacitance_microF_buff_1_59
	push	acc
	mov	a,#(_display_capacitance_microF_buff_1_59 >> 8)
	push	acc
	mov	a,#0x40
	push	acc
	lcall	_sprintf
	mov	a,sp
	add	a,#0xf8
	mov	sp,a
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:255: LCDprint(buff, 2, 1); // Write to LCD
	mov	_LCDprint_PARM_2,#0x02
	setb	_LCDprint_PARM_3
	mov	dptr,#_display_capacitance_microF_buff_1_59
	mov	b,#0x40
	ljmp	_LCDprint
;------------------------------------------------------------
;Allocation info for local variables in function 'calculate_period'
;------------------------------------------------------------
;TH0                       Allocated with name '_calculate_period_PARM_2'
;TL0                       Allocated with name '_calculate_period_PARM_3'
;overflow_count            Allocated to registers r2 r3 
;------------------------------------------------------------
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:264: float calculate_period(int overflow_count, int TH0, int TL0) {
;	-----------------------------------------
;	 function calculate_period
;	-----------------------------------------
_calculate_period:
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:265: return ((overflow_count * MAX_16_BIT)  + (TH0 * MAX_8_BIT) + TL0) * (12.0 / SYSCLK);
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
	mov	dpl,_calculate_period_PARM_2
	mov	dph,(_calculate_period_PARM_2 + 1)
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
	mov	dpl,_calculate_period_PARM_3
	mov	dph,(_calculate_period_PARM_3 + 1)
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
;Allocation info for local variables in function 'calculate_freq_kHz'
;------------------------------------------------------------
;TH0                       Allocated with name '_calculate_freq_kHz_PARM_2'
;TL0                       Allocated with name '_calculate_freq_kHz_PARM_3'
;overflow_count            Allocated to registers r2 r3 
;------------------------------------------------------------
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:268: float calculate_freq_kHz(int overflow_count, int TH0, int TL0) {
;	-----------------------------------------
;	 function calculate_freq_kHz
;	-----------------------------------------
_calculate_freq_kHz:
	mov	r2,dpl
	mov	r3,dph
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:269: return 1.0 / calculate_period(overflow_count, TH0, TL0);
	mov	_calculate_period_PARM_2,_calculate_freq_kHz_PARM_2
	mov	(_calculate_period_PARM_2 + 1),(_calculate_freq_kHz_PARM_2 + 1)
	mov	_calculate_period_PARM_3,_calculate_freq_kHz_PARM_3
	mov	(_calculate_period_PARM_3 + 1),(_calculate_freq_kHz_PARM_3 + 1)
	mov	dpl,r2
	mov	dph,r3
	lcall	_calculate_period
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
;Allocation info for local variables in function 'calculate_capacitance'
;------------------------------------------------------------
;period_s                  Allocated to registers r2 r3 r4 r5 
;------------------------------------------------------------
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:272: float calculate_capacitance(float period_s) {
;	-----------------------------------------
;	 function calculate_capacitance
;	-----------------------------------------
_calculate_capacitance:
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
	mov	r5,a
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:273: return (1.44 * period_s / (R_A + 2 * R_B)) * TERA_MULTIPLIER;
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
	mov	dptr,#0xD4A5
	mov	b,#0x68
	mov	a,#0x53
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
;Allocation info for local variables in function 'main'
;------------------------------------------------------------
;period_s                  Allocated to registers r2 r3 r4 r5 
;capacitance_pF            Allocated to registers r2 r3 r4 r5 
;------------------------------------------------------------
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:276: void main(void) {
;	-----------------------------------------
;	 function main
;	-----------------------------------------
_main:
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:281: TIMER0_Init(); // Initialize Timer 0
	lcall	_TIMER0_Init
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:282: Serial_Init(); // Initialize Serial Communication
	lcall	_Serial_Init
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:283: LCD_4BIT();	// Configure the LCD
	lcall	_LCD_4BIT
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:285: LCDprint("LCD 4-Bit Test", 1, 1);
	mov	_LCDprint_PARM_2,#0x01
	setb	_LCDprint_PARM_3
	mov	dptr,#__str_6
	mov	b,#0x80
	lcall	_LCDprint
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:286: LCDprint("Hello, World!", 2, 1);
	mov	_LCDprint_PARM_2,#0x02
	setb	_LCDprint_PARM_3
	mov	dptr,#__str_7
	mov	b,#0x80
	lcall	_LCDprint
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:293: );
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:292: __FILE__, __DATE__, __TIME__
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:291: "Compiled: %s, %s\n\r\n",
	mov	a,#__str_11
	push	acc
	mov	a,#(__str_11 >> 8)
	push	acc
	mov	a,#0x80
	push	acc
	mov	a,#__str_10
	push	acc
	mov	a,#(__str_10 >> 8)
	push	acc
	mov	a,#0x80
	push	acc
	mov	a,#__str_9
	push	acc
	mov	a,#(__str_9 >> 8)
	push	acc
	mov	a,#0x80
	push	acc
	mov	a,#__str_8
	push	acc
	mov	a,#(__str_8 >> 8)
	push	acc
	mov	a,#0x80
	push	acc
	lcall	_printf
	mov	a,sp
	add	a,#0xf4
	mov	sp,a
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:295: while(1) {
L021018?:
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:297: TL0 = 0;
	mov	_TL0,#0x00
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:298: TH0 = 0;
	mov	_TH0,#0x00
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:299: TF0 = 0;
	clr	_TF0
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:300: overflow_count = 0;
	mov	_overflow_count,#0x00
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:302: while (EFM8_SIGNAL != 0); // Wait for Signal == 0
L021001?:
	jb	_P0_1,L021001?
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:303: while (EFM8_SIGNAL != 1); // Wait for Signal == 1
L021004?:
	jnb	_P0_1,L021004?
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:305: TR0 = 1; // Start Timer
	setb	_TR0
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:307: while (EFM8_SIGNAL != 0) { // Wait for Signal == 0
L021009?:
	jnb	_P0_1,L021014?
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:308: if (TF0 == 1) { // Did 16-Bit Timer Overflow?
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:309: TF0 = 0;
	jbc	_TF0,L021035?
	sjmp	L021009?
L021035?:
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:310: overflow_count++;
	inc	_overflow_count
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:313: while (EFM8_SIGNAL != 1) { // Wait for Signal == 1
	sjmp	L021009?
L021014?:
	jb	_P0_1,L021016?
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:314: if (TF0 == 1) { // Did 16-Bit Timer Overflow?
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:315: TF0 = 0;
	jbc	_TF0,L021037?
	sjmp	L021014?
L021037?:
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:316: overflow_count++;
	inc	_overflow_count
	sjmp	L021014?
L021016?:
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:320: TR0 = 0; // Stop Timer 0. The 24-bit number [overflow_count-TH0-TL0] has the period!
	clr	_TR0
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:321: period_s = calculate_period(overflow_count, TH0, TL0);
	mov	r2,_overflow_count
	mov	r3,#0x00
	mov	_calculate_period_PARM_2,_TH0
	mov	(_calculate_period_PARM_2 + 1),#0x00
	mov	_calculate_period_PARM_3,_TL0
	mov	(_calculate_period_PARM_3 + 1),#0x00
	mov	dpl,r2
	mov	dph,r3
	lcall	_calculate_period
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:322: capacitance_pF = calculate_capacitance(period_s);
	lcall	_calculate_capacitance
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
	mov	r5,a
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:341: printf("\rC(µF)=%f", (capacitance_pF / MEGA_MULTIPLIER));
	clr	a
	push	acc
	mov	a,#0x24
	push	acc
	mov	a,#0x74
	push	acc
	mov	a,#0x49
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
	pop	ar5
	pop	ar4
	pop	ar3
	pop	ar2
;	C:\Muntakim_Files\School\School_Work\Engineering_Bachelors\2023\ELEC_291\Lab_4\ELEC291_Lab4\Lab4.c:342: display_capacitance_microF(capacitance_pF / MEGA_MULTIPLIER);
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	mov	a,r5
	lcall	_display_capacitance_microF
	ljmp	L021018?
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
	db 'T: %f s'
	db 0x00
__str_4:
	db 'F: %i kHz'
	db 0x00
__str_5:
	db 'C: %i '
	db 0xC2
	db 0xB5
	db 'F'
	db 0x00
__str_6:
	db 'LCD 4-Bit Test'
	db 0x00
__str_7:
	db 'Hello, World!'
	db 0x00
__str_8:
	db 0x0D
	db 'EFM8 Period measurement at pin P0.1 using Timer 0.'
	db 0x0A
	db 'File: %s'
	db 0x0A
	db 'Compiled: %s, %s'
	db 0x0A
	db 0x0D
	db 0x0A
	db 0x00
__str_9:
	db 'C:'
	db 0x5C
	db 'Muntakim_Files'
	db 0x5C
	db 'School'
	db 0x5C
	db 'School_Work'
	db 0x5C
	db 'Engineering_Bachelors'
	db 0x5C
	db '2'
	db '023'
	db 0x5C
	db 'ELEC_291'
	db 0x5C
	db 'Lab_4'
	db 0x5C
	db 'ELEC291_Lab4'
	db 0x5C
	db 'Lab4.c'
	db 0x00
__str_10:
	db 'Feb 26 2024'
	db 0x00
__str_11:
	db '17:07:10'
	db 0x00
__str_12:
	db 0x0D
	db 'C('
	db 0xC2
	db 0xB5
	db 'F)=%f'
	db 0x00

	CSEG

end
