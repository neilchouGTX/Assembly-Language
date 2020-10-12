INCLUDE Irvine32.inc

includelib legacy_stdio_definitions.lib

.586
.model flat, stdcall
.stack 4096
ExitProcess proto, dwExitCode:dword

AllPrimeFactors PROTO C,
N : DWORD

.data
inputline BYTE "Enter an integer:", 0
outputline BYTE "The number of prime factors:", 0
strInt BYTE "%d", 0
Num DWORD ?
Cnt DWORD ?

.code
asmMain PROC C
INVOKE printf, ADDR inputline
INVOKE scanf, ADDR strInt, ADDR Num
INVOKE AllPrimeFactors, Num
mov Cnt, eax
call crlf
INVOKE printf, ADDR outputline
mov eax, Cnt
INVOKE printf, ADDR strInt, Cnt
call crlf
INVOKE ExitProcess, 0



asmMain endp
END