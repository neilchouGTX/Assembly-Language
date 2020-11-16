INCLUDE Irvine32.inc

.586
.model flat, stdcall
.stack 4096
ExitProcess PROTO, dwExitCode : DWORD

sort PROTO,
	ptrArray: PTR SDWORD,
	arraySize: DWORD