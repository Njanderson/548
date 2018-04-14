# Profile Ariane

In this homework, we are going to profile Ariane and find sources of inefficiencies (stalls)
for the benchmark suite provided by [riscv-tests](https://github.com/riscv/riscv-tests)

## Turnin using Canvas

1. The modified version of the [Ariane](https://bitbucket.org/taylor-bsg/cse548-18sp-hw/src/master/hw1/src/ariane.sv) top file, containing the
code for the improved [Verilog Tracer](tracer.md)

2. A table in a pdf file containing the following information obtained with the new version of the Verilog Tracer

| Benchmark | reason-1 | reason-2 | reason-N |
|-----------|----------|----------|----------|
| median    | | | |
| dhrystone | | | |
| multiply  | | | |
| towers    | | | |
| qsort     | | | |
| rsort     | | | |
| vvadd     | | | |

## Setup

Rebuild the Docker image

## Helpers for the homework

1. Ariane top file is now located at `src/ariane.sv` or [ariane.sv](https://bitbucket.org/taylor-bsg/cse548-18sp-hw/src/master/hw1/src/ariane.sv)
2. [Profile Ariane with a Verilog Tracer](tracer.md)
3. [Compile and run assembly code on Ariane](assembly.md)
4. [Compile and run c code on Ariane](c.md)
5. [Compile and run benchmarks on Ariane](benchmark.md)
