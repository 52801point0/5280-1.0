// To keep this in the first portion of the binary.
.section ".text.boot"
 
// Make _start global.
.globl _start

_start:
    // Using r10, r11, and r12 to avoid stepping on other code
    // Base address for GPIO on RPi 3b
    ldr r10,=0x3f200000

    // The method of reading the register and masking bits is from
    // https://www.raspberrypi.org/forums/viewtopic.php?&t=48770

    // Enable only GPIO 9
    // #0 means first set of 10 GPIO pins; #7 is bitmask; #27 is 9 times 3
    // (for GPIO 9)
    ldr r2,[r10,#0]
    mov r11,#7
    lsl r11,#27
    bic r12,r12

    mov r11,#1
    lsl r11,#27
    orr r11,r12
    str r11,[r10,#28]

    // Enable only GPIO 10
    // #4 means second set of 10 GPIO pins; #7 is bitmask; #0 is 0 times 3
    // (for GPIO 10)
    ldr r12,[r10,#4]
    mov r11,#7
    lsl r11,#0
    bic r12,r12

    mov r11,#1
    lsl r11,#0
    orr r11,r12
    str r11,[r10,#28]

    // Enable only GPIO 11
    // #4 means second set of 10 GPIO pins; #7 is bitmask; #3 is 1 times 3
    // (for GPIO 11)
    ldr r12,[r10,#4]
    mov r11,#7
    lsl r11,#3
    bic r12,r12

    mov r11,#1
    lsl r11,#3
    orr r11,r12
    str r11,[r10,#28]

    // Turn on GPIO 9
    mov r11,#1
    lsl r11,#9
    str r11,[r10,#40]
 
    // Turn off GPIO 10
    mov r11,#1
    lsl r11,#10
    str r11,[r10,#28]
 
    // Turn on GPIO 11
    mov r11,#1
    lsl r11,#11
 
// Entry point for the kernel.
// r15 -> should begin execution at 0x8000.
// r0 -> 0x00000000
// r1 -> 0x00000C42
// r2 -> 0x00000100 - start of ATAGS
// preserve these registers as argument for kernel_main

	// Setup the stack.
	mov sp, #0x8000
 
	// Clear out bss.
	ldr r4, =__bss_start
	ldr r9, =__bss_end
	mov r5, #0
	mov r6, #0
	mov r7, #0
	mov r8, #0
	b       2f
 
1:
	// store multiple at r4.
	stmia r4!, {r5-r8}
 
	// If we are still below bss_end, loop.
2:
	cmp r4, r9
	blo 1b

	// Call kernel_main
	ldr r3, =kernel_main
	blx r3
 
	// halt
halt:
	wfe
	b halt

