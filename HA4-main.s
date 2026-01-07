; File: HA4-main.s
; Student's Name:

; This file needs to be in a Keil version 5 project, together with file init.s

; This is an initial demo program for HA4, which you need to change to complete HA4

; All future CS 238 Home Assignments, will have similar but different files,
; like HA5-main.s, HA6-main.s, etc.

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

; Start of executable code is at following label: main

main

;-------------------- START OF MODIFIABLE CODE ----------------------

	PUSH	{LR}		; save return address of caller in init.s
	
	
	
	LDR	R0, =Msg1	; Loads the first message into R0
	BL PutStr	    ; Outputs the message to the window
	BL	GetDec		; Gets the input from the user
	MOV R1, R0      ; Moves the input from R0 to R1
	
	MUL R0, R1, R1  ; Multiplies the value in R1 by the value in R1 and stores the value in R1 
	ADD R0, R1      ; Adds the value for R0 by the value in R1
	MOV R1, #2      ; Puts the value of 2 in R1
	BL UDivMod      ;R0 is divided by R1
	;MOV R0,R1       ; Moves the value of R1 to R0
	
	LDR R0, =Msg2   ;Loads the second message into R0
	BL PutStr       ;Outputs R0 to the screen
	MOV R0, R1      ;Moves the value of R1 to R0
	BL PutDec       ;Outputs the number in R0 to the screen


		
	
	POP	{PC}		; return from main (our last executable instruction)
	
; Some commonly used ASCII codes


; The following data items are in the CODE area,
; so they are all READONLY (i.e. cannot be modified at run-time),
; but they can be initialized at assembly-time to any value


Msg1	DCB	"Please enter the number for terms in a series: ", 0
Msg2	DCB	"The sum of the series is: ", 0


	ALIGN
		
; The following data items are in the DATA area,
; so they are all READWRITE (i.e. can be modified at run-time),
; but are automatically initialized at assembly-time to zeroes 

	AREA    MyData, DATA, READWRITE
		
	ALIGN


;-------------------- END OF MODIFIABLE CODE ----------------------

	ALIGN

	END			; end of source program in this file
