
;CodeVisionAVR C Compiler V1.24.8d Professional
;(C) Copyright 1998-2006 Pavel Haiduc, HP InfoTech s.r.l.
;http://www.hpinfotech.com

;Chip type              : ATmega8
;Program type           : Application
;Clock frequency        : 8,000000 MHz
;Memory model           : Small
;Optimize for           : Size
;(s)printf features     : int, width
;(s)scanf features      : int, width
;External SRAM size     : 0
;Data Stack size        : 256 byte(s)
;Heap size              : 0 byte(s)
;Promote char to int    : No
;char is unsigned       : Yes
;8 bit enums            : No
;Word align FLASH struct: No
;Enhanced core instructions    : On
;Automatic register allocation : On

	#pragma AVRPART ADMIN PART_NAME ATmega8
	#pragma AVRPART MEMORY PROG_FLASH 8192
	#pragma AVRPART MEMORY EEPROM 512
	#pragma AVRPART MEMORY INT_SRAM SIZE 1024
	#pragma AVRPART MEMORY INT_SRAM START_ADDR 0x60

	.EQU UDRE=0x5
	.EQU RXC=0x7
	.EQU USR=0xB
	.EQU UDR=0xC
	.EQU SPSR=0xE
	.EQU SPDR=0xF
	.EQU EERE=0x0
	.EQU EEWE=0x1
	.EQU EEMWE=0x2
	.EQU EECR=0x1C
	.EQU EEDR=0x1D
	.EQU EEARL=0x1E
	.EQU EEARH=0x1F
	.EQU WDTCR=0x21
	.EQU MCUCR=0x35
	.EQU GICR=0x3B
	.EQU SPL=0x3D
	.EQU SPH=0x3E
	.EQU SREG=0x3F

	.DEF R0X0=R0
	.DEF R0X1=R1
	.DEF R0X2=R2
	.DEF R0X3=R3
	.DEF R0X4=R4
	.DEF R0X5=R5
	.DEF R0X6=R6
	.DEF R0X7=R7
	.DEF R0X8=R8
	.DEF R0X9=R9
	.DEF R0XA=R10
	.DEF R0XB=R11
	.DEF R0XC=R12
	.DEF R0XD=R13
	.DEF R0XE=R14
	.DEF R0XF=R15
	.DEF R0X10=R16
	.DEF R0X11=R17
	.DEF R0X12=R18
	.DEF R0X13=R19
	.DEF R0X14=R20
	.DEF R0X15=R21
	.DEF R0X16=R22
	.DEF R0X17=R23
	.DEF R0X18=R24
	.DEF R0X19=R25
	.DEF R0X1A=R26
	.DEF R0X1B=R27
	.DEF R0X1C=R28
	.DEF R0X1D=R29
	.DEF R0X1E=R30
	.DEF R0X1F=R31

	.EQU __se_bit=0x80
	.EQU __sm_mask=0x70
	.EQU __sm_adc_noise_red=0x10
	.EQU __sm_powerdown=0x20
	.EQU __sm_powersave=0x30
	.EQU __sm_standby=0x60
	.EQU __sm_ext_standby=0x70

	.MACRO __CPD1N
	CPI  R30,LOW(@0)
	LDI  R26,HIGH(@0)
	CPC  R31,R26
	LDI  R26,BYTE3(@0)
	CPC  R22,R26
	LDI  R26,BYTE4(@0)
	CPC  R23,R26
	.ENDM

	.MACRO __CPD2N
	CPI  R26,LOW(@0)
	LDI  R30,HIGH(@0)
	CPC  R27,R30
	LDI  R30,BYTE3(@0)
	CPC  R24,R30
	LDI  R30,BYTE4(@0)
	CPC  R25,R30
	.ENDM

	.MACRO __CPWRR
	CP   R@0,R@2
	CPC  R@1,R@3
	.ENDM

	.MACRO __CPWRN
	CPI  R@0,LOW(@2)
	LDI  R30,HIGH(@2)
	CPC  R@1,R30
	.ENDM

	.MACRO __ADDB1MN
	SUBI R30,LOW(-@0-(@1))
	.ENDM
	.MACRO __ADDB2MN
	SUBI R26,LOW(-@0-(@1))
	.ENDM
	.MACRO __ADDW1MN
	SUBI R30,LOW(-@0-(@1))
	SBCI R31,HIGH(-@0-(@1))
	.ENDM
	.MACRO __ADDW2MN
	SUBI R26,LOW(-@0-(@1))
	SBCI R27,HIGH(-@0-(@1))
	.ENDM
	.MACRO __ADDW1FN
	SUBI R30,LOW(-2*@0-(@1))
	SBCI R31,HIGH(-2*@0-(@1))
	.ENDM
	.MACRO __ADDD1FN
	SUBI R30,LOW(-2*@0-(@1))
	SBCI R31,HIGH(-2*@0-(@1))
	SBCI R22,BYTE3(-2*@0-(@1))
	.ENDM
	.MACRO __ADDD1N
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	SBCI R22,BYTE3(-@0)
	SBCI R23,BYTE4(-@0)
	.ENDM

	.MACRO __ADDD2N
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	SBCI R24,BYTE3(-@0)
	SBCI R25,BYTE4(-@0)
	.ENDM

	.MACRO __SUBD1N
	SUBI R30,LOW(@0)
	SBCI R31,HIGH(@0)
	SBCI R22,BYTE3(@0)
	SBCI R23,BYTE4(@0)
	.ENDM

	.MACRO __SUBD2N
	SUBI R26,LOW(@0)
	SBCI R27,HIGH(@0)
	SBCI R24,BYTE3(@0)
	SBCI R25,BYTE4(@0)
	.ENDM

	.MACRO __ANDBMNN
	LDS  R30,@0+@1
	ANDI R30,LOW(@2)
	STS  @0+@1,R30
	.ENDM

	.MACRO __ANDWMNN
	LDS  R30,@0+@1
	ANDI R30,LOW(@2)
	STS  @0+@1,R30
	LDS  R30,@0+@1+1
	ANDI R30,HIGH(@2)
	STS  @0+@1+1,R30
	.ENDM

	.MACRO __ANDD1N
	ANDI R30,LOW(@0)
	ANDI R31,HIGH(@0)
	ANDI R22,BYTE3(@0)
	ANDI R23,BYTE4(@0)
	.ENDM

	.MACRO __ORBMNN
	LDS  R30,@0+@1
	ORI  R30,LOW(@2)
	STS  @0+@1,R30
	.ENDM

	.MACRO __ORWMNN
	LDS  R30,@0+@1
	ORI  R30,LOW(@2)
	STS  @0+@1,R30
	LDS  R30,@0+@1+1
	ORI  R30,HIGH(@2)
	STS  @0+@1+1,R30
	.ENDM

	.MACRO __ORD1N
	ORI  R30,LOW(@0)
	ORI  R31,HIGH(@0)
	ORI  R22,BYTE3(@0)
	ORI  R23,BYTE4(@0)
	.ENDM

	.MACRO __DELAY_USB
	LDI  R24,LOW(@0)
__DELAY_USB_LOOP:
	DEC  R24
	BRNE __DELAY_USB_LOOP
	.ENDM

	.MACRO __DELAY_USW
	LDI  R24,LOW(@0)
	LDI  R25,HIGH(@0)
__DELAY_USW_LOOP:
	SBIW R24,1
	BRNE __DELAY_USW_LOOP
	.ENDM

	.MACRO __CLRD1S
	LDI  R30,0
	STD  Y+@0,R30
	STD  Y+@0+1,R30
	STD  Y+@0+2,R30
	STD  Y+@0+3,R30
	.ENDM

	.MACRO __GETD1S
	LDD  R30,Y+@0
	LDD  R31,Y+@0+1
	LDD  R22,Y+@0+2
	LDD  R23,Y+@0+3
	.ENDM

	.MACRO __PUTD1S
	STD  Y+@0,R30
	STD  Y+@0+1,R31
	STD  Y+@0+2,R22
	STD  Y+@0+3,R23
	.ENDM

	.MACRO __PUTD2S
	STD  Y+@0,R26
	STD  Y+@0+1,R27
	STD  Y+@0+2,R24
	STD  Y+@0+3,R25
	.ENDM

	.MACRO __POINTB1MN
	LDI  R30,LOW(@0+@1)
	.ENDM

	.MACRO __POINTW1MN
	LDI  R30,LOW(@0+@1)
	LDI  R31,HIGH(@0+@1)
	.ENDM

	.MACRO __POINTD1M
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	.ENDM

	.MACRO __POINTW1FN
	LDI  R30,LOW(2*@0+@1)
	LDI  R31,HIGH(2*@0+@1)
	.ENDM

	.MACRO __POINTD1FN
	LDI  R30,LOW(2*@0+@1)
	LDI  R31,HIGH(2*@0+@1)
	LDI  R22,BYTE3(2*@0+@1)
	.ENDM

	.MACRO __POINTB2MN
	LDI  R26,LOW(@0+@1)
	.ENDM

	.MACRO __POINTW2MN
	LDI  R26,LOW(@0+@1)
	LDI  R27,HIGH(@0+@1)
	.ENDM

	.MACRO __POINTBRM
	LDI  R@0,LOW(@1)
	.ENDM

	.MACRO __POINTWRM
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __POINTBRMN
	LDI  R@0,LOW(@1+@2)
	.ENDM

	.MACRO __POINTWRMN
	LDI  R@0,LOW(@2+@3)
	LDI  R@1,HIGH(@2+@3)
	.ENDM

	.MACRO __POINTWRFN
	LDI  R@0,LOW(@2*2+@3)
	LDI  R@1,HIGH(@2*2+@3)
	.ENDM

	.MACRO __GETD1N
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __GETD2N
	LDI  R26,LOW(@0)
	LDI  R27,HIGH(@0)
	LDI  R24,BYTE3(@0)
	LDI  R25,BYTE4(@0)
	.ENDM

	.MACRO __GETD2S
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	LDD  R24,Y+@0+2
	LDD  R25,Y+@0+3
	.ENDM

	.MACRO __GETB1MN
	LDS  R30,@0+@1
	.ENDM

	.MACRO __GETB1HMN
	LDS  R31,@0+@1
	.ENDM

	.MACRO __GETW1MN
	LDS  R30,@0+@1
	LDS  R31,@0+@1+1
	.ENDM

	.MACRO __GETD1MN
	LDS  R30,@0+@1
	LDS  R31,@0+@1+1
	LDS  R22,@0+@1+2
	LDS  R23,@0+@1+3
	.ENDM

	.MACRO __GETBRMN
	LDS  R@0,@1+@2
	.ENDM

	.MACRO __GETWRMN
	LDS  R@0,@2+@3
	LDS  R@1,@2+@3+1
	.ENDM

	.MACRO __GETWRZ
	LDD  R@0,Z+@2
	LDD  R@1,Z+@2+1
	.ENDM

	.MACRO __GETD2Z
	LDD  R26,Z+@0
	LDD  R27,Z+@0+1
	LDD  R24,Z+@0+2
	LDD  R25,Z+@0+3
	.ENDM

	.MACRO __GETB2MN
	LDS  R26,@0+@1
	.ENDM

	.MACRO __GETW2MN
	LDS  R26,@0+@1
	LDS  R27,@0+@1+1
	.ENDM

	.MACRO __GETD2MN
	LDS  R26,@0+@1
	LDS  R27,@0+@1+1
	LDS  R24,@0+@1+2
	LDS  R25,@0+@1+3
	.ENDM

	.MACRO __PUTB1MN
	STS  @0+@1,R30
	.ENDM

	.MACRO __PUTW1MN
	STS  @0+@1,R30
	STS  @0+@1+1,R31
	.ENDM

	.MACRO __PUTD1MN
	STS  @0+@1,R30
	STS  @0+@1+1,R31
	STS  @0+@1+2,R22
	STS  @0+@1+3,R23
	.ENDM

	.MACRO __PUTDZ2
	STD  Z+@0,R26
	STD  Z+@0+1,R27
	STD  Z+@0+2,R24
	STD  Z+@0+3,R25
	.ENDM

	.MACRO __PUTBMRN
	STS  @0+@1,R@2
	.ENDM

	.MACRO __PUTWMRN
	STS  @0+@1,R@2
	STS  @0+@1+1,R@3
	.ENDM

	.MACRO __PUTBZR
	STD  Z+@1,R@0
	.ENDM

	.MACRO __PUTWZR
	STD  Z+@2,R@0
	STD  Z+@2+1,R@1
	.ENDM

	.MACRO __GETW1R
	MOV  R30,R@0
	MOV  R31,R@1
	.ENDM

	.MACRO __GETW2R
	MOV  R26,R@0
	MOV  R27,R@1
	.ENDM

	.MACRO __GETWRN
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __PUTW1R
	MOV  R@0,R30
	MOV  R@1,R31
	.ENDM

	.MACRO __PUTW2R
	MOV  R@0,R26
	MOV  R@1,R27
	.ENDM

	.MACRO __ADDWRN
	SUBI R@0,LOW(-@2)
	SBCI R@1,HIGH(-@2)
	.ENDM

	.MACRO __ADDWRR
	ADD  R@0,R@2
	ADC  R@1,R@3
	.ENDM

	.MACRO __SUBWRN
	SUBI R@0,LOW(@2)
	SBCI R@1,HIGH(@2)
	.ENDM

	.MACRO __SUBWRR
	SUB  R@0,R@2
	SBC  R@1,R@3
	.ENDM

	.MACRO __ANDWRN
	ANDI R@0,LOW(@2)
	ANDI R@1,HIGH(@2)
	.ENDM

	.MACRO __ANDWRR
	AND  R@0,R@2
	AND  R@1,R@3
	.ENDM

	.MACRO __ORWRN
	ORI  R@0,LOW(@2)
	ORI  R@1,HIGH(@2)
	.ENDM

	.MACRO __ORWRR
	OR   R@0,R@2
	OR   R@1,R@3
	.ENDM

	.MACRO __EORWRR
	EOR  R@0,R@2
	EOR  R@1,R@3
	.ENDM

	.MACRO __GETWRS
	LDD  R@0,Y+@2
	LDD  R@1,Y+@2+1
	.ENDM

	.MACRO __PUTWSR
	STD  Y+@2,R@0
	STD  Y+@2+1,R@1
	.ENDM

	.MACRO __MOVEWRR
	MOV  R@0,R@2
	MOV  R@1,R@3
	.ENDM

	.MACRO __INWR
	IN   R@0,@2
	IN   R@1,@2+1
	.ENDM

	.MACRO __OUTWR
	OUT  @2+1,R@1
	OUT  @2,R@0
	.ENDM

	.MACRO __CALL1MN
	LDS  R30,@0+@1
	LDS  R31,@0+@1+1
	ICALL
	.ENDM

	.MACRO __CALL1FN
	LDI  R30,LOW(2*@0+@1)
	LDI  R31,HIGH(2*@0+@1)
	RCALL __GETW1PF
	ICALL
	.ENDM

	.MACRO __CALL2EN
	LDI  R26,LOW(@0+@1)
	LDI  R27,HIGH(@0+@1)
	RCALL __EEPROMRDW
	ICALL
	.ENDM

	.MACRO __GETW1STACK
	IN   R26,SPL
	IN   R27,SPH
	ADIW R26,@0+1
	LD   R30,X+
	LD   R31,X
	.ENDM

	.MACRO __NBST
	BST  R@0,@1
	IN   R30,SREG
	LDI  R31,0x40
	EOR  R30,R31
	OUT  SREG,R30
	.ENDM


	.MACRO __PUTB1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	RCALL __PUTDP1
	.ENDM

	.MACRO __PUTB1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	RCALL __PUTDP1
	.ENDM

	.MACRO __PUTB1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	RCALL __PUTDP1
	.ENDM

	.MACRO __PUTB1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	RCALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	RCALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RNS
	MOVW R26,R@0
	ADIW R26,@1
	RCALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	RCALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	RCALL __PUTDP1
	.ENDM


	.MACRO __GETB1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R30,Z
	.ENDM

	.MACRO __GETB1HSX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
	.ENDM

	.MACRO __GETW1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R0,Z+
	LD   R31,Z
	MOV  R30,R0
	.ENDM

	.MACRO __GETD1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R0,Z+
	LD   R1,Z+
	LD   R22,Z+
	LD   R23,Z
	MOVW R30,R0
	.ENDM

	.MACRO __GETB2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R26,X
	.ENDM

	.MACRO __GETW2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	.ENDM

	.MACRO __GETD2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R1,X+
	LD   R24,X+
	LD   R25,X
	MOVW R26,R0
	.ENDM

	.MACRO __GETBRSX
	MOVW R30,R28
	SUBI R30,LOW(-@1)
	SBCI R31,HIGH(-@1)
	LD   R@0,Z
	.ENDM

	.MACRO __GETWRSX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	LD   R@0,Z+
	LD   R@1,Z
	.ENDM

	.MACRO __LSLW8SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
	CLR  R30
	.ENDM

	.MACRO __PUTB1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __CLRW1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	CLR  R0
	ST   Z+,R0
	ST   Z,R0
	.ENDM

	.MACRO __CLRD1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	CLR  R0
	ST   Z+,R0
	ST   Z+,R0
	ST   Z+,R0
	ST   Z,R0
	.ENDM

	.MACRO __PUTB2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z,R26
	.ENDM

	.MACRO __PUTW2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z,R27
	.ENDM

	.MACRO __PUTD2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z+,R27
	ST   Z+,R24
	ST   Z,R25
	.ENDM

	.MACRO __PUTBSRX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z,R@1
	.ENDM

	.MACRO __PUTWSRX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	ST   Z+,R@0
	ST   Z,R@1
	.ENDM

	.MACRO __PUTB1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __MULBRR
	MULS R@0,R@1
	MOVW R30,R0
	.ENDM

	.MACRO __MULBRRU
	MUL  R@0,R@1
	MOVW R30,R0
	.ENDM

	.MACRO __MULBRR0
	MULS R@0,R@1
	.ENDM

	.MACRO __MULBRRU0
	MUL  R@0,R@1
	.ENDM

	.MACRO __MULBNWRU
	LDI  R26,@2
	MUL  R26,R@0
	MOVW R30,R0
	MUL  R26,R@1
	ADD  R31,R0
	.ENDM

	.CSEG
	.ORG 0

	.INCLUDE "ver_1.vec"
	.INCLUDE "ver_1.inc"

__RESET:
	CLI
	CLR  R30
	OUT  EECR,R30

;INTERRUPT VECTORS ARE PLACED
;AT THE START OF FLASH
	LDI  R31,1
	OUT  GICR,R31
	OUT  GICR,R30
	OUT  MCUCR,R30

;DISABLE WATCHDOG
	LDI  R31,0x18
	OUT  WDTCR,R31
	OUT  WDTCR,R30

;CLEAR R2-R14
	LDI  R24,13
	LDI  R26,2
	CLR  R27
__CLEAR_REG:
	ST   X+,R30
	DEC  R24
	BRNE __CLEAR_REG

;CLEAR SRAM
	LDI  R24,LOW(0x400)
	LDI  R25,HIGH(0x400)
	LDI  R26,0x60
__CLEAR_SRAM:
	ST   X+,R30
	SBIW R24,1
	BRNE __CLEAR_SRAM

;GLOBAL VARIABLES INITIALIZATION
	LDI  R30,LOW(__GLOBAL_INI_TBL*2)
	LDI  R31,HIGH(__GLOBAL_INI_TBL*2)
__GLOBAL_INI_NEXT:
	LPM  R24,Z+
	LPM  R25,Z+
	SBIW R24,0
	BREQ __GLOBAL_INI_END
	LPM  R26,Z+
	LPM  R27,Z+
	LPM  R0,Z+
	LPM  R1,Z+
	MOVW R22,R30
	MOVW R30,R0
__GLOBAL_INI_LOOP:
	LPM  R0,Z+
	ST   X+,R0
	SBIW R24,1
	BRNE __GLOBAL_INI_LOOP
	MOVW R30,R22
	RJMP __GLOBAL_INI_NEXT
__GLOBAL_INI_END:

;STACK POINTER INITIALIZATION
	LDI  R30,LOW(0x45F)
	OUT  SPL,R30
	LDI  R30,HIGH(0x45F)
	OUT  SPH,R30

;DATA STACK POINTER INITIALIZATION
	LDI  R28,LOW(0x160)
	LDI  R29,HIGH(0x160)

	RJMP _main

	.ESEG
	.ORG 0

	.DSEG
	.ORG 0x160
;       1 /* File include */
;       2 #include <mega8.h>
;       3 #include <delay.h>    
;       4 #include <stdio.h>    
;       5 #include "lcdku.c"
;       6 #ifndef __lcdku_C
;       7 #define __lcdku_C
;       8 
;       9 #define   rs              PORTC.0//PORTC.2
;      10 #define   enable          PORTC.1//PORTC.3
;      11 #define	  clock           PORTC.2//PORTC.4
;      12 #define   tx_LCD          PORTC.3 //PORTC.5
;      13 
;      14 
;      15 void dataout(unsigned char data_LCD, char kode)
;      16 {

	.CSEG
_dataout:
;      17   unsigned char i;
;      18   clock=0;
	ST   -Y,R16
;	data_LCD -> Y+2
;	kode -> Y+1
;	i -> R16
	CBI  0x15,2
;      19   for(i=0;i<8;i++)
	LDI  R16,LOW(0)
_0x4:
	CPI  R16,8
	BRLO PC+2
	RJMP _0x5
;      20   {
;      21     tx_LCD=(data_LCD & 0x1)==0x1 ? 1 : 0;
	LDD  R30,Y+2
	ANDI R30,LOW(0x1)
	CPI  R30,LOW(0x1)
	BREQ PC+2
	RJMP _0x6
	LDI  R30,LOW(1)
	RJMP _0x7
_0x6:
	LDI  R30,LOW(0)
_0x7:
_0x8:
	RCALL __BSTB1
	IN   R26,0x15
	BLD  R26,3
	OUT  0x15,R26
;      22     delay_us(4);
	__DELAY_USB 11
;      23     clock=1;
	SBI  0x15,2
;      24     delay_us(4);
	__DELAY_USB 11
;      25     clock=0;
	CBI  0x15,2
;      26     data_LCD=data_LCD>>1;
	LDD  R30,Y+2
	LSR  R30
	STD  Y+2,R30
;      27   }
_0x3:
	SUBI R16,-1
	RJMP _0x4
_0x5:
;      28   rs=kode;
	LDD  R30,Y+1
	RCALL __BSTB1
	IN   R26,0x15
	BLD  R26,0
	OUT  0x15,R26
;      29   delay_us(40);
	RCALL SUBOPT_0x0
;      30   enable=1;
	SBI  0x15,1
;      31   delay_us(40);
	RCALL SUBOPT_0x0
;      32   enable=0;
	CBI  0x15,1
;      33 }
	LDD  R16,Y+0
	ADIW R28,3
	RET
;      34 
;      35 void pos(unsigned char i,unsigned char n)
;      36 {
_pos:
;      37   if(i==1)
;	i -> Y+1
;	n -> Y+0
	LDD  R26,Y+1
	CPI  R26,LOW(0x1)
	BREQ PC+2
	RJMP _0x9
;      38   {
;      39     dataout (0x80+n-1,0);
	LD   R26,Y
	SUBI R26,-LOW(128)
	RCALL SUBOPT_0x1
;      40     delay_us(40);
;      41   }
;      42   else if (i==2)
	RJMP _0xA
_0x9:
	LDD  R26,Y+1
	CPI  R26,LOW(0x2)
	BREQ PC+2
	RJMP _0xB
;      43   {
;      44     dataout (0xc0+n-1,0);
	LD   R26,Y
	SUBI R26,-LOW(192)
	RCALL SUBOPT_0x1
;      45     delay_us(40);
;      46   }
;      47   else if (i==3)
	RJMP _0xC
_0xB:
	LDD  R26,Y+1
	CPI  R26,LOW(0x3)
	BREQ PC+2
	RJMP _0xD
;      48   {
;      49     dataout (0x90+n-1,0);
	LD   R26,Y
	SUBI R26,-LOW(144)
	RCALL SUBOPT_0x1
;      50     delay_us(40);
;      51   }
;      52   else if (i==4)
	RJMP _0xE
_0xD:
	LDD  R26,Y+1
	CPI  R26,LOW(0x4)
	BREQ PC+2
	RJMP _0xF
;      53   {
;      54     dataout (0xd0+n-1,0);
	LD   R26,Y
	SUBI R26,-LOW(208)
	RCALL SUBOPT_0x1
;      55     delay_us(40);
;      56   }
;      57   else;
	RJMP _0x10
_0xF:
_0x10:
_0xE:
_0xC:
_0xA:
;      58 }
	ADIW R28,2
	RET
;      59 
;      60 
;      61 void busek()
;      62 {
_busek:
;      63         dataout(0x01,0);
	RCALL SUBOPT_0x2
;      64         delay_ms(2);
	RCALL SUBOPT_0x3
	RCALL _delay_ms
;      65 }
	RET
;      66 
;      67 
;      68 void initlcd()
;      69 {
_initlcd:
;      70         delay_ms(1000);
	RCALL SUBOPT_0x4
;      71         dataout(0x30,0);
	RCALL SUBOPT_0x5
;      72         delay_ms(500);
	LDI  R30,LOW(500)
	LDI  R31,HIGH(500)
	RCALL SUBOPT_0x6
;      73         dataout(0x30,0);
	RCALL SUBOPT_0x5
;      74         delay_us(10000);
	__DELAY_USW 20000
;      75         dataout(0x30,0);
	RCALL SUBOPT_0x5
;      76         delay_us(4000);
	RCALL SUBOPT_0x7
;      77         dataout(0x38,0);
	LDI  R30,LOW(56)
	RCALL SUBOPT_0x8
;      78         delay_us(4000);
;      79         dataout(0x08,0);
	LDI  R30,LOW(8)
	RCALL SUBOPT_0x8
;      80         delay_us(4000);
;      81         dataout(0x01,0);
	RCALL SUBOPT_0x2
;      82         delay_us(4000);
	RCALL SUBOPT_0x7
;      83         dataout(0x0c,0);
	LDI  R30,LOW(12)
	RCALL SUBOPT_0x8
;      84         delay_us(4000);
;      85         dataout(0x06,0);
	LDI  R30,LOW(6)
	RCALL SUBOPT_0x8
;      86         delay_us(4000);
;      87 }
	RET
;      88 
;      89 
;      90 void cetak(int i,int n,flash char *text)
;      91 {
_cetak:
;      92         pos(i,n);
;	i -> Y+4
;	n -> Y+2
;	*text -> Y+0
	LDD  R30,Y+4
	ST   -Y,R30
	LDD  R30,Y+3
	RCALL SUBOPT_0x9
;      93         while(*text)
_0x11:
	RCALL SUBOPT_0xA
	LPM  R30,Z
	CPI  R30,0
	BRNE PC+2
	RJMP _0x13
;      94         {
;      95                 dataout(*text++,1);
	RCALL SUBOPT_0xB
	SBIW R30,1
	LPM  R30,Z
	RCALL SUBOPT_0xC
;      96                 delay_us(40);
	RCALL SUBOPT_0x0
;      97         }
	RJMP _0x11
_0x13:
;      98 }     
	ADIW R28,6
	RET
;      99 
;     100 #endif
;     101 #include "i2c.c"
;     102 
;     103 
;     104 #asm
;     105    .equ __i2c_port=0x18 ;PORTB
   .equ __i2c_port=0x18 ;PORTB
;     106    .equ __sda_bit=2
   .equ __sda_bit=2
;     107    .equ __scl_bit=7
   .equ __scl_bit=7
;     108 #endasm
;     109 
;     110 #include <i2c.h>
;     111 //#include <stdio.h>
;     112 
;     113 
;     114 #define EEPROM_ADDR    0xA0 
;     115 
;     116 
;     117 unsigned char read_EEPROM(unsigned char alamat)
;     118 {
;     119      unsigned char datax;
;     120      i2c_start();
;	alamat -> Y+1
;	datax -> R16
;     121      i2c_write(EEPROM_ADDR);
;     122      i2c_write(alamat);
;     123      i2c_stop();
;     124      i2c_start();
;     125      i2c_write(EEPROM_ADDR | 1);
;     126      datax = i2c_read(0);
;     127      i2c_stop();
;     128      return datax;
;     129 }
;     130 
;     131 void write_EEPROM(unsigned char alamat, unsigned char nilai)
;     132 {
;     133      i2c_start();
;	alamat -> Y+1
;	nilai -> Y+0
;     134      i2c_write(EEPROM_ADDR);
;     135      i2c_write(alamat);
;     136      i2c_write(nilai);
;     137      i2c_stop();
;     138      delay_ms(10);
;     139 }
;     140 
;     141 
;     142 
;     143 /* Pendefinisian */    
;     144 
;     145 //pin 11,12,13,5
;     146 
;     147 #define ldr1       PIND.5    //PORTC.3  
;     148 #define ldr2       PIND.6    //PORTC.3  
;     149 #define ldr3       PIND.7    //PORTC.3  
;     150 #define ldr4       PIND.3    //PORTC.3  
;     151 #define led       PORTB.7    //PORTC.3  
;     152 
;     153 /* Inisialisasi variabel global */   
;     154 unsigned int data_serial;
;     155 bit tanda_rx;
;     156 
;     157 unsigned char kon(unsigned char n)
;     158   {
_kon:
;     159    if (n <10) return(n+0x30);
;	n -> Y+0
	LD   R26,Y
	CPI  R26,LOW(0xA)
	BRLO PC+2
	RJMP _0x14
	LD   R30,Y
	SUBI R30,-LOW(48)
	ADIW R28,1
	RET
;     160    else return(n+0x37);
_0x14:
	LD   R30,Y
	SUBI R30,-LOW(55)
	ADIW R28,1
	RET
;     161 
;     162   }
_0x15:
	ADIW R28,1
	RET
;     163 /*Inisialisasi input output */
;     164 void init_port()
;     165 {
_init_port:
;     166         DDRD =0b00000011; 
	LDI  R30,LOW(3)
	OUT  0x11,R30
;     167         PORTD=0b11111101;
	LDI  R30,LOW(253)
	OUT  0x12,R30
;     168         DDRC =0b11001111;
	LDI  R30,LOW(207)
	OUT  0x14,R30
;     169         PORTC=0b11111111;
	LDI  R30,LOW(255)
	OUT  0x15,R30
;     170         DDRB =0b11111111;
	OUT  0x17,R30
;     171         PORTB=0b10111101;
	LDI  R30,LOW(189)
	OUT  0x18,R30
;     172 } 
	RET
;     173 void initser()
;     174 {
_initser:
;     175      UBRRL=51;//25;
	LDI  R30,LOW(51)
	OUT  0x9,R30
;     176      UBRRH=0;                     
	LDI  R30,LOW(0)
	OUT  0x20,R30
;     177      UCSRA=0x80;//aslinya 0
	LDI  R30,LOW(128)
	OUT  0xB,R30
;     178      UCSRB=0x98; //Txd,Rxd Enabled aslinya 18
	LDI  R30,LOW(152)
	OUT  0xA,R30
;     179      UCSRC=0x86; //8 bit data  
	LDI  R30,LOW(134)
	OUT  0x20,R30
;     180 }
	RET
;     181 
;     182 void kirimser(char TxData)
;     183 {
_kirimser:
;     184      UDR = TxData;   
;	TxData -> Y+0
	LD   R30,Y
	OUT  0xC,R30
;     185 //     time_us(100);  
;     186 } 
	ADIW R28,1
	RET
;     187 
;     188 void kirimtext(flash char *text)
;     189 {
;     190         
;     191         while(*text)
;	*text -> Y+0
;     192         {
;     193                 kirimser(*text++);
;     194         }
;     195 }     
;     196 
;     197 void inttim(char in)
;     198 {
;     199 if(in==0)TIMSK=TIMSK & 0xFE;
;	in -> Y+0
;     200 else TIMSK=TIMSK|0x1;
;     201 }             
;     202 
;     203 void init_timer0()
;     204 {       
;     205         /* Timer ini akan digunakan sebagai penghitung kecepatan */
;     206         /* Mode yang digunakan adalah normal */
;     207         TCCR0=0x02;//3;
;     208         TCNT0=-25;
;     209         inttim(1);
;     210 } 
;     211 
;     212 void init_ext_interrupt()
;     213 {
;     214         /* Set untuk interupt 0 rising edge */
;     215         MCUCR=0x01;//3;//2;
;     216         GICR=GICR|0x40; //0x40;
;     217 }
;     218 
;     219 /* Turn registers saving off */
;     220 #pragma savereg-
;     221 /* interrupt handler */
;     222 
;     223 void tampilhex(long int biner)
;     224 {
_tampilhex:
;     225          long int ascii;
;     226 //         ascii=biner; ascii=kon((ascii/0x100000)%0x10); dataout(ascii,1);
;     227 //         ascii=biner; ascii=kon((ascii/0x10000)%0x10); dataout(ascii,1);
;     228          ascii=biner; ascii=kon((ascii/0x1000)%0x10); dataout(ascii,1);
	RCALL SUBOPT_0xD
;	biner -> Y+4
;	ascii -> Y+0
	__GETD1N 0x1000
	RCALL SUBOPT_0xE
;     229          ascii=biner; ascii=kon((ascii/0x100)%0x10); dataout(ascii,1);
	RCALL SUBOPT_0xF
	__GETD1N 0x100
	RCALL SUBOPT_0xE
;     230          ascii=biner; ascii=kon((ascii/0x10)%0x10); dataout(ascii,1);
	RCALL SUBOPT_0xF
	RCALL SUBOPT_0x10
	RCALL SUBOPT_0xE
;     231          ascii=biner; ascii=kon(ascii%0x10); dataout(ascii,1);
	RCALL SUBOPT_0xF
	RCALL SUBOPT_0x10
	RCALL __MODD21
	ST   -Y,R30
	RCALL _kon
	RCALL SUBOPT_0x11
	RCALL SUBOPT_0x12
;     232 }#pragma savereg+  
	ADIW R28,8
	RET
;     233 #pragma savereg-
;     234 /* interrupt handler */
;     235 interrupt [12] void interuptrx(void) 
;     236 {               
_interuptrx:
;     237 //     while((UCSRA & 0x80) == 0x00);
;     238  //if(UDR=='a')tanda_rx=1;   
;     239  data_serial=(data_serial<<8)+UDR;
	MOV  R31,R4
	LDI  R30,LOW(0)
	MOVW R26,R30
	IN   R30,0xC
	LDI  R31,0
	ADD  R30,R26
	ADC  R31,R27
	MOVW R4,R30
;     240  tanda_rx=1;     
	SET
	BLD  R2,0
;     241  pos(2,11);tampilhex(data_serial);
	LDI  R30,LOW(2)
	ST   -Y,R30
	LDI  R30,LOW(11)
	RCALL SUBOPT_0x9
	MOVW R30,R4
	CLR  R22
	CLR  R23
	RCALL __PUTPARD1
	RCALL _tampilhex
;     242 //pos(2,1);tampilhex(data_serial);
;     243 //data_serial=UDR;    
;     244 } 
	RETI
;     245 #pragma savereg+
;     246 
;     247 void tampil1(long int biner)
;     248 {
_tampil1:
;     249          long int ascii;
;     250 
;     251 //         ascii=biner; ascii=(ascii/1000000000)|0x30; dataout(ascii,1);
;     252 //         ascii=biner; ascii=(ascii/100000000%10)|0x30; dataout(ascii,1);
;     253 //         ascii=biner; ascii=(ascii/10000000%10)|0x30; dataout(ascii,1);
;     254 //         ascii=biner; ascii=(ascii/1000000%10)|0x30; dataout(ascii,1);
;     255 //         ascii=biner; ascii=(ascii/100000%10)|0x30; dataout(ascii,1);
;     256 //         ascii=biner; ascii=(ascii/10000%10)|0x30; dataout(ascii,1);
;     257 //         ascii=biner; ascii=(ascii/1000%10)|0x30; dataout(ascii,1);
;     258 //         ascii=biner; ascii=((ascii/100)%10)|0x30; dataout(ascii,1);
;     259 //         ascii=biner; ascii=((ascii/10)%10)|0x30; dataout(ascii,1);
;     260          ascii=biner; ascii=(ascii%10)|0x30; dataout(ascii,1);
	RCALL SUBOPT_0xD
;	biner -> Y+4
;	ascii -> Y+0
	RCALL SUBOPT_0x13
;     261 }
	ADIW R28,8
	RET
;     262 void tampil2(long int biner)
;     263 {
;     264          long int ascii;
;     265 
;     266 //         ascii=biner; ascii=(ascii/1000000000)|0x30; dataout(ascii,1);
;     267 //         ascii=biner; ascii=(ascii/100000000%10)|0x30; dataout(ascii,1);
;     268 //         ascii=biner; ascii=(ascii/10000000%10)|0x30; dataout(ascii,1);
;     269 //         ascii=biner; ascii=(ascii/1000000%10)|0x30; dataout(ascii,1);
;     270 //         ascii=biner; ascii=(ascii/100000%10)|0x30; dataout(ascii,1);
;     271 //         ascii=biner; ascii=(ascii/10000%10)|0x30; dataout(ascii,1);
;     272 //         ascii=biner; ascii=(ascii/1000%10)|0x30; dataout(ascii,1);
;     273 //         ascii=biner; ascii=((ascii/100)%10)|0x30; dataout(ascii,1);
;     274          ascii=biner; ascii=((ascii/10)%10)|0x30; dataout(ascii,1);
;	biner -> Y+4
;	ascii -> Y+0
;     275          ascii=biner; ascii=(ascii%10)|0x30; dataout(ascii,1);
;     276 }
;     277 void tampil4(long int biner)
;     278 {
_tampil4:
;     279          long int ascii;
;     280 
;     281 //         ascii=biner; ascii=(ascii/1000000000)|0x30; dataout(ascii,1);
;     282 //         ascii=biner; ascii=(ascii/100000000%10)|0x30; dataout(ascii,1);
;     283 //         ascii=biner; ascii=(ascii/10000000%10)|0x30; dataout(ascii,1);
;     284 //         ascii=biner; ascii=(ascii/1000000%10)|0x30; dataout(ascii,1);
;     285 //         ascii=biner; ascii=(ascii/100000%10)|0x30; dataout(ascii,1);
;     286 //         ascii=biner; ascii=(ascii/10000%10)|0x30; dataout(ascii,1);
;     287          ascii=biner; ascii=(ascii/1000%10)|0x30; dataout(ascii,1);
	RCALL SUBOPT_0xD
;	biner -> Y+4
;	ascii -> Y+0
	__GETD1N 0x3E8
	RCALL SUBOPT_0x14
;     288          ascii=biner; ascii=((ascii/100)%10)|0x30; dataout(ascii,1);
	RCALL SUBOPT_0xF
	__GETD1N 0x64
	RCALL SUBOPT_0x14
;     289          ascii=biner; ascii=((ascii/10)%10)|0x30; dataout(ascii,1);
	RCALL SUBOPT_0xF
	__GETD1N 0xA
	RCALL SUBOPT_0x14
;     290          ascii=biner; ascii=(ascii%10)|0x30; dataout(ascii,1);
	RCALL SUBOPT_0xF
	RCALL SUBOPT_0x13
;     291 }
	ADIW R28,8
	RET
;     292 
;     293 void tampilhex8(long int biner)
;     294 {
;     295          long int ascii;
;     296  //        ascii=biner; ascii=kon((ascii/0x1000000000)%0x10); dataout(ascii,1);
;     297  //        ascii=biner; ascii=kon((ascii/0x100000000)%0x10); dataout(ascii,1);
;     298          ascii=biner; ascii=kon((ascii/0x10000000)%0x10); dataout(ascii,1);
;	biner -> Y+4
;	ascii -> Y+0
;     299          ascii=biner; ascii=kon((ascii/0x1000000)%0x10); dataout(ascii,1);
;     300          ascii=biner; ascii=kon((ascii/0x100000)%0x10); dataout(ascii,1);
;     301          ascii=biner; ascii=kon((ascii/0x10000)%0x10); dataout(ascii,1);
;     302          ascii=biner; ascii=kon((ascii/0x1000)%0x10); dataout(ascii,1);
;     303          ascii=biner; ascii=kon((ascii/0x100)%0x10); dataout(ascii,1);
;     304          ascii=biner; ascii=kon((ascii/0x10)%0x10); dataout(ascii,1);
;     305          ascii=biner; ascii=kon(ascii%0x10); dataout(ascii,1);
;     306 }
;     307 void tampilhex2(long int biner)
;     308 {
;     309          long int ascii;
;     310           ascii=biner; ascii=kon((ascii/0x10)%0x10); dataout(ascii,1);
;	biner -> Y+4
;	ascii -> Y+0
;     311          ascii=biner; ascii=kon(ascii%0x10); dataout(ascii,1);
;     312 }
;     313 
;     314 
;     315 interrupt [10] void timer0_overflow(void) 
;     316 {   
_timer0_overflow:
;     317         #asm
;     318         push r30
        push r30
;     319         push r31
        push r31
;     320         in   r30,SREG
        in   r30,SREG
;     321         push r30
        push r30
;     322         #endasm  
;     323         
;     324          #asm
;     325         pop r30
        pop r30
;     326         out SREG,r30
        out SREG,r30
;     327         pop r31
        pop r31
;     328         pop r30
        pop r30
;     329         #endasm*
;     330        
;     331 }      
	RETI
;     332 interrupt [2] void external_int0(void) 
;     333 {
_external_int0:
;     334         #asm
;     335         push r30
        push r30
;     336         push r31
        push r31
;     337         in   r30,SREG
        in   r30,SREG
;     338         push r30
        push r30
;     339         #endasm        
;     340           #asm
;     341         pop r30
        pop r30
;     342         out SREG,r30
        out SREG,r30
;     343         pop r31
        pop r31
;     344         pop r30
        pop r30
;     345         #endasm
;     346 }
	RETI
;     347 
;     348 /* Program Utama */
;     349 void main()
;     350 {
_main:
;     351 unsigned char data1,data2,data3,data4;   
;     352 unsigned int ms_1,detik_1;
;     353 
;     354 
;     355          /* Inisialisasi */
;     356         init_port();//inisialisasi port 
	SBIW R28,2
;	data1 -> R16
;	data2 -> R17
;	data3 -> R18
;	data4 -> R19
;	ms_1 -> R20,R21
;	detik_1 -> Y+0
	RCALL _init_port
;     357         initser();
	RCALL _initser
;     358         initlcd(); 
	RCALL _initlcd
;     359 
;     360         kirimser(0x2A);delay_ms(100);
	RCALL SUBOPT_0x15
;     361         kirimser(data1);delay_ms(100);
	RCALL SUBOPT_0x16
;     362         kirimser(data2);delay_ms(100);
	RCALL SUBOPT_0x17
;     363         kirimser(data3);delay_ms(100);
	RCALL SUBOPT_0x18
;     364         kirimser(data4);delay_ms(100);
	RCALL SUBOPT_0x19
;     365         kirimser(0x23);
	RCALL SUBOPT_0x1A
;     366         
;     367 cetak(1,1,"0123456789ABCDEF"); 
	RCALL SUBOPT_0x1B
	RCALL SUBOPT_0x1B
	__POINTW1FN _0,0
	RCALL SUBOPT_0x1C
;     368 cetak(2,1,"abcdefghijklmnop");
	RCALL SUBOPT_0x3
	RCALL SUBOPT_0x1B
	__POINTW1FN _0,17
	RCALL SUBOPT_0x1C
;     369 cetak(3,1,"qrstuvwxyz012345");
	LDI  R30,LOW(3)
	LDI  R31,HIGH(3)
	ST   -Y,R31
	ST   -Y,R30
	RCALL SUBOPT_0x1B
	__POINTW1FN _0,34
	RCALL SUBOPT_0x1C
;     370 cetak(4,1,"!@#$%^&*()_+=-{}?");
	LDI  R30,LOW(4)
	LDI  R31,HIGH(4)
	ST   -Y,R31
	ST   -Y,R30
	RCALL SUBOPT_0x1B
	__POINTW1FN _0,51
	RCALL SUBOPT_0x1C
;     371 delay_ms(1000);
	RCALL SUBOPT_0x4
;     372 
;     373         kirimser(0x2A);delay_ms(100);
	RCALL SUBOPT_0x15
;     374         kirimser(data1);delay_ms(100);
	RCALL SUBOPT_0x16
;     375         kirimser(data2);delay_ms(100);
	RCALL SUBOPT_0x17
;     376         kirimser(data3);delay_ms(100);
	RCALL SUBOPT_0x18
;     377         kirimser(data4);delay_ms(100);
	RCALL SUBOPT_0x19
;     378         kirimser(0x23);
	RCALL SUBOPT_0x1A
;     379 
;     380 busek();
	RCALL _busek
;     381 cetak(1,1,"H A C K  A T O N");          
	RCALL SUBOPT_0x1B
	RCALL SUBOPT_0x1B
	__POINTW1FN _0,69
	RCALL SUBOPT_0x1C
;     382 cetak(2,1,"   INDONESIA    ");          
	RCALL SUBOPT_0x3
	RCALL SUBOPT_0x1B
	__POINTW1FN _0,86
	RCALL SUBOPT_0x1C
;     383 //cetak(3,1,"    I D L E     ");          
;     384 //cetak(4,1," W E L C O M E  ");          
;     385 
;     386 
;     387 led=0;ms_1=0;detik_1=0;
	CBI  0x18,7
	__GETWRN 20,21,0
	LDI  R30,0
	STD  Y+0,R30
	STD  Y+0+1,R30
;     388 do
_0x1C:
;     389 {
;     390 pos(3,1);tampil1(ldr1);pos(3,3);tampil1(ldr2);pos(3,5);tampil1(ldr3);pos(3,7);tampil1(ldr4); 
	RCALL SUBOPT_0x1D
	LDI  R30,LOW(1)
	RCALL SUBOPT_0x9
	LDI  R30,0
	SBIC 0x10,5
	LDI  R30,1
	RCALL SUBOPT_0x1E
	LDI  R30,LOW(3)
	RCALL SUBOPT_0x9
	LDI  R30,0
	SBIC 0x10,6
	LDI  R30,1
	RCALL SUBOPT_0x1E
	LDI  R30,LOW(5)
	RCALL SUBOPT_0x9
	LDI  R30,0
	SBIC 0x10,7
	LDI  R30,1
	RCALL SUBOPT_0x1E
	LDI  R30,LOW(7)
	RCALL SUBOPT_0x9
	LDI  R30,0
	SBIC 0x10,3
	LDI  R30,1
	RCALL SUBOPT_0x11
	RCALL __PUTPARD1
	RCALL _tampil1
;     391  ms_1++;
	__ADDWRN 20,21,1
;     392 
;     393 if (ms_1>500)
	__CPWRN 20,21,501
	BRSH PC+2
	RJMP _0x1E
;     394         {ms_1=0;detik_1++;pos(4,1);tampil4(detik_1);
	__GETWRN 20,21,0
	RCALL SUBOPT_0xB
	LDI  R30,LOW(4)
	ST   -Y,R30
	LDI  R30,LOW(1)
	RCALL SUBOPT_0x9
	RCALL SUBOPT_0xA
	CLR  R22
	CLR  R23
	RCALL __PUTPARD1
	RCALL _tampil4
;     395                 if (led==0){led=1;}
	SBIC 0x18,7
	RJMP _0x1F
	SBI  0x18,7
;     396                 else {led=0;} 
	RJMP _0x20
_0x1F:
	CBI  0x18,7
_0x20:
;     397         }    
;     398 
;     399 //delay_ms(1000); 
;     400 
;     401 
;     402 
;     403 if (detik_1>=5) 
_0x1E:
	LD   R26,Y
	LDD  R27,Y+1
	SBIW R26,5
	BRSH PC+2
	RJMP _0x21
;     404         {
;     405         
;     406         data1=0x30+ldr1;data2=0x30+ldr2;data3=0x30+ldr3;data4=0x30+ldr4;
	LDI  R30,0
	SBIC 0x10,5
	LDI  R30,1
	SUBI R30,-LOW(48)
	MOV  R16,R30
	LDI  R30,0
	SBIC 0x10,6
	LDI  R30,1
	SUBI R30,-LOW(48)
	MOV  R17,R30
	LDI  R30,0
	SBIC 0x10,7
	LDI  R30,1
	SUBI R30,-LOW(48)
	MOV  R18,R30
	LDI  R30,0
	SBIC 0x10,3
	LDI  R30,1
	SUBI R30,-LOW(48)
	MOV  R19,R30
;     407         kirimser(0x2A);delay_ms(100);
	RCALL SUBOPT_0x15
;     408         kirimser(data1);delay_ms(100);
	RCALL SUBOPT_0x16
;     409         kirimser(data2);delay_ms(100);
	RCALL SUBOPT_0x17
;     410         kirimser(data3);delay_ms(100);
	RCALL SUBOPT_0x18
;     411         kirimser(data4);delay_ms(100);
	RCALL SUBOPT_0x19
;     412         kirimser(0x23);detik_1=0;}
	RCALL SUBOPT_0x1A
	LDI  R30,0
	STD  Y+0,R30
	STD  Y+0+1,R30
;     413 }while(1);                       
_0x21:
_0x1B:
	RJMP _0x1C
_0x1D:
;     414 }
	ADIW R28,2
_0x22:
	RJMP _0x22

_getchar:
     sbis usr,rxc
     rjmp _getchar
     in   r30,udr
	RET
_putchar:
     sbis usr,udre
     rjmp _putchar
     ld   r30,y
     out  udr,r30
	ADIW R28,1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 7 TIMES, CODE SIZE REDUCTION:10 WORDS
SUBOPT_0x0:
	__DELAY_USB 107
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:13 WORDS
SUBOPT_0x1:
	SUBI R26,LOW(1)
	ST   -Y,R26
	LDI  R30,LOW(0)
	ST   -Y,R30
	RCALL _dataout
	RJMP SUBOPT_0x0

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x2:
	LDI  R30,LOW(1)
	ST   -Y,R30
	LDI  R30,LOW(0)
	ST   -Y,R30
	RJMP _dataout

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0x3:
	LDI  R30,LOW(2)
	LDI  R31,HIGH(2)
	ST   -Y,R31
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x4:
	LDI  R30,LOW(1000)
	LDI  R31,HIGH(1000)
	ST   -Y,R31
	ST   -Y,R30
	RJMP _delay_ms

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:6 WORDS
SUBOPT_0x5:
	LDI  R30,LOW(48)
	ST   -Y,R30
	LDI  R30,LOW(0)
	ST   -Y,R30
	RJMP _dataout

;OPTIMIZER ADDED SUBROUTINE, CALLED 16 TIMES, CODE SIZE REDUCTION:28 WORDS
SUBOPT_0x6:
	ST   -Y,R31
	ST   -Y,R30
	RJMP _delay_ms

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:13 WORDS
SUBOPT_0x7:
	__DELAY_USW 8000
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:10 WORDS
SUBOPT_0x8:
	ST   -Y,R30
	LDI  R30,LOW(0)
	ST   -Y,R30
	RCALL _dataout
	RJMP SUBOPT_0x7

;OPTIMIZER ADDED SUBROUTINE, CALLED 7 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0x9:
	ST   -Y,R30
	RJMP _pos

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0xA:
	LD   R30,Y
	LDD  R31,Y+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0xB:
	RCALL SUBOPT_0xA
	ADIW R30,1
	ST   Y,R30
	STD  Y+1,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 10 TIMES, CODE SIZE REDUCTION:25 WORDS
SUBOPT_0xC:
	ST   -Y,R30
	LDI  R30,LOW(1)
	ST   -Y,R30
	RJMP _dataout

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:22 WORDS
SUBOPT_0xD:
	SBIW R28,4
	__GETD1S 4
	__PUTD1S 0
	__GETD2S 0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:34 WORDS
SUBOPT_0xE:
	RCALL __DIVD21
	MOVW R26,R30
	MOVW R24,R22
	__GETD1N 0x10
	RCALL __MODD21
	ST   -Y,R30
	RCALL _kon
	CLR  R31
	CLR  R22
	CLR  R23
	__PUTD1S 0
	LD   R30,Y
	RJMP SUBOPT_0xC

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:53 WORDS
SUBOPT_0xF:
	__GETD1S 4
	__PUTD1S 0
	__GETD2S 0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x10:
	__GETD1N 0x10
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:6 WORDS
SUBOPT_0x11:
	CLR  R31
	CLR  R22
	CLR  R23
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:23 WORDS
SUBOPT_0x12:
	__PUTD1S 0
	LD   R30,Y
	RJMP SUBOPT_0xC

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:22 WORDS
SUBOPT_0x13:
	__GETD1N 0xA
	RCALL __MODD21
	ORI  R30,LOW(0x30)
	RJMP SUBOPT_0x12

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0x14:
	RCALL __DIVD21
	MOVW R26,R30
	MOVW R24,R22
	RJMP SUBOPT_0x13

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:8 WORDS
SUBOPT_0x15:
	LDI  R30,LOW(42)
	ST   -Y,R30
	RCALL _kirimser
	LDI  R30,LOW(100)
	LDI  R31,HIGH(100)
	RJMP SUBOPT_0x6

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:6 WORDS
SUBOPT_0x16:
	ST   -Y,R16
	RCALL _kirimser
	LDI  R30,LOW(100)
	LDI  R31,HIGH(100)
	RJMP SUBOPT_0x6

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:6 WORDS
SUBOPT_0x17:
	ST   -Y,R17
	RCALL _kirimser
	LDI  R30,LOW(100)
	LDI  R31,HIGH(100)
	RJMP SUBOPT_0x6

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:6 WORDS
SUBOPT_0x18:
	ST   -Y,R18
	RCALL _kirimser
	LDI  R30,LOW(100)
	LDI  R31,HIGH(100)
	RJMP SUBOPT_0x6

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:6 WORDS
SUBOPT_0x19:
	ST   -Y,R19
	RCALL _kirimser
	LDI  R30,LOW(100)
	LDI  R31,HIGH(100)
	RJMP SUBOPT_0x6

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x1A:
	LDI  R30,LOW(35)
	ST   -Y,R30
	RJMP _kirimser

;OPTIMIZER ADDED SUBROUTINE, CALLED 8 TIMES, CODE SIZE REDUCTION:19 WORDS
SUBOPT_0x1B:
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	ST   -Y,R31
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:8 WORDS
SUBOPT_0x1C:
	ST   -Y,R31
	ST   -Y,R30
	RJMP _cetak

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x1D:
	LDI  R30,LOW(3)
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0x1E:
	RCALL SUBOPT_0x11
	RCALL __PUTPARD1
	RCALL _tampil1
	RJMP SUBOPT_0x1D

	.equ __i2c_dir=__i2c_port-1
	.equ __i2c_pin=__i2c_port-2
_i2c_init:
	cbi  __i2c_port,__scl_bit
	cbi  __i2c_port,__sda_bit
	sbi  __i2c_dir,__scl_bit
	cbi  __i2c_dir,__sda_bit
	rjmp __i2c_delay2
_i2c_start:
	cbi  __i2c_dir,__sda_bit
	cbi  __i2c_dir,__scl_bit
	clr  r30
	nop
	sbis __i2c_pin,__sda_bit
	ret
	sbis __i2c_pin,__scl_bit
	ret
	rcall __i2c_delay1
	sbi  __i2c_dir,__sda_bit
	rcall __i2c_delay1
	sbi  __i2c_dir,__scl_bit
	ldi  r30,1
__i2c_delay1:
	ldi  r22,13
	rjmp __i2c_delay2l
_i2c_stop:
	sbi  __i2c_dir,__sda_bit
	sbi  __i2c_dir,__scl_bit
	rcall __i2c_delay2
	cbi  __i2c_dir,__scl_bit
	rcall __i2c_delay1
	cbi  __i2c_dir,__sda_bit
__i2c_delay2:
	ldi  r22,27
__i2c_delay2l:
	dec  r22
	brne __i2c_delay2l
	ret
_i2c_read:
	ldi  r23,8
__i2c_read0:
	cbi  __i2c_dir,__scl_bit
	rcall __i2c_delay1
__i2c_read3:
	sbis __i2c_pin,__scl_bit
	rjmp __i2c_read3
	rcall __i2c_delay1
	clc
	sbic __i2c_pin,__sda_bit
	sec
	sbi  __i2c_dir,__scl_bit
	rcall __i2c_delay2
	rol  r30
	dec  r23
	brne __i2c_read0
	ld   r23,y+
	tst  r23
	brne __i2c_read1
	cbi  __i2c_dir,__sda_bit
	rjmp __i2c_read2
__i2c_read1:
	sbi  __i2c_dir,__sda_bit
__i2c_read2:
	rcall __i2c_delay1
	cbi  __i2c_dir,__scl_bit
	rcall __i2c_delay2
	sbi  __i2c_dir,__scl_bit
	rcall __i2c_delay1
	cbi  __i2c_dir,__sda_bit
	rjmp __i2c_delay1

_i2c_write:
	ld   r30,y+
	ldi  r23,8
__i2c_write0:
	lsl  r30
	brcc __i2c_write1
	cbi  __i2c_dir,__sda_bit
	rjmp __i2c_write2
__i2c_write1:
	sbi  __i2c_dir,__sda_bit
__i2c_write2:
	rcall __i2c_delay2
	cbi  __i2c_dir,__scl_bit
	rcall __i2c_delay1
__i2c_write3:
	sbis __i2c_pin,__scl_bit
	rjmp __i2c_write3
	rcall __i2c_delay1
	sbi  __i2c_dir,__scl_bit
	dec  r23
	brne __i2c_write0
	cbi  __i2c_dir,__sda_bit
	rcall __i2c_delay1
	cbi  __i2c_dir,__scl_bit
	rcall __i2c_delay2
	ldi  r30,1
	sbic __i2c_pin,__sda_bit
	clr  r30
	sbi  __i2c_dir,__scl_bit
	ret

_delay_ms:
	ld   r30,y+
	ld   r31,y+
	adiw r30,0
	breq __delay_ms1
__delay_ms0:
	__DELAY_USW 0x7D0
	wdr
	sbiw r30,1
	brne __delay_ms0
__delay_ms1:
	ret

__ANEGD1:
	COM  R30
	COM  R31
	COM  R22
	COM  R23
	SUBI R30,-1
	SBCI R31,-1
	SBCI R22,-1
	SBCI R23,-1
	RET

__DIVD21U:
	PUSH R19
	PUSH R20
	PUSH R21
	CLR  R0
	CLR  R1
	CLR  R19
	CLR  R20
	LDI  R21,32
__DIVD21U1:
	LSL  R26
	ROL  R27
	ROL  R24
	ROL  R25
	ROL  R0
	ROL  R1
	ROL  R19
	ROL  R20
	SUB  R0,R30
	SBC  R1,R31
	SBC  R19,R22
	SBC  R20,R23
	BRCC __DIVD21U2
	ADD  R0,R30
	ADC  R1,R31
	ADC  R19,R22
	ADC  R20,R23
	RJMP __DIVD21U3
__DIVD21U2:
	SBR  R26,1
__DIVD21U3:
	DEC  R21
	BRNE __DIVD21U1
	MOVW R30,R26
	MOVW R22,R24
	MOVW R26,R0
	MOV  R24,R19
	MOV  R25,R20
	POP  R21
	POP  R20
	POP  R19
	RET

__DIVD21:
	RCALL __CHKSIGND
	RCALL __DIVD21U
	BRTC __DIVD211
	RCALL __ANEGD1
__DIVD211:
	RET

__MODD21:
	CLT
	SBRS R25,7
	RJMP __MODD211
	COM  R26
	COM  R27
	COM  R24
	COM  R25
	SUBI R26,-1
	SBCI R27,-1
	SBCI R24,-1
	SBCI R25,-1
	SET
__MODD211:
	SBRC R23,7
	RCALL __ANEGD1
	RCALL __DIVD21U
	MOVW R30,R26
	MOVW R22,R24
	BRTC __MODD212
	RCALL __ANEGD1
__MODD212:
	RET

__CHKSIGND:
	CLT
	SBRS R23,7
	RJMP __CHKSD1
	RCALL __ANEGD1
	SET
__CHKSD1:
	SBRS R25,7
	RJMP __CHKSD2
	CLR  R0
	COM  R26
	COM  R27
	COM  R24
	COM  R25
	ADIW R26,1
	ADC  R24,R0
	ADC  R25,R0
	BLD  R0,0
	INC  R0
	BST  R0,0
__CHKSD2:
	RET

__PUTPARD1:
	ST   -Y,R23
	ST   -Y,R22
	ST   -Y,R31
	ST   -Y,R30
	RET

__BSTB1:
	CLT
	CLR  R0
	CPSE R30,R0
	SET
	RET

;END OF CODE MARKER
__END_OF_CODE:
