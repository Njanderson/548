# Ariane

## Download and build

* Run `make target=ariane`

Ariane is a 6-stage, single issue, in-order CPU which implements the 64-bit
RISC-V instruction set. The goal of this step is to download the
RTL-implementation and generate a binary for simulation.

## Test

### Download, build, and run [riscv-tests](https://github.com/riscv/riscv-tests)

* Download and build riscv-tests by `make target=build_benchmark`
* Run all benchmarks (except spmv, mm, mt-matmul, and mt-vvadd) by `make target=run_benchmark`

| Benchmark     | Status  |
| ------------- | ------- |
| median        | PASS    |
| dhrystone     | PASS    |
| multiply      | PASS    |
| pmp           | PASS    |
| towers        | PASS    |
| qsort         | PASS    |
| rsort         | PASS    |
| vvadd         | PASS    |
|---------------|---------|
| spmv          | FAIL    |
| mm            | FAIL    |
| mt-matmul     | FAIL    |
| mt-vvadd      | FAIL    |

### Build and run a simple [hello-world](https://bitbucket.org/taylor-bsg/cse548-18sp-hw/src/master/hw1/src/hello.c)

* Build `make target=build_hello`
* Run `make target=run_hello`
* Disassemble binary by `make target=riscv_dasm`
    * Objdump file located at `./out/hello.riscv.dasm`
