INCLUDE Irvine32.inc

includelib ucrt.lib
includelib legacy_stdio_definitions.lib

.586
.model flat, stdcall
.stack 4096
ExitProcess PROTO, dwExitCode : DWORD

sort PROTO,
	ptrArray: PTR SDWORD,
	arraySize: DWORD