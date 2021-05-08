SOURCES=$(wildcard src/*.c)
ASM_SOURCES=$(wildcard src/*.s)
OBJECTS=$(SOURCES:.c=.rel)
ASM_OBJECTS=$(ASM_SOURCES:.s=.s.rel)
EXECUTABLE=hello
JUST_PRINT := $(findstring n,$(MAKEFLAGS))

ifneq (,$(JUST_PRINT))
PHONY_OBJS := yes
CC = gcc
else
CFLAGS = -mz80 --out-fmt-elf --debug
LDFLAGS = -l z80 --no-std-crt0 --code-loc 0x8100 --data-loc 0x8020 --stack-loc 0xffff --debug
BINTAP	= bintap
ASFLAGS = -sdcc -z80
CC = sdcc
AS = z80-elf-as
LD = sdcc
OBJCOPY = z80-elf-objcopy
endif

ifeq ($(PHONY_OBJS),yes)
.PHONY: $(EXECUTABLE)

%.rel: FORCE
.PHONY: FORCE
FORCE:
endif

all: $(SOURCES) $(EXECUTABLE).tap

clean:
	rm -f *.bin
	rm -f *.map
	rm -f src/*.o
	rm -f src/*.rel
	rm -f src/*.asm
	rm -f src/*.sym
	rm -f src/*.lst
	rm -f $(EXECUTABLE)
	rm -f $(EXECUTABLE).*

.PHONY: clean

$(EXECUTABLE).elf: $(ASM_OBJECTS) $(OBJECTS)
	$(LD) --out-fmt-elf $(LDFLAGS) $(ASM_OBJECTS) $(OBJECTS) -o $@

$(EXECUTABLE).bin: $(EXECUTABLE).elf
	$(OBJCOPY) -O binary -S $(EXECUTABLE).elf $(EXECUTABLE).bin

$(EXECUTABLE).tap: $(EXECUTABLE).bin
	$(BINTAP) -t 'Hello, Z80' -b --bc 7 --pc 7 --ic 0 -o $@ $<

%.rel: %.c
	$(CC) $(CFLAGS) -c $< -o $@

%.s.rel: %.s
	sdasz80 -l -s -o $@ $<

