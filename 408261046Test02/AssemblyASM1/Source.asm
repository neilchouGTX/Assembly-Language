INCLUDE Irvine32.inc
INCLUDE Macros.inc

.586
.model flat, stdcall
.stack 4096
ExitProcess proto, dwExitCode:dword

postiveOrNeg MACRO SDWORD				;define a macro to know whether call writeInt or writeDec to print
	push EAX
	cmp EAX,0
	jg goDec
	call WriteInt
	jmp finish
	goDec:
		call WriteDec
	finish:
	pop EAX
ENDM

LovepostiveOrNeg MACRO SDWORD			;Compiler told me the same Macro have redefined labels so i create another one
	push EAX
	cmp EAX,0
	jg LoveDec
	call WriteInt
	jmp Lovefinish
	LoveDec:
		call WriteDec
	Lovefinish:
	pop EAX
ENDM


.data
evenn SDWORD 200 DUP (?)
oddd SDWORD 200 DUP (?)
countEven DWORD 0
countOdd DWORD 0
sumEven SDWORD 0
sumOdd SDWORD 0
avgEven real8 ?
avgOdd real8 ?

.code
main PROC
	mov ESI,0
	mov EBP,0
	input:
		call readInt
		cmp EAX,0						;if eax = 0 the input stop
		je fin
		test EAX, 1						;compare EAX is odd or even
		jz evenGo						;zero flag = 1 means is even
		
	oddGo:
		mov [oddd + EBP], EAX
		add EBP,4
		inc countOdd
		jmp input
	evenGo:
		mov [evenn + ESI], EAX
		add ESI,4
		inc countEven
		jmp input
	fin:
		call N1									;call lots of procedures
		call N2
		call N3
		call N4
		call N5
		INVOKE ExitProcess, 0
main endp

N1 PROC	
	mov EAX, countOdd						;print the number of Odd and print them out
	call writeDec
	mov ESI,0
	mov ECX, countOdd
	OddLoop:
		mWriteSpace 1						;print space
		mov EAX, [oddd + ESI]
		add ESI,4
		postiveOrNeg EAX
		
		loop OddLoop
	call crlf
	ret
N1 ENDP

N2 PROC										;print the number of Even and print them out
	mov EAX, countEven
	call writeDec
	mov ESI,0
	mov ECX, countEven
	EvenLoop:
		mWriteSpace 1						;print space
		mov EAX, [evenn + ESI]
		add ESI,4
		postiveOrNeg EAX
		
		loop EvenLoop
	call crlf
	ret
N2 ENDP

N3 PROC										;find the odd max and even min
	LOCAL max:SDWORD, min:SDWORD
	mov ESI,0
	mov EAX,[oddd + ESI]
	mov max, EAX
	mov ECX,countOdd
	findMax:
		mov EAX,[oddd + ESI]
		cmp max, EAX
		jg continue
		mov max, EAX
		continue:
			add ESI,4
			loop findMax
	mov EAX, max
	postiveOrNeg EAX
	mWriteSpace 1

	mov ESI,0
	mov EAX,[evenn + ESI]
	mov min, EAX
	mov ECX, countEven
	findMin:
		mov EAX, [evenn + ESI]
		cmp min, EAX
		jl con
		mov min, EAX
		con:
			add ESI,4
			loop findMin
	mov EAX,min
	LovepostiveOrNeg EAX
	call crlf
	ret
N3 ENDP

N4 PROC										;print odd and even's sum
	mov ESI, 0
	mov ECX, countOdd
	totalOdd:
		mov EAX, [oddd + ESI]
		add sumOdd, EAX
		add ESI,4
		loop totalOdd

	mov ESI, 0
	mov ECX, countEven
	totalEven:
		mov EAX, [evenn + ESI]
		add sumEven, EAX
		add ESI,4
		loop totalEven
	mov EAX,SumOdd
	postiveOrNeg EAX
	mWriteSpace 1
	mov EAX,SumEven
	LovepostiveOrNeg EAX
	call crlf
	ret
N4 ENDP

N5 PROC										;print the average of both
	finit
	fild SumOdd
	fild countOdd
	fdivp
	fstp avgOdd

	fild SumEven
	fild countEven
	fdivp
	fstp avgEven


	fld avgOdd
	call writeFloat
	
	mWriteSpace 1

	fld avgEven
	call writeFloat

	ret
N5 ENDP

END main