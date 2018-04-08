# Ariane

## Download and build

* Run `make target=ariane`

Ariane is a 6-stage, single issue, in-order CPU which implements the 64-bit
RISC-V instruction set. The goal of this step is to download the
RTL-implementation and generate a binary for simulation.

## Test

### Download, build, and run [riscv-tests](https://github.com/riscv/riscv-tests)

* Download and build riscv-tests by `make target=rvtests`
* Run a test by `make target=run_test`
    * Change a benchmark by changing the [test](https://bitbucket.org/taylor-bsg/cse548-18sp-hw/src/master/hw1/Makefile?fileviewer=file-view-default#Makefile-3) variable
* Other compiled benchmark tests can be found in `ls ./out/rvtests/share/riscv-tests/benchmarks`
* Other compiled isa tests can be found in `ls ./out/rvtests/share/riscv-tests/isa`

| Benchmark     | Status  |
| ------------- | ------- |
| median        | PASS    |
| mm            | FAIL    |
| dhrystone     | PASS    |
| mt-matmul     | FAIL    |
| mt-vvadd      | FAIL    |
| multiply      | PASS    |
| pmp           | PASS    |
| towers        | PASS    |
| qsort         | PASS    |
| rsort         | PASS    |
| spmv          | FAIL    |
| vvadd         | PASS    |

### Build and run a simple [hello-world](https://bitbucket.org/taylor-bsg/cse548-18sp-hw/src/master/hw1/src/hello.c)
    
* Build `make target=hello`
* Run `make target=run_hello`
* Disassemble binary by `make target=riscv_dasm`
    * Objdump file located at `./out/hello.riscv.dasm`
