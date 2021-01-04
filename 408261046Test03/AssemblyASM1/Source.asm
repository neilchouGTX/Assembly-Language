include irvine32.inc
includelib legacy_stdio_definitions.lib
includelib ucrt.lib

.386
.stack 4096
ExitProcess proto, dwExitCode:Dword

minn proto,
Minroom : PTR REAL8,
MinCnt : DWORD

.data
count DWORD ?
room  Real8 300 DUP(? )
outtmax Real8 ?
min REAL8 ?
sum REAL8 ?
product REAL8 ?
format BYTE "%.1f", 0

.code
main PROC; 2020 / 12 / 29 408261242 資工二甲 陳柏昱
call ReadDec
mov ECX, EAX
mov count, ECX
mov ESI, 0
input:
call ReadFloat
fstp room[esi]
add esi, type real8
loop input
invoke minn, ADDR room, count
exit
main endp

minn PROC,
Minroom:PTR REAL8,
MinCnt : DWORD

mov esi, Minroom
fld real8 PTR[esi]
add esi, type real8
fld real8 PTR[esi]
fcomi st(0), st(1)
jnb outmax
fstp min
fstp outtmax
jmp ready
outmax :
fstp outtmax
fstp min
ready :
mov ECX, MinCnt
sub ECX, 2
Minout :
    cmp ECX, 0
    je outputMin
    fld min
    add esi, type real8
    fld real8 PTR[esi]
    fcomi st(0), st(1)
    jnb outmaxx
    fstp min
    fstp outtmax
    loop Minout
    outmaxx :
fstp outtmax
fstp min
dec ECX
jmp Minout
outputMin :
invoke printf, ADDR format, min
ret
minn endp


end main