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
		
		
		
		LDR R0,=MSG1
		LDR R3,=MSG3
		BL PutStr
	    LDR R1,=LIST1
		
		MOV R5,#0
		
LOOP	LDR R2,[R1],#4
		MOV R0,R2
		BL PutDec
		MOV R0,R3
		BL PutStr
		ADD R5,#1
		CMP R2, #0
		BEQ EXIT
		BAL LOOP
	


EXIT
	LDR R2,[R1], #-4
	LDR R0,=MSG2
	BL PutStr
LOOP2 LDR R2,[R1], #-4
	CMP R5,#0
	BEQ DONE
	MOV R0,R2
	BL PutDec
	MOV R0,R3
	BL PutStr
	SUB R5,#1
	BAL LOOP2


DONE POP{PC}

	ALIGN	
	
; The following data items are in the CODE area,
; so they are all READONLY (i.e. cannot be modified at run-time),
; but they can be initialized at assembly-time to any value


MSG1 DCB "Your orginal List is: ",0
MSG2 DCB "\nYour reversed list is: ",0
MSG3 DCB " ",0
LIST1 DCD 0x1,0x2,0x3,0x4,0x5,0x6,0x7,0x8,0x0


	ALIGN
		
	AREA    MyData, DATA, READWRITE
		
	ALIGN	
	


;-------------------- END OF MODIFIABLE CODE ----------------------

	ALIGN

	END			; end of source program in this file
