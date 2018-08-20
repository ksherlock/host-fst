
LD=mpw linkIIgs
ASM=mpw asmIIgs
#ASMFLAGS=-d DEBUG_S16 -d DebugSymbols
ASMFLAGS=-case on -l
LDFLAGS=


all : host.driver boot.driver host.fst boot.sys atinit

host.fst : host.fst.o
	$(LD) -t \$$BD -at \$$0000 $< -o $@

# aux type (-at)
# $8000 = inactive
# $0100 = gs/os driver
# $00xx = number of devices supported (should match dib)
host.driver : host.driver.o
	$(LD) -t \$$BB -at \$$0101 $< -o $@

boot.driver : boot.driver.o
	$(LD) -t \$$BB -at \$$0181 $< -o $@

# -d BootDriver must come after -case on
host.driver.o : host.driver.aii gsos.equ
boot.driver.o : host.driver.aii gsos.equ
	$(ASM) $(ASMFLAGS) -d BootDriver $< -o $@



host.fst.o : host.fst.aii gsos.equ fst.equ records.equ fst.macros

boot: boot.o
	$(LD) $< -o $@

boot.sys: boot
	mpw makebiniigs -p -s -t \$$FF $< -o $@ 


atinit: atinit.omf
	mpw makebiniigs -p -s -t \$$e2 $< -o $@


atinit.omf: atinit.o
	$(LD) -x $^ -o $@


.PHONY : clean
clean :
	$(RM) -- host.fst host.driver boot.driver boot.sys boot atinit atinit.omf *.o

%.o : %.aii
	$(ASM) $(ASMFLAGS) $< -o $@



