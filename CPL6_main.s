;This program will prompts for a string
;and decide whether the string is a palindrome or not

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
	ALIGN			; highly recommended to start and end any area with ALIGN

main


	PUSH	{LR}		; save return address of caller in init.s

	LDR R0, =Prompt1
	BL PutStr
	LDR R0, =STR1        ;Space +1
	MOV R1,#MaxSTR1      ;Space
	BL GetStr
	
	LDR R0, =STR1       ;Putting string from user into R2
	
LOOP	LDRB R2,[R0],#1    ;8 bits 1 byte
		CMP R2,#0
		BNE LOOP
	LDRB R2,[R0],#-2
	LDR R3,=STR1
	
NEXT	CMP R0,R3     ;R2 < R3 
		BLT PRINT
	
		LDRB R4,[R2],#-1
		LDRB R6,[R4],#1
		CMP R4,R6
		BNE NO
		BAL NEXT
		
PRINT 	LDR R0, =Msg1
		BL PutStr
		BAL EXIT
	
NO LDR R0,=Msg2
	BL PutStr
	
EXIT	POP		{PC}		; return from main (our last executable instruction)
	
	ALIGN
	
Prompt1 DCB "Please enter your string: ",0
Msg1  DCB "Not a Palindrome", 0
Msg2 DCB "It is a palindrome",0
MaxSTR1 EQU 1000      	;Maximum number of characters
STR3 DCB "1234",0 ;LDRB
STR4 DCD 1,2,3,4
STR DCB 0x3,'A','B','C'
	
	AREA    MyData, DATA, READWRITE
		
	ALIGN
		
STR1 SPACE MaxSTR1 + 1   ;Maximum number of characters + 1 

;-------------------- END OF MODIFIABLE CODE ----------------------

	ALIGN

	END			; end of source program in this file
