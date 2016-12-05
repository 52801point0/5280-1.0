source = gpio10.s

kernel = kernel.img
linker_script = linker.ld
elf = kernel.elf

all: $(kernel)

$(kernel): boot.o kernel.o $(linker_script) Makefile
	gcc -T $(linker_script) -o $(elf) -ffreestanding -nostdlib boot.o kernel.o
	objcopy $(elf) -O binary $@
	rm -fv $(elf)

kernel.o: kernel.c Makefile
	cc -fpic -ffreestanding -std=gnu99 -Wall -Wextra -o $@ -c $<

boot.o: boot.s Makefile
	as -o $@ -c $<

vi:
	vi $(source)

kernel:
	vi kernel.c

boot:
	vi boot.s

clean:
	rm -fv kernel.img *.o *.elf


