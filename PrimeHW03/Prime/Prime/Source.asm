INCLUDE Irvine32.inc

.586
.model flat, stdcall
.stack 4096
ExitProcess proto, dwExitCode:dword

.data
num DWORD ?
temp DWORD 2
count DWORD ?
flag BYTE 1
mulString BYTE " * " , 0
powString BYTE "^" , 0

.code
main PROC
master:
	call readInt
	mov num, EAX
	cmp num, 0
	jl finish
	mov flag, 1
	call PrimeFac
	call crlf
	mov ECX, 10
	loop master
finish:
INVOKE ExitProcess, 0
main endp

PrimeFac PROC
mov temp, 1
anotherTemp:
	inc temp
	mov count, 0
	TestLB:
		mov EAX, num
		cdq
		div temp
		cmp EDX, 0
		jne nofac
		mov num, EAX
		inc count
		mov ECX , 5
		loop TestLB

	nofac:
		cmp count, 0
		je next
		call print
		mov flag, 0
		next:
		mov EAX, num
		cmp temp, EAX
		jae fin
		mov ECX, 5
	loop anotherTemp
	fin:
	ret
PrimeFac endp

printmul PROC
mov edx, OFFSET mulString
call writeString
ret
printmul endp

print PROC

cmp flag ,0
jne nomul
	call printmul
	
	nomul:
		mov EAX,temp
		call writeDec
		cmp count, 1
		je nopow
		mov edx, OFFSET powString
		call writeString
		mov EAX, count
		call writeDec
	nopow:
ret
print endp

END main