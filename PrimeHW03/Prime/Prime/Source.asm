INCLUDE Irvine32.inc

.586
.model flat, stdcall
.stack 4096
ExitProcess proto, dwExitCode:dword

.data
num DWORD ?				;save the number
temp DWORD 2			;save the divisor
count DWORD ?			;save the power count
flag BYTE 1					;save either print mulString or not
mulString BYTE " * " , 0	
powString BYTE "^" , 0

.code
main PROC
	master:
		call readInt
		mov num, EAX
		cmp num, 0			;if num < 0 then jump to finish
		jl finish
		je one
		mov flag, 1			;reset flag to 1
		call PrimeFac		;call PrimeFac to process the number
		one:
		call crlf
		mov ECX, 10			;make loop infinity
		loop master
	finish:
	INVOKE ExitProcess, 0
main endp

PrimeFac PROC
	mov temp, 1				;set the divisor
	anotherTemp:
		inc temp
		mov count, 0		;reset the power count
		TestLB:
			mov EAX, num
			cdq
			div temp
			cmp EDX, 0			;if the reminder is 0 than count+1 else jump to nofac
			jne nofac
			mov num, EAX
			inc count
			mov ECX , 5			;make loop infinity
			loop TestLB
		nofac:
			cmp count, 0		;if count still 0 means that this divisor is not correct jump to next
			je next
			call print
			mov flag, 0
			next:
			mov EAX, num
			cmp temp, EAX		;if temp > num then jump to fin
			jae fin
			mov ECX, 5			;make loop infinity
		loop anotherTemp
		fin:
		ret
PrimeFac endp

printmul PROC
	mov edx, OFFSET mulString		;print multiple symbol
	call writeString
	ret
printmul endp

print PROC

	cmp flag ,0					;check whether printmul need to print 
	jne nomul
		call printmul
	
		nomul:
			mov EAX,temp
			call writeDec
			cmp count, 1			;if the power count is 1 then we do not need to print the power
			je nopow
			mov edx, OFFSET powString
			call writeString
			mov EAX, count
			call writeDec
		nopow:
	ret
print endp

END main