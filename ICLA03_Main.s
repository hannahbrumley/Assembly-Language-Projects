; File: ICLA3-main.s
; This program will prompt the user for and integer and display the 
; factorial of that interger back to the user.The program will also save the factorial value in memory.



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

;-------------------- START OF MODIFIABLE CODE ----------------------

		PUSH		{LR}		; save return address of caller in init.s
	
		BL FACTOR
		
		LDR R0,=Msg2
		BL PutStr
		MOV R0, R2
		BL PutDec
		LDR R4,=SPACE
		STR R2,[R4]
		
		POP		{PC}		; return from main (our last executable instruction)
	; Some commonly used ASCII codes

FACTOR PUSH {LR}
		LDR R0,=Msg1
		BL PutStr
		BL	GetDec		; Gets the input from the user
		MOV R1, R0
		
		CMP R1, #0
		BEQ ZERO
		
		MOV R2,#1 		;Sets the value of R3 to 1
		
LOOP  MUL R2,R1,R2
		SUBS R1,#1
		BNE LOOP      ;Checks if Z bit it set
		
		BAL EXIT
		
		
		
ZERO MOV R2,#1


EXIT		POP{PC}

	ALIGN	
	
; The following data items are in the CODE area,
; so they are all READONLY (i.e. cannot be modified at run-time),
; but they can be initialized at assembly-time to any value

Msg1 DCB "Please enter an integer: ",0
Msg2 DCB "Factorial of your integer: ",0
	

	

	ALIGN
		
	AREA    MyData, DATA, READWRITE
		
	ALIGN	
	
		


SPACE SPACE 4


;-------------------- END OF MODIFIABLE CODE ----------------------

	ALIGN

	END			; end of source program in this file
