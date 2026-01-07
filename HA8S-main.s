; File: HA8-main.s

; This file needs to be in a Keil version 5 project, together with file init.s

; This is an initial demo program for HA4, which you need to change to complete HA4

; All future CS 238 Home Assignments, will have similar but different files,
; like HA5-main.s, HA6-main.s, etc.

; Executable code in HAx-main.s files should start at label main

	EXPORT	main		; this line is needed to interface with init.s
	IMPORT	GetCh		; Input one ASCII character from the UART #1 window (from keyboard)
	IMPORT	PutCh		; Output one ASCII character to the UART #1 window
	IMPORT	PutCRLF		; Output CR and LF to the UART #1 window
        IMPORT	UDivMod		; Perform unsigned division to obtain quotient and remainder
	IMPORT	GetDec		; Input a signed number from the UART #1 window
	IMPORT	PutDec		; Output a signed number to the UART #1 window
	IMPORT	GetStr		; Input a CR-terminated ASCII string from the UART #1 window
	IMPORT	PutStr		; Output null-terminated ASCII string to the UART #1 window

	AREA    MyCode, CODE, READONLY
	ALIGN			

main

	PUSH	{LR}		; save return address of caller in init.s

	LDR R0,=Msg1
	BL PutStr
	LDR R0,=SPACE1
	MOV R1,#MAXSPACE
	BL GetStr
	
	LDR R5,=SPACE2      ;Loads Space into R5 (making room to put the new string into R5)
	LDR R1,=SPACE1      ;Loads in the inputed string to R1
	
LOOP LDRB R0,[R1],#1    ;Loads 1 letter into R0
	CMP R0,#0           ;Makes sure the inputed string is not empty
	BEQ ANSWER          ;If it is empty it will run the final message
	CMP R0,#'a'         ;Compares if the letter is char a
	BLT INCORRECT       ;If the letter is less than a than it is invalid
	CMP R0,#'z'         ;Compares if the letter is bigger than char z
	BGT INCORRECT       ;If it is bigger than it is invalid
	
	SUB R0,R0,#'a'-'A'  ;Changes the letter to its Capital counterpart
	STRB R0,[R5],#1     ;Loads the new letter one by one onto R5
	BAL LOOP
	
ANSWER STRB R0,[R5]            
	   LDR R0,=Msg3      ;Loads the final message into R0
	   BL PutStr           
	   LDR R0,=SPACE2    ;Loads the new string into R0
	   BL PutStr
	j   BAL EXIT
	
INCORRECT LDR R0,=Msg2  ;Displays if the inputed string is invalid
	BL PutStr
	BAL Msg1
	
	
EXIT	POP	{PC}		; return from main (our last executable instruction
	ALIGN


Msg1 DCB "Please enter your string: ",0
Msg2 DCB "Invalid Entry!",0
Msg3 DCB "Your capitlized string: ",0
MAXSPACE EQU 1000
	


	AREA    MyData, DATA, READWRITE
		
	ALIGN
SPACE1 SPACE MAXSPACE+1
SPACE2 SPACE MAXSPACE+1

	ALIGN

	END			; end of source program in this file
