// To keep this in the first portion of the binary.
.section ".text.boot"
 
// Make _start global.
.globl _start
 
// Entry point for the kernel.
// r15 -> should begin execution at 0x8000.
// r0 -> 0x00000000
// r1 -> 0x00000C42
// r2 -> 0x00000100 - start of ATAGS
// preserve these registers as argument for kernel_main
_start:
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

    // Initialise GPIO 9, 10, 11
    // base address of GPIO on RPI 3b
    // enable GPIO pins, set for output.
    // turn on 9, turn off 10, turn on 11
    // experiment with delay and looping
    // Is there a timer I can use? Can I set up a periodic interrupt?

    ldr r0,=0x3f200000
    mov r1,#1
    lsl r1,#18  // 6 * 3
    str r1,[r0,#4] // GPIO 16

    // Enable GPIO 9
    mov r1,#1
    lsl r1,#27 // 9 * 3
    str r1,[r0,#0] // 0th set of ten GPIO pins
 
    // Enable GPIO 10
    mov r1,#1
    lsl r1,#0 // 0 * 3
    str r1,[r0,#4] // 1th set of ten GPIO pins
 
    // Enable GPIO 11
    mov r1,#1
    lsl r1,#3 // 1 * 3
    str r1,[r0,#4] // 1th set of ten GPIO pins

    // Turn on GPIO 9
    mov r1,#1
    lsl r1,#9
    str r1,[r0,#40]
 
    // Turn off GPIO 10
    mov r1,#1
    lsl r1,#10
    str r1,[r0,#28]
 
    // Turn on GPIO 11
    mov r1,#1
    lsl r1,#11
    str r1,[r0,#40]
 
	// Call kernel_main
	ldr r3, =kernel_main
	blx r3
 
	// halt
halt:
	wfe
	b halt

