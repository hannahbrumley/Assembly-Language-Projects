;This program will add the elemnts of a counted list. The program will
;also check for the empty list and display a message to the user.


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


	PUSH		{LR}		; save return address of caller in init.s
	LDR R0, =LIST
	LDR R1,[R0],#4
	
	CMP R1,#0               ;Z=1
	BEQ EMPTY
	
LOOP LDR R2,[R0],#4          ;R2 = 0x1
	 ADD R3,R2
		SUBS R1,#1
		BNE LOOP 
		
		LDR R0,=Msg2
		BL PutStr
		MOV R0,R3
		BL PutDec
	
	
EMPTY LDR   R0,=Msg1
	  BL    PutStr
	
		
		
	POP		{PC}		; return from main (our last executable instruction)
	ALIGN	
; Data items (READONLY)
	
;LIST	DCD	0x6,0x1,0x2,0x3,0x4,0x5,0x6
LIST DCD 0x0
Msg1 DCB "The list is empty",0
Msg2 DCB " The Total of the list is: ",0
;Data items (READWRITE)	

	ALIGN
		
	AREA    MyData, DATA, READWRITE
		
	ALIGN	
	




	ALIGN

	END			; end of source program in this file
