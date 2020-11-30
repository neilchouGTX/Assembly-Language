INCLUDE Irvine32.inc

.586
.model flat, stdcall
.stack 4096
ExitProcess proto, dwExitCode:dword

gcd PROTO, mm: DWORD, nn: DWORD
lcm PROTO, newTemp : DWORD, MM : DWORD, NN : DWORD

.data
M DWORD ?
N DWORD ?
temp DWORD ?				;temp is M*N
gcdTotal DWORD ?			;store gcd
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
		INVOKE lcm,temp,M,N
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
	je fin				;if nn==0 then jump to fin
	cdq
	div EBX
	mov EAX,nn
	mov R,EDX			;save the mm%nn
	INVOKE gcd,nn,R				;recursion
	fin:
	ret
gcd endp

lcm PROC, newTemp:DWORD, MM : DWORD, NN : DWORD
	INVOKE gcd, MM, NN			;call gcd
	mov gcdTotal, EAX			;save the return value of gcd
	mov EAX, newTemp
	mov EBX, gcdtotal
	cdq
	div EBX					;compute lcm
	ret
lcm endp
END main