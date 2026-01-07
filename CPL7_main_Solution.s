; File: CLP7-main.s

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


main	PUSH		{LR}
	BL		ChkSum
	POP		{PC}
		
ChkSum	PUSH		{LR}
		LDR		R0,= STR
		LDRB	R1,[R0],#1
		CMP		R1,#0
		BEQ		EXIT
	
LOOP LDRB		R2,[R0],#1
	 ADD		R3,R3,R2
	 SUBS		R1,R1,#1
	 BNE		LOOP
	
	LDRB	R7,[R0]
	CMP		R3,R7
	BEQ		YEA
	MOV		R4,#0
	BAL		EXIT
	
YEA	MOV		R4,#0xFFFFFFFF	
EXIT	POP		{PC}


STR	DCB	0x3, 'A', 'B', 'C',0xC6
ALIGN
		

	END			; end of source program in this file
