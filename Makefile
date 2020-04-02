.PHONY: all clean

all: first.nes second.nes third.nes fourth.nes

first.nes: first.asm
	nesasm first.asm

second.nes: second.asm
	nesasm second.asm

third.nes: third.asm
	nesasm third.asm

fourth.nes: fourth.asm
	nesasm fourth.asm

clean:
	rm *.nes
	rm *.cdl
	rm *.deb
	rm *.fns