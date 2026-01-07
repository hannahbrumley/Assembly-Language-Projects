; File: This program will find the max of a list

 
; This file needs to be in a Keil version 5 project, together with file init.s

; This program file is for CS 238 Home Assignment HA3
; Later home assignments will have similar files, like HA4-main.s, HA5-main.s, etc.

	EXPORT	main		; this line is needed to interface with init.s
; Usable utility functions defined in file init.s
; Importing any label from another source file is necessary
; in order to use that label in this source file

	IMPORT	GetCh		; Input one ASCII character from the UART #1 window (from keyboard)
	IMPORT	PutCh		; Output one ASCII character to the UART #1 window
	IMPORT	PutCRLF		; Output CR and LF to the UART #1 window
    	IMPORT	UDivMod		; Perform unsigned division to obtain quotient and remainder
	IMPORT	GetDec		; Input a signed number from the UART #1 window
	IMPORT	PutDec		; Output a signed number to the UART #1 window
	IMPORT	GetStr		; Input a CR-terminated ASCII string from the UART #1 window
	IMPORT	PutStr		; Output null-terminated ASCII string to the UART #1 window

	AREA    MyCode, CODE, READONLY

	ALIGN			; highly recommended to start and end any area with ALIGN

; Start of executable code is at following label: main

main

		PUSH		{LR}		; save return address of caller in init.s
		BL		MAXCALC
		MOV		R5,R0		; R5 = Max of the list
		LDR		R0,=Msg1
		BL		PutStr
		MOV		R0,R5
		BL		PutDec	
		
		BL MINCALC
		MOV R5,R0
		LDR R0,=Msg3
		BL PutStr
		MOV R0,R5
		BL PutDec
		
		POP		{PC}				; return from main (our last executable instruction)
	
MAXCALC	PUSH		{LR}
		LDR		R0,=LENGTH
		LDR		R0,[R0]		;R0 = LENGTH
		CMP		R0,#0
		BEQ		EMPTY
		LDR		R1,=MAX
		LDR		R1,[R1]		; R1= MAX
		LDR		R2,=Sample
LOOP	LDR		R3,[R2],#4	;R3 = 1st element of list = 5
		CMP		R1,R3		;Comparing max with 1st element
		BGE		NEXT
		MOV		R1,R3	
		
		
NEXT	SUBS		R0,R0,#1
		BNE		LOOP
		LDR		R4,=FMAX
		STR		R1,[R4]
		MOV		R0,R1
		BAL		EXIT
		
		
		
MINCALC PUSH {LR}
		LDR		R0,=LENGTH
		LDR		R0,[R0]		;R0 = LENGTH
		CMP		R0,#0
		BEQ		EMPTY
		LDR		R1,=MIN
		LDR		R1,[R1]		; R1= MAX
		LDR		R2,=Sample
CIRCLE	LDR		R3,[R2],#4	;R3 = 1st element of list = 5
		CMP		R1,R3		;Comparing max with 1st element
		BLE		SECOND
		MOV		R1,R3

SECOND	SUBS	R0,R0,#1
		BNE		CIRCLE
		LDR		R7,=FMIN
		STR		R1,[R7]
		MOV		R0,R1
		BAL		EXIT
		

		
EMPTY		LDR		R0,=Msg2
		BL		PutStr
EXIT		POP		{PC}

		ALIGN


; The following data items are in the CODE area,
; so they are all READONLY (i.e. cannot be modified at run-time),
; but they can be initialized at assembly-time to any value

LENGTH	DCD	7
MAX	DCD	5
MIN DCD 5
Sample	DCD	5,12,23,300,76,101,98
Msg1	DCB	"Max of the list is: ",0
Msg2	DCB	"The list is empty!",0
Msg3    DCB  "\nMin of the list is: ",0

	ALIGN


; The following data items are in the DATA area,
; so they are all READWRITE (i.e. can be modified at run-time),
; but are automatically initialized at assembly-time to zeroes 
		
	AREA	Mydata, DATA, READWRITE


	ALIGN
		
FMAX	SPACE	4
FMIN    SPACE 4
		


	ALIGN
		

	END		; end of source program in this file