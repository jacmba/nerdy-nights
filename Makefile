.PHONY: all clean

all: first.nes second.nes

first.nes: first.asm
	nesasm first.asm

second.nes: second.asm
	nesasm second.asm

clean:
	rm *.nes
	rm *.cdl
	rm *.deb
	rm *.fns