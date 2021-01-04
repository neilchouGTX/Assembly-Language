INCLUDE Irvine32.inc				;CSIE 408261046 Chou,Ping-Han 2020/12/29
INCLUDE Macros.inc

includelib ucrt.lib
includelib legacy_stdio_definitions.lib

.586
.model flat, stdcall
.stack 4096
ExitProcess proto, dwExitCode:dword

MinP PROTO,							;Some PROTO
	address: PTR real8, N:DWORD

MaxP PROTO,
	address: PTR real8, N:DWORD

SumP PROTO,
	address: PTR real8, N:DWORD

.data
Num DWORD ?
trash real8 ?
array real8 350 DUP(?)
sum real8 ?
max real8 ?
min real8 ?

.code
main PROC							;CSIE 408261046 Chou,Ping-Han 2020/12/29
	call readDec
	mov Num, EAX
	mov ECX, Num
	mov esi, 0

	input:					;input the numbers
	call readFloat
	fstp [array + esi]	
	add esi, TYPE REAL8
	loop input

	INVOKE MinP, OFFSET array , Num
	mWriteSpace 1
	INVOKE MaxP, OFFSET array , Num
	call crlf
	INVOKE SumP, OFFSET array , Num
	call crlf
	call ProdP
	call crlf
	call DivP
	call crlf
	call SqrtP

	INVOKE ExitProcess, 0
main endp

MinP PROC, address: PTR real8, N:DWORD
	mov ECX,N
	mov esi,address
	fld REAL8 PTR [esi]
	fstp min

	findMin:
	fld min
	fld REAL8 PTR[esi]
	fcomi ST(0),ST(1)
	ja continue
	fst min
	continue:
	fstp trash					;clear the flaot stack
	fstp trash
	add esi, TYPE REAL8
	loop findMin

	fld min
	call writeFloat
	fstp min
	ret
MinP ENDP

MaxP PROC, address: PTR real8, N:DWORD
	mov ECX,N
	mov esi,address
	fld REAL8 PTR[esi]
	fstp max

	findMax:
	fld max
	fld REAL8 PTR[esi]
	fcomi ST(0),ST(1)
	jb continue
	fst max
	continue:
	fstp trash					;clear the flaot stack
	fstp trash
	add esi, TYPE REAL8
	loop findMax

	fld max
	call writeFloat
	fstp max
	ret
MaxP ENDP

SumP PROC, address: PTR real8, N:DWORD
	mov ECX,N
	mov esi,address
	fld REAL8 PTR[esi]
	fstp sum							;the first one of array is sum
	dec ECX								;only add N-1 times
	add esi, TYPE REAL8

	findSum:
	fld REAL8 PTR[esi]
	fld sum
	faddp
	fstp sum
	add esi, TYPE REAL8
	loop findSum

	fld sum
	call writeFloat
	fstp trash
	ret
SumP ENDP

ProdP PROC
	fld min
	fld max
	FMULP
	call writeFloat
	fstp trash
	ret
ProdP ENDP

DivP PROC
	fld sum
	fild Num
	fdivp
	call writeFloat
	fstp trash
	ret
DivP ENDP

SqrtP PROC
	fld sum
	fsqrt
	call writeFloat
	fstp trash
	ret
SqrtP ENDP

END main