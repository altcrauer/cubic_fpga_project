Notes about design

1.  You must change MAXIMUM to MINIMUM for current rating on ddr pins or memory
will get too hot

2.  sopc2dts
sopc2dts --input kernel.sopcinfo --output kernel.dts --board kernel_board_info.xml

3.  put sof in epcs
sof2flash --input=ddr2.sof --output=sof.flash --epcs --verbose --offset=0x0
nios2-flash-programmer --debug --base=0x00000400 --epcs sof.flash --mmu

4.  put kernel image in epcs
elf2flash --input=/home/crauer/Desktop/git/linux-socfpga/vmlinux --output=linux.flash --after=sof.flash --epcs --boot=$SOPC_KIT_NIOS2/components/altera_nios2/boot_loader_epcs.srec
nios2-flash-programmer --debug --base=0x00000400 --epcs --mmu linux.flash
