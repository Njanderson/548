# Ariane

## Download and build

* Run `make target=ariane`

Ariane is a 6-stage, single issue, in-order CPU which implements the 64-bit
RISC-V instruction set. The goal of this step is to download the
RTL-implementation and generate a binary for simulation.

## Test

### [hello-world](https://bitbucket.org/taylor-bsg/cse548-18sp-hw/src/master/hw1/src/hello.c)

* Build and run `make target=run_c`
* Disassemble binary by `make target=riscv_dasm`
    * Objdump file located at `./out/hello.riscv.dasm`
