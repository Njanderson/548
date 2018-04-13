# Profile Ariane

In this homework, we are going to accomplish three goals:


# Setup

1. 

## How to download, build, and run [riscv-tests](https://github.com/riscv/riscv-tests)

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
