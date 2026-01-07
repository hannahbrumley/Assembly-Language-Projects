; File: ICLA04-main.s
;Hannah Brumley

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
	PUSH		{LR}	
	
	
	LDR R1,=LENGTH
	LDR R2,[R1]
	LDR R3,=ARRAY1
	LDR R5,=ARRAY2
	
	
LOOP LDR R6,[R3], #4
	LDR R7,[R5], #4
	CMP R7,R6
	BNE EXIT
	SUBS R2,#1
	BNE LOOP

	LDR R0,=Msg2
	 BL PutStr
	 BAL ENDNOWPLEASE

EXIT LDR R0, =Msg1
	BL PutStr
	BAL ENDNOWPLEASE
		; save return address of caller in init.s
		
ENDNOWPLEASE	POP		{PC}		; return from main (our last executable instruction)
	
	


	
	ALIGN	
	
	
LENGTH	DCD	0xA
ARRAY1	DCD	0x5, 0x2, 0x3, 0x4, 0x5, 0x6, 0x7, 0x8, 0x9, 0x9	; First Array
ARRAY2	DCD	0x5, 0x2, 0x3, 0x4, 0x5, 0x6, 0x7, 0x8, 0x9, 0xA	; Second Array
Msg1    DCB "ARRAY1 and ARRAY2 are not identical",0
Msg2    DCB "ARRAY1 and ARRAY2 are identical",0

	ALIGN
		
	AREA    MyData, DATA, READWRITE
		
	ALIGN	
	


;-------------------- END OF MODIFIABLE CODE ----------------------

	ALIGN

	END			; end of source program in this file
