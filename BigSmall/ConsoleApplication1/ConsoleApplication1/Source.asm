INCLUDE Irvine32.inc

.586
.model flat, stdcall
.stack 4096
ExitProcess proto, dwExitCode:dword

.data
output BYTE "Please enter number:",0
maxout BYTE "Max = ",0
minout BYTE "Min = ",0
Cnt DWORD ?
min SDWORD ?
max SDWORD ?
list SDWORD 10000 DUP(?)
addreass SDWORD ?

.code
main PROC
	mov EDX, OFFSET output
	call writeString

	call readint
	mov ECX, EAX
	mov Cnt, ECX
	mov EBX, [list]
	mov addreass, EBX
	mov EBX, 0
	input:
		call readint
		mov [list + EBX], EAX
		add EBX, 4
		loop input
	call minP
	call crlf
	call maxP
	
	;call DumpRegs
	INVOKE ExitProcess, 0
main endp


maxP PROC
	mov EBX, 0
	
	mov EAX, [list + EBX]
	mov max, EAX
	mov ECX, Cnt
	compare:
		mov EAX, max
		cmp [list + EBX], EAX
		jg L1
		jle L2
		L1:
			mov EAX, [list + EBX]
			mov max, EAX
		L2:
			add EBX,4
		loop compare
	mov EDX, OFFSET maxout
	call writeString
	mov EAX, max
	cmp EAX, 0
	jge L3
	jl L4
	L3:
		call writeDec
		jmp L5
	L4:
		call writeInt
	L5:
	ret
maxP endp
	
minP PROC
	mov EBX, 0
	
	mov EAX, [list + EBX]
	mov min, EAX
	mov ECX, Cnt
	compare :
		mov EAX, min
		cmp[list + EBX], EAX
		je L1
		jge L2
		L1 :
			mov EAX, [list + EBX]
			mov min, EAX
		L2 :
			add EBX, 4
		loop compare
	mov EDX, OFFSET minout
	call writeString
	mov EAX, min
	cmp EAX, 0
	jge L3
	jl L4
	L3:
		call writeDec
		jmp L5
	L4 :
		call writeInt
	L5:
	ret
minP endp
END main
