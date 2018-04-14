# Profile Ariane

In this homework, we are going to profile Ariane and found sources of inefficiencies (stalls)
for the benchmark suite provided in [riscv-tests](https://github.com/riscv/riscv-tests)

## Problem

## Setup

Rebuild the Docker image again
    * `cd ../setup`
	* `make`

## Important information

1. Ariane top file is now located at `src/ariane.sv` or [ariane.sv](https://bitbucket.org/taylor-bsg/cse548-18sp-hw/src/master/hw1/src/ariane.sv)
2. [Verilog tracer](verilog_tracer.md)

## Tips

2. After building benchmarks or `make target=build_benchmark`, compiled benchmarks are located at `./out/benchmark`
    * .riscv files are binaries and .dump files are disassemble binary
3. After running benchmarks or `make target=run_benchmark`, traces are located at `./out` folder under the .trace.dasm file extension
    * This trace file contains the retired instructions in the processor together with cycles(c) and program counter(pc)
    * This trace is generated in [ariane.sv](https://bitbucket.org/taylor-bsg/cse548-18sp-hw/src/master/hw1/src/ariane.sv). Open it and search for `$fwrite`

## Turnin using
