kernel.img: gpio10.s
	as -arch arm -o $@ $<

