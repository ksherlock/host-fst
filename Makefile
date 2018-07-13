
LD=mpw linkIIgs
ASM=mpw asmIIgs
#ASMFLAGS=-d DEBUG_S16 -d DebugSymbols
ASMFLAGS=-case on -l
LDFLAGS=


all : host.driver host.fst boot.sys

host.fst : host.fst.o
	$(LD) -t \$$BD -at \$$0000 $< -o $@

# aux type (-at)
# $8000 = inactive
# $0100 = gs/os driver
# $00xx = number of devices supported (should match dib)
host.driver : host.driver.o
	$(LD) -t \$$BB -at \$$0101 $< -o $@

host.driver.o : host.driver.aii gsos.equ

host.fst.o : host.fst.aii gsos.equ fst.equ records.equ fst.macros

boot: boot.o
	$(LD) $< -o $@

boot.sys: boot
	mpw makebiniigs -p $< -o $@ -t \$$FF

.PHONY : clean
clean :
	$(RM) -- host.fst host.driver boot.sys boot *.o

%.o : %.aii
	$(ASM) $(ASMFLAGS) $< -o $@

