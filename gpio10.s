.section init
.global _start

_start:
ldr r0,=0x3F000000

mov r1,#1
lsl r1,#27
str r1,[r0,#0]

mov r1,#1
lsl r1,#0
str r1,[r0,#4]

mov r1,#1
lsl r1,#3
str r1,[r0,#4]

mov r1,#1
lsl r1,#10
str r1,[r0,#40]

mov r1,#1
lsl r1,#9
str r1,[r0,#28]

mov r1,#1
lsl r1,#11
str r1,[r0,#40]

loop$:
b loop$

