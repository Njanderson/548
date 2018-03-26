# hw1

## Setting up [Ariane](https://github.com/pulp-platform/ariane)

Ariane is a 6-stage, single issue, in-order CPU which implements the 64-bit
RISC-V instruction set. The goal of this step is to download the
RTL-implementation and generate a binary for simulation.

* Build `make target=ariane"

## Building and running [riscv-tests](https://github.com/riscv/riscv-tests) for Ariane

* Build riscv-tests by `make target=rvtests`
* Run median by `make target=run_test test=benchmarks/median.riscv`
* Run vvadd by `make target=run_test test=benchmarks/vvadd.riscv`
* Run rv64ui-p-add by `make target=run_test test=isa/rv64ui-p-add`
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
| spmv          | PASS    |
| vvadd         | PASS    |

## Running hello-world in Ariane
    
    * Build `make target=hello`
    * Run `make target=run_hello`