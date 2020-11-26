INCLUDE Irvine32.inc

.586
.model flat, stdcall
.stack 4096
ExitProcess proto, dwExitCode:dword

gcd PROTO, mm: DWORD, nn: DWORD
lcm PROTO, newTemp : DWORD, newGcdtotal : DWORD

.data
M DWORD ?
N DWORD ?
temp DWORD ?				;temp is M*N
gcdTotal DWORD 1			;store gcd
lcmTotal DWORD ?			;store lcm
space BYTE " ", 0
.code
main PROC
	start:
		mov gcdTotal, 1
		call readDec
		cmp eax,0			;if M < 0 jump to finish
		jbe finish
		mov M, EAX
		call readDec
		mov N, EAX
		mov EBX,M
		mul EBX				;M multiply N
		mov temp,EAX
		cmp EAX,EBX			;make M always the bigger one
		ja goGCD
		mov M,EBX			;change M and N
		mov N,EAX
	goGCD:
		INVOKE gcd,M,N		
		mov gcdTotal, EAX
		INVOKE lcm,temp,gcdTotal
		mov lcmTotal, EAX
		mov EAX, gcdTotal		;print gcd and lcm
		call writeDec
		mov EDX, OFFSET space
		call writeString
		mov EAX, lcmTotal
		call writeDec
		call crlf
		jmp start				;infinte loop
	finish:
INVOKE ExitProcess, 0
main endp

gcd PROC, mm:DWORD, nn:DWORD
	LOCAL R:DWORD
	mov EAX, mm
	mov EBX, nn
	cmp EBX, 0
	je fin
	cdq
	div EBX
	mov EAX,nn
	mov R,EDX
	INVOKE gcd,nn,R						;recursion
	fin:
	ret
gcd endp

lcm PROC, newTemp:DWORD, newGcdtotal:DWORD
	mov EAX, newTemp
	mov EBX, newGcdtotal
	cdq
	div EBX					;compute lcm
	ret
lcm endp
END main