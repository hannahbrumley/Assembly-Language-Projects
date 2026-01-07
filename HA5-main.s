; File: HA5-main.s
; Student Name:

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


	PUSH	{LR}
	LDR R0,=LIST                ;Loads the list value into R0
	LDR R1,[R0],#4   	        ;Loads the value of R0 into R1 as indexes by 4
	LDR R8,[R0]                 ;Loads the value of R0 into R1 (the value of the counter variable)
	CMP R1,#0                   ;Compares R1 to 0 (keeps track of counter value allowing us to run the loop until it hits 0)
	BEQ ZERO                    
	MOV R3,#1                   ;Sets the value of R3 to 1
LOOP    LDR R2,[R0],#4          ;Loads the values of the list into R2 
		MUL R3,R3,R2            ;Multiplies R2 by R3 and stores in R3
		SUBS R1,R1,#1           ;Subtracts 1 from the counter varible
		BNE LOOP 
		
		           
		LDR R0,=Msg2            ;Ouputs the second message
		BL PutStr
		MOV R0,R3
		BL PutDec
		MOV R1,R8              
		BL UDivMod
		
		
	
		
		MOV R4,#1000    ;Sets the value of R4 to 1000
		MUL R0, R4, R4  ; Squares R4 and stores the value in R0 
		ADD R0, R4      ; Adds the value of R0 by the value in R4
		MOV R1, #2      ; Puts the value of 2 in R1
		BL UDivMod      ;Divides the value of R0 by the value of R1
		MOV R0,R1       ;Moves the divided value to R0
		MOV R1,R4       ;Moves the value of R4 to R1
		BL UDivMod      ;Divides R0 by R1
		
		
		
		
		LDR R0,=Msg3    ;Prints out message 3
		BL PutStr
		MOV R0, R1      ;Moves the value of R1 to R0
		BL PutDec       
		
		
		MOV R1,R0     ;Moves the value in R0 (B) into R1
		MOV R0,R3     ;Moves the value in R3 (A) into R0
		BL UDivMod    ;Divides R0 by R1
		
		LDR R0, =Msg4 ;Prints out message 4
		BL PutStr
		MOV R0,R1     ;Prints out the value in R1 (M)
		BL PutDec
		
		
		
		
		BAL EXIT
		
		
		
	
	
ZERO LDR   R0,=Msg1
	  BL    PutStr
	
	  
	


	
EXIT	POP		{PC}
	
LIST DCD 0x7,0x1,0x2,0x3,0x4,0x5,0x6,0x7
Msg1 DCB " The list is empty!",0
Msg2 DCB "A = ",0
Msg3 DCB " B = ",0
Msg4 DCB " M = ",0
	

	ALIGN
		

		

	END			; end of source program in this file
