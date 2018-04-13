# Profile Ariane

In this homework, we are going to accomplish


# Setup

1. Lets rebuild the Docker image again
    * `cd ../setup`
	* `make`
	
2. Download, build, and run [riscv-tests](https://github.com/riscv/riscv-tests)
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
| spmv          | FAIL    |
| mm            | FAIL    |
| mt-matmul     | FAIL    |
| mt-vvadd      | FAIL    |

# Tips

1. Ariane top now is located at `src/ariane.sv` or [ariane.sv](https://bitbucket.org/taylor-bsg/cse548-18sp-hw/src/master/hw1/src/ariane.sv)
2. After building benchmarks or `make target=build_benchmark`, compiled benchmarks are located at `./out/benchmark`
    * .riscv files are binaries and .dump files are disassemble binary
3. After running benchmarks or `make target=run_benchmark`, traces are located at `./out` folder under the .trace.dasm file extension
    * This trace file contains the retired instructions in the processor together with cycles(c) and program counter(pc)
    * This trace is generated in [ariane.sv](https://bitbucket.org/taylor-bsg/cse548-18sp-hw/src/master/hw1/src/ariane.sv). Open file and search for `$fwrite`

# Turnin using
