INCLUDE prototype.inc


.data
arr SDWORD 100000 DUP(? )
inputline BYTE "Enter an integer:", 0
count DWORD ?



.code
main PROC
	call readInt
	mov count,eax
	mov ecx, count
	mov esi, OFFSET arr
	input:
		call readInt
		mov [esi],eax
		add esi,4
		loop input
	INVOKE sort, ADDR arr, count
	mov esi, OFFSET arr
	mov ecx,count
	L1:
		mov eax,[esi]
		call writeInt
		add esi,4
		loop L1




	exit
	INVOKE ExitProcess, 0 
main endp
end main