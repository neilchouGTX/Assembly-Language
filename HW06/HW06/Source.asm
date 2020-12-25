INCLUDE Irvine32.inc

includelib ucrt.lib
includelib legacy_stdio_definitions.lib

.586
.model flat, stdcall
.stack 4096
ExitProcess proto, dwExitCode:dword

Point2D STRUCT
	X SDWORD ?
	Y SDWORD ?
Point2D ENDS

Triangle STRUCT
	sideA real8 ?
	sideB real8 ?
	sideC real8 ?
	area real8 ?
Triangle ENDS

.data
temp SDWORD ?
format BYTE "%d", 0
formatdouble BYTE "%.3f",0dh, 0ah, 0
divtwo real8 2.0
point1 Point2D <>									;define 3 point2D structure and a triangleCompute structure
point2 Point2D <>
point3 Point2D <>
triangleCompute Triangle <>


.code
main PROC
keepinput:
	call input
	call point2DP
	call triangleP
	INVOKE printf, ADDR formatdouble, triangleCompute.area
	jmp keepinput
	INVOKE ExitProcess, 0
main endp

input PROC													;input six points
	INVOKE scanf, ADDR format, ADDR temp
	cmp EAX,-1
	je finalFIN
	mov EAX, temp
	mov point1.X, EAX
	INVOKE scanf, ADDR format, ADDR temp
	mov EAX, temp
	mov point1.Y, EAX
	INVOKE scanf, ADDR format, ADDR temp
	mov EAX, temp
	mov point2.X, EAX
	INVOKE scanf, ADDR format, ADDR temp
	mov EAX, temp
	mov point2.Y, EAX
	INVOKE scanf, ADDR format, ADDR temp
	mov EAX, temp
	mov point3.X, EAX
	INVOKE scanf, ADDR format, ADDR temp
	mov EAX, temp
	mov point3.Y, EAX
	ret
	finalFIN:
	INVOKE ExitProcess, 0
input endp

point2DP PROC
	LOCAL var1: SDWORD, var2: SDWORD, total: DWORD					;compute the distance
	mov EAX, point1.X
	sub EAX, point2.X
	imul EAX
	mov var1, EAX
	mov EAX, point1.Y
	sub EAX, point2.Y
	imul EAX
	mov var2, EAX
	add eax, var1
	mov total,eax
	fild total
	fsqrt
	fstp triangleCompute.sideA

	mov EAX, point2.X
	sub EAX, point3.X
	imul EAX
	mov var1, EAX
	mov EAX, point2.Y
	sub EAX, point3.Y
	imul EAX
	mov var2, EAX
	add eax, var1
	mov total, eax
	fild total
	fsqrt
	fstp triangleCompute.sideB

	mov EAX, point1.X
	sub EAX, point3.X
	imul EAX
	mov var1, EAX
	mov EAX, point1.Y
	sub EAX, point3.Y
	imul EAX
	mov var2, EAX
	add eax, var1
	mov total, eax
	fild total
	fsqrt
	fstp triangleCompute.sideC

	ret
point2DP endp

triangleP PROC
	LOCAL s:real8, ssa:real8, ssb:real8, ssc:real8					; Hero's formula
	fld triangleCompute.sideA
	fld triangleCompute.sideB
	fld triangleCompute.sideC
	faddp
	faddp
	fld divtwo
	fdivp
	fstp s

	fld s
	fld triangleCompute.sideA
	fsubp
	fstp ssa

	fld s
	fld triangleCompute.sideB
	fsubp
	fstp ssb

	fld s
	fld triangleCompute.sideC
	fsubp
	fstp ssc

	fld s
	fld ssa
	fld ssb
	fld ssc
	fmulp
	fmulp
	fmulp
	fsqrt
	fstp triangleCompute.area

	ret 
triangleP endp
END main