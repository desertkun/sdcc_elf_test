# SDCC Z80 ELF example

How to use:

1. Install [SDCC with elf support](https://github.com/desertkun/sdcc)
2. `make`
3. Open in [Fuse with gdbserver support](https://sourceforge.net/u/desertkun/fuse/ci/gdbserver/tree/)
4. `z80-elf-gdb hello.elf -ex "target remote :1337"`