; File: Class_Program2-main.s
; x= a^2 + 5b - c
;This program will display prompts and get the inputs from the user and calculate the value of x.

; This file needs to be in a Keil version 5 project, together with file init.s

; Executable code in HAx-main.s files should start at label main

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

main

;-------------------- START OF MODIFIABLE CODE ----------------------

	PUSH		{LR}		; save return address of caller in init.s
	
	LDR R0, =Msg1
	BL PutStr
	BL GetDec
	MOV R1,R0
	
	LDR R0, =Msg2
	BL PutStr
	BL GetDec
	MOV R2, R0
	
	LDR R0, =Msg3
	BL PutStr
	BL GetDec
	MOV R3, R0
	
	
	MUL R1, R1
	MOV R4, #5
	MUL R2, R4
	ADD R1, R2
	SUB R1, R3
	
	
	LDR R0, =Msg4
	BL PutStr
	MOV R0, R1
	BL PutDec
	
	
	BL PutDec
	MOV R1, #11
	BL UDivMod
	MOV R5, R0
	LDR R0, = Msg6
	BL PutStr
	
	POP	{PC}		; return from main (our last executable instruction)

	ALIGN	
; Data items (READONLY)

Msg1 DCB "Please enter a: ",0
Msg2 DCB "Please enter b: ",0
Msg3 DCB "Please enter c: ",0
Msg4 DCB "a^2+5b-c: ",0

	ALIGN
		
	AREA    MyData, DATA, READWRITE
		
	ALIGN


;-------------------- END OF MODIFIABLE CODE ----------------------

	ALIGN

	END			; end of source program in this file
