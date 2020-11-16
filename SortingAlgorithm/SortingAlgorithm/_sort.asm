INCLUDE prototype.inc

.data
i DWORD 1
j DWORD ?
key SDWORD ?

.code 
sort PROC,
	ptrArray: PTR SDWORD,
	arraySize : DWORD


	mov esi, ptrArray
	mov ecx, arraySize
	L2:
		mov eax,[esi]
		call writeInt
		add esi,4
		loop L2

	mov ecx,arraySize
	dec ecx
	mov esi, 4
	L1:
		mov eax, ptrArray[esi]
		mov key, eax
		mov ebx, esi
		sub ebx,4
		push ecx
		Testt:
			cmp ebx,0
			jb  exitt
			mov eax,key
			;call writeInt
			cmp ptrArray[ebx],eax
			jle  exitt
			mov eax, ptrArray[ebx]
			mov ptrArray[ebx+4],eax
			sub ebx,4
			mov ecx,5
			loop Testt
		exitt:
		pop ecx
		mov eax,key
		mov ptrArray[ebx+4],eax
		add esi,4
		loop L1


	ret
sort endp
END