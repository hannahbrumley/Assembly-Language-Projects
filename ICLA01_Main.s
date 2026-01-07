; File:ICLA01-main.s
;Students Name:

	EXPORT	main		; this line is needed to interface with init.s
	AREA    MyCode, CODE, READONLY

	ALIGN			; highly recommended to start and end any area with ALIGN

; Start of executable code is at following label: main

main

;-------------------- START OF MODIFIABLE CODE ----------------------

	PUSH	{LR}		; save return address of caller in init.s
	LDR R0,=DATA1
	LDR R1,[R0]          
	LDR R2,[R0,#4]
	LDR R3,[R0,#8]
	LDR R4,[R0,#12]
	
	LDR R0,=DATA2
	LDR R5,[R0]
	LDR R6,[R0,#4]
	LDR R7,[R0,#8]
	LDR R8,[R0,#12]
	
	ADDS R9,R4,R8
	ADCS R10,R3,R7
	ADCS R11,R2,R6
	ADCS R12,R1,R5
	
	LDR R0,=TOTAL
	STR R12,[R0,#12]
	STR R11,[R0,#8]
	STR R10,[R0,#4]
	STR R9,[R0]
	
	
	
	POP		{PC}		; return from main (our last executable instruction)

	ALIGN
	
; The following data items are in the CODE area,
; so they are all READONLY (i.e. cannot be modified at run-time),
; but they can be initialized at assembly-time to any value

DATA1 DCD 0x12345678, 0xAABBCCDD, 0xEEFF1122, 0x11223344
DATA2 DCD 0x12345678, 0xAABBCCDD, 0xEEFF1122, 0x11223344
	


	ALIGN
		
	AREA    MyData, DATA, READWRITE
		
	ALIGN

		

TOTAL SPACE 16
;-------------------- END OF MODIFIABLE CODE ----------------------

	ALIGN

	END			; end of source program in this file
