; File: ICLA02-main.s
; Student's Name: 

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

; Start of executable code is at following label: main

; F= (4x^2 - 6y +5z)/7
;Display prompts and get the inputs from the user

main

;-------------------- START OF MODIFIABLE CODE ----------------------

	PUSH	{LR}	; save return address of caller in init.s
	
	LDR	R0, =Msg1	; Loads the first message into R0
	BL PutStr	    ; Outputs the message to the window
	BL	GetDec		; Gets the input from the user
	MOV R1, R0 
	
	LDR	R0, =Msg2	; Loads the first message into R0
	BL PutStr	    ; Outputs the message to the window
	BL	GetDec		; Gets the input from the user
	MOV R2, R0 
	
	LDR	R0, =Msg3	; Loads the first message into R0
	BL PutStr	    ; Outputs the message to the window
	BL	GetDec		; Gets the input from the user
	MOV R3, R0 
	
	
	MUL R1, R1, R1   ;Multiply R1 by R1 and keep it in R0
	MOV R4, #4       ;Put 4 in R4
	MUL R1, R1, R4   ; Multiply R1 by R4 and keep it in R4
	MOV R6, #6       ;Put 6 in R6
	MUL R2, R2, R6   ;Multiply R2 by R6 and keep it in R2
	MOV R7, #5       ;Put 5 in R7
	MUL R3, R3, R7   ;Multiply R3 by R7 and keep it in R3
	SUB R1, R1,R2    ;Subtract R1 by R2 and keep it in R1
	ADD R1,R1,R3     ;Add R1 to R3 and ke
	MOV R0, R1       ;Move R1 to R0
	
	MOV R1, #7       ;Put #7 in R1
	BL UDivMod       ;Divide R0 by R1
	
	LDR R0, =Msg4   ;Loads the fourth message into R0
	BL PutStr       ;Outputs R0 to the screen
	MOV R0, R1    ;Moves the value of R1 to R0
	BL PutDec 
	
	POP	{PC}		; return from main (our last executable instruction)
	

	ALIGN	
	
; The following data items are in the CODE area,
; so they are all READONLY (i.e. cannot be modified at run-time),
; but they can be initialized at assembly-time to any value


Msg1 = "Please enter X = ",0
Msg2 = "Please enter Y = ",0
Msg3 = "Please enter Z = ",0
Msg4 = "(4x^2 -6Y + 5Z)/7 = ",0


	ALIGN
		
	AREA    MyData, DATA, READWRITE
		
	ALIGN	
	


;-------------------- END OF MODIFIABLE CODE ----------------------

	ALIGN

	END			; end of source program in this file
