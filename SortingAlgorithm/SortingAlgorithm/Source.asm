INCLUDE prototype.inc

.data
arr SDWORD 100000 DUP(?)
inputline BYTE "Enter an integer:", 0
space BYTE " ",0
format BYTE "%d",0

count DWORD ?

.code
main PROC
	round:
		INVOKE scanf, ADDR format, ADDR count
		mov eax,count
		cmp eax,0
		je quit						;if N = 0 then quit
		mov count,eax
		mov ecx, count				;make input loop "count" times
		mov esi, OFFSET arr
		
		input:
			push ECX
			INVOKE scanf, ADDR format, ADDR [esi]
			pop ecx
			add esi,4
			loop input
		INVOKE sort, ADDR arr, count		;invoke sort and pass  2 parameters
		call printSort				
		call crlf
		call printMid
		call crlf
		jmp round					;infinite loop
	quit:
	INVOKE ExitProcess, 0 
main ENDP

printSort PROC
	mov esi, OFFSET arr
	mov ecx, count				;loop count times to print the element in array
	L1 :
		mov eax, [esi]
		cmp eax,0			;if [esi]>0 then dont need to print '+'
		Jl INTT
		DECC:
			call writeDec
			jmp Con
		INTT:
			call writeInt
		Con:
		mov edx, offset space
		call writeString
		add esi, 4				;take next element
		loop L1
	ret
printSort ENDP

printMid PROC
	mov eax,count
	mov edx,0
	mov ebx,2
	div ebx
	cmp edx,0			;compare the remainder is 0 or 1
	ja ODD
	EVENN:
		mov ecx,2				;print two times
		mov esi, OFFSET arr
		mov ebx,4				
		mul ebx					;4 bype
		add esi, eax
		sub esi, 4				;the middle left one
		mid:
			mov eax,[esi]
			cmp eax,0
			Jl INTT
			DECC:
				call writeDec
				jmp Con
			INTT:
				call writeInt
			Con:
			mov edx, offset space
			call writeString
			add esi,4			;take next element(middle right one)
			loop mid
			jmp oddCon
	ODD:
		mov esi, OFFSET arr
		mov ebx,4
		mul ebx
		add esi, eax
		mov eax,[esi]
		cmp eax,0
		Jl oddINTT
		oddDECC:
			call writeDec
			jmp oddCon
		oddINTT:
			call writeInt
	oddCon:

	ret
printMid ENDP
end main