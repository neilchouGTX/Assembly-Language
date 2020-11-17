INCLUDE prototype.inc


.data
i DWORD 1
j SDWORD 1
key SDWORD ?

.code 
sort PROC,
	ptrArray: PTR SDWORD,
	arraySize : DWORD

	mov i,1
	mov j,1
	mov ecx,arraySize
	dec ecx
	mov esi, ptrArray
	add esi,4
	L1:
		mov eax, [esi]
		mov key, eax
		push esi
		sub esi,4
		mov eax,i
		mov j, eax
		dec j
		Testt:
			cmp j,0
			jl  exitt
			mov eax,key
			cmp [esi],eax
			jge  exitt
			mov eax, [esi]
			mov [esi+4],eax
			sub esi,4
			dec j
			jmp Testt
		exitt:
		mov eax,key
		mov [esi+4],eax
		pop esi
		add esi,4
		inc i
		loop L1

	ret
sort endp
END