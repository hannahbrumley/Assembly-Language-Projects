; File: ICLA05-main.s

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

	PUSH			{LR}		; save return address of caller in init.s
	
	BL STRCAT
		
	POP			{PC}		; return from main (our last executable instruction)
	
	
STRCAT PUSH {LR}
	LDR R0,=Msg1
	BL PutStr
	LDR R0,=STR1
	MOV R1,#MAXSTR1
	BL GetStr
	
	
	LDR R0,=Msg2
	BL PutStr
	LDR R0,=STR2
	MOV R1,#MAXSTR2
	BL GetStr
	
	
	LDR R5,=STR3
	
	LDR R0,=STR1
	LDR R2,=STR2
	
LOOP LDRB R1,[R0],#1
	CMP R1,#0
	BEQ CIRCLE
	STRB R1,[R5],#1
	BAL LOOP
	
	
CIRCLE LDRB R3,[R2],#1
	CMP R3,#0
	BEQ ANSWER
	STRB R3,[R5],#1
	BNE CIRCLE
	
ANSWER STRB R0,[R5]            
	   LDR R0,=Msg3      ;Loads the final message into R0
	   BL PutStr           
	   LDR R0,=STR3    ;Loads the new string into R0
	   BL PutStr


	POP{PC}
	

	ALIGN
		
Msg1 DCB "Enter STR1: ",0
Msg2 DCB "Enter STR2: ",0
Msg3 DCB "Your cancatenated string is: ",0
Msg4 DCB "Test",0

MAXSTR1 EQU 1000
MAXSTR2 EQU 1000
MAXSTR3 EQU 2000
	


	AREA    MyData, DATA, READWRITE
		

		
	ALIGN


STR1 SPACE MAXSTR1+1
STR2 SPACE MAXSTR2+1
STR3 SPACE MAXSTR3+1

;-------------------- END OF MODIFIABLE CODE ----------------------

	ALIGN

	END			; end of source program in this file
