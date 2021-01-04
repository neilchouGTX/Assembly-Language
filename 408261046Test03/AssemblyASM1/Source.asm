INCLUDE Irvine32.inc
INCLUDE Macros.inc

includelib ucrt.lib
includelib legacy_stdio_definitions.lib

.586
.model flat, stdcall
.stack 4096
ExitProcess proto, dwExitCode:dword

minimumArray MACRO arr:REQ				;find the minimum number of array
	LOCAL findMin
	mov esi, OFFSET arr
	mov ECX,NUM
	minimum [esi],[esi+4]
	mov min, EAX
	findMin:
		minimum [esi], min
		mov min, EAX
		add esi,4
		loop findMin
	mov EAX,min
	mov finalMin, EAX
	postiveOrNeg EAX
ENDM

maximumArray MACRO arr:REQ				;find the maximum number of array
	LOCAL findMax
	mov esi, OFFSET arr
	mov ECX, NUM
	maximum [esi],[esi+4]
	mov max, EAX
	findMax:
		maximum [esi], max
		mov max,EAX
		add esi,4
		loop findMax
	mov EAX,max
	mov finalMax, EAX
	postiveOrNeg EAX
ENDM

minimum MACRO num1:REQ,num2:REQ			;find the smaller one of two parameters
	LOCAL first,second
	mov EAX, num1
	cmp EAX, num2
	jl first
	second:
		mov EAX,num2
	first:
ENDM

maximum MACRO num1:REQ,num2:REQ			;find the bigger one of two parameters
	LOCAL first,second
	mov EAX, num1
	cmp EAX, num2
	jg first
	second:
		mov EAX,num2
	first:
ENDM

addSum MACRO num1:REQ,num2:REQ			;find the sum of all signed integers
	mov EAX, num1
	add EAX, num2
ENDM

productMaxMin MACRO num1:REQ, num2:REQ	;find the product of max and min
	mov EAX, num1
	mov EBX, num2
	imul EBX
ENDM

divideMaxMin MACRO num1:REQ, num2:REQ	;find the quotient and remainder
	mov EAX,num1
	cdq
	mov EBX,num2
	idiv EBX
ENDM

postiveOrNeg MACRO num1:REQ				;remove the '+' of postive number
	LOCAL negg,post,end
	cmp num1, 0
	jg post
	negg:
		call writeInt
		jmp end
	post:
		call writeDec
	end:
ENDM


.data
	NUM DWORD ?
	array DWORD 350 DUP(?)
	finalMax SDWORD ?
	finalMin SDWORD ?
.code

main PROC
	call readDec						;input NUM
	mov NUM, EAX
	mov ECX, NUM
	mov esi, OFFSET array
	input:								;input numbers into array
		call readInt
		mov [esi], EAX
		add esi, 4
		loop input
	call Line1
	call Line2
	call Line3
	call Line4
	INVOKE ExitProcess, 0
main ENDP

Line1 PROC
	LOCAL max:SDWORD, min:SDWORD
	minimumArray array
	mWriteSpace 1
	maximumArray array
	call crlf
	ret
Line1 ENDP

Line2 PROC
	LOCAL sum:SDWORD
	mov esi, OFFSET array
	mov EAX, [esi]
	mov sum, EAX
	mov ECX,NUM
	dec ECX
	findSum:
		addSum sum, [esi+4]
		mov sum, EAX
		add esi,4
		loop findSum
	mov EAX, sum
	postiveOrNeg EAX
	call crlf
	ret
Line2 ENDP

Line3 PROC
	productMaxMin finalMax, finalMin
	postiveOrNeg EAX
	call crlf
	ret
Line3 ENDP

Line4 PROC
	LOCAL quotient:SDWORD, remainder:SDWORD
	divideMaxMin finalMax, finalMin
	mov quotient, EAX
	mov remainder, EDX
	postiveOrNeg EAX
	mWriteSpace 1
	mov EAX,remainder
	postiveOrNeg EAX
	call crlf
	ret
Line4 ENDP

END main