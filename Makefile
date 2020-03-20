.PHONY: all clean

all: first

first:
	nesasm first.asm

clean:
	rm *.nes
	rm *.cdl
	rm *.deb
	rm *.fns