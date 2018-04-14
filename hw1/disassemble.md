# Disassembling your RISC-V binaries.

* The command for disassembling binaries is `make target=riscv_dasm`
* Look for the variable `dasm_name` to define the binary to be disassembled
* The binary should be located by default in `./out` folder but you can change that
* Here is the Makefile code that disassembles RISC-V binaries
* This code is already in [Makefile](https://bitbucket.org/taylor-bsg/cse548-18sp-hw/src/master/hw1/Makefile)

```
dasm_name = hello

riscv_dasm: $(out_dir)/$(dasm_name).riscv.dasm

$(out_dir)/%.riscv.dasm: $(out_dir)/%.riscv
	$(OBJDUMP) --disassemble-all --disassemble-zeroes --section=.text --section=.data --section=.bss $< > $@
```
