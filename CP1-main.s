 ; This file needs to be in a Keil version 5 project, together with file init.s

; This program file is for CS 238 Class Program


	EXPORT	main		; this line is needed to interface with init.s

	AREA    MyCode, CODE, READONLY

	ALIGN			; highly recommended to start and end any area with ALIGN

; Start of executable code is at following label: main

main

	PUSH	{LR}		; save return address of caller in init.s


	PUSH	{LR}		; save return address of caller in init.s
	LDR R0,=DATA1
	LDR R1,[R0]          
	LDR R2,[R0,#4]
	
	
	LDR R0,=DATA2
	LDR R3,[R0],#4
	LDR R4,[R0]
	
	
	ADDS R5,R2,R4
	ADC  R6,R1,R3
	
	LDR R0,=RESULT
	STR R5,[R0],#4
	STR R6,[R0]

	POP	{PC}		; return from main (our last executable instruction)
	
	ALIGN

; Data for this program (Readonly):

DATA1 DCD 0x12A2E640,0xF2100123
DATA2 DCD 0x001019BF,0x40023F51
	
	
	ALIGN
		
	AREA    MyData, DATA, READWRITE
		
	ALIGN

; Data for this program (ReadWrite):


RESULT SPACE 16

;-------------------- END OF MODIFIABLE CODE ----------------------

	ALIGN

	END			; end of source program in this file

	