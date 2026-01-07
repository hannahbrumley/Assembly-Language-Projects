;This program will implement bubble sort algorithm



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

;-------------------- START OF MODIFIABLE CODE ----------------------
			PUSH		{LR}
			;Prompt for the string
			LDR		R0,=Msg1
			BL		PutStr
			;Preparing registers for the GetStr subroutine
			LDR		R0,=STR2
			LDR		R1,=MaxStr
			BL		GetStr
			
			BL		BUBSORT
			;Displaying sorted string
			LDR		R0,=STR2
			BL		PutStr
			
			POP		{PC}
		
		
BUBSORT			PUSH		{LR}
			; Uploading string length in R1
			LDR			R1,=LEN
			LDR			R1,[R1]
			
			SUBS		R1, #1
			MOV			R5,R1
			MOV			R4,R1
			
PASS		
			LDR			R0,=STR2
			LDR			R8,=STR2
			
LOOP		
			LDRB		R2,[R0],#1		;R2 =1st element 
			LDRB		R3,[R0]			;R3 = 2nd element
			CMP			R2,R3			; Comparing 1st and 2nd element
			
			BLT			NOSWAP
			
			STRB		R3,[R8],#1
			STRB		R2,[R8]
			
			
			BAL			NEXT
NOSWAP		ADD			R8,#1		; In case of no swap incrementing pointer for R8
NEXT		SUBS		R4,#1
			BNE			LOOP
			MOV			R4,R5
			SUBS		R1,#1
			BNE			PASS
			
		
			POP			{PC}

MaxStr	EQU		1000
Msg1	DCB		"STR: ",0
LEN		DCD		7
ALIGN
		
	AREA    MyData, DATA, READWRITE
		
	ALIGN	
STR2 SPACE	MaxStr+1	

	ALIGN

	END			; end of source program in this file

