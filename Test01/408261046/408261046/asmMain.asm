INCLUDE Irvine32.inc


gcd proto C, x:DWORD, y:DWORD

.586
.MODEL flat,stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD


.data
;---------------------------
;These are String
;---------------------------
gcdString BYTE "GCD(" ,0
lcmString BYTE "LCM(" ,0
dotSpace BYTE ", " ,0
equall BYTE ") = " ,0

;---------------------------
;These are some variable
;---------------------------
count DWORD ?
X DWORD ?
Y DWORD ?
GCDreturn DWORD ?
LCMreturn DWORD ?


.code
main PROC C
	call readDec
	mov ECX, EAX
	mov count, ECX
	fun:
		call readDec
		mov X, EAX
		call readDec
		mov Y, EAX
		cmp X, EAX					;compare X and Y to choose which is profix or postfix
		jbe L1
			mov EAX ,Y
			mov EBX ,X
			mov Y, EBX
			mov X, EAX
		L1:
			call printGCD
			call printLCM
		mov ECX, count			;restore ECX with count
		dec count				;count--
		loop fun
	ret
main ENDP

printGCD PROC
		;--------------------------- These are some ouput format
		mov edx, OFFSET gcdString
		call writeString
		mov EAX, X
		call writeDec
		mov edx, OFFSET dotSpace
		call writeString
		mov EAX, Y
		call writeDec
		mov edx, OFFSET equall
		call writeString
		;---------------------------
		INVOKE gcd, X, Y		;call Source.cpp's gcd function
		mov GCDreturn, EAX
		call writeDec
		call crlf
		ret
printGCD ENDP


printLCM PROC
	mov EAX, X
	mul Y						;multiply x*y
	mov EBX, GCDreturn
	div EBX						;divide (x*y)/GCDreturn
	mov LCMreturn, EAX
	;--------------------------- These are some ouput format
	mov edx, OFFSET lcmString
	call writeString
	mov EAX, X
	call writeDec
	mov edx, OFFSET dotSpace
	call writeString
	mov EAX, Y
	call writeDec
	mov edx, OFFSET equall
	call writeString
	;---------------------------
	mov  EAX , LCMreturn
	call writeDec
	call crlf
	ret
printLCM ENDP

END 