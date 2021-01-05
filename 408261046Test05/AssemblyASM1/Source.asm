INCLUDE Irvine32.inc
INCLUDE Macros.inc

includelib ucrt.lib
includelib legacy_stdio_definitions.lib

.586
.model flat, stdcall
.stack 4096
ExitProcess proto, dwExitCode:dword


.data
intArray DWORD 1000 DUP (?)
floatArray real8 1000 DUP (?)
trash real8 ?
formatD BYTE "%d" , 0
formatF BYTE "%lf" , 0
formatFP BYTE "%.3f", 0
sum real8 0.0
Dnum DWORD 0
avg real8 ?
totalWeight DWORD 0
sqrtNum real8 ?

.code									;2021/01/05   408261046  Chou,Ping-Han  FJU CSIE 
main PROC
	call input
	call line1
	call line23
	INVOKE ExitProcess, 0
main endp

input PROC
	push EBP
	mov esi, 0
	mov ebp, 0

	keepInput:
	INVOKE scanf, ADDR formatD, ADDR intArray[ebp]
	mov EAX, intArray[ebp]
	cmp EAX, 0 
	je finish
	inc Dnum
	INVOKE scanf, ADDR formatF, ADDR [floatArray + esi]
	add ebp, TYPE DWORD
	add esi, TYPE REAL8
	jmp keepInput
	finish:
	pop EBP
	ret
input endp

line1 PROC
	mov EAX, Dnum
	call writeDec
	mWriteSpace 1
	mov ECX, Dnum
	mov esi, 0
	findSum:
	mov EAX, [intArray + esi]
	add EAX, totalWeight
	mov totalWeight, eax
	add esi, 4
	loop findSum
	mov EAX, totalWeight
	call writeDec
	call crlf
	ret
line1 endp

line23 PROC
	push EBP
	mov esi,0
	mov ebp,0
	mov ECX, Dnum
	findComplex:
	fld [floatArray + esi]
	fmul [floatArray + esi]
	fild [intArray + ebp]
	fmulp
	fld sum
	faddp
	fstp sum
	add esi, TYPE REAL8
	add ebp, TYPE DWORD
	loop findComplex
	fld sum
	INVOKE printf, ADDR formatFP, sum
	fild totalWeight
	fdivp
	fst avg
	mWriteSpace 1
	INVOKE printf, ADDR formatFP, avg
	pop ebp
	call crlf
	fsqrt
	fst sqrtNum
	INVOKE printf, ADDR formatFP, sqrtNum
	fstp trash
	ret
line23 endp
END main