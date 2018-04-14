# Profile Ariane

In this homework, we are going to profile Ariane and find sources of inefficiencies (stalls)
for the benchmark suite available in [riscv-tests](https://github.com/riscv/riscv-tests)

## Turnin using Canvas

* The modified version of the [Ariane](https://bitbucket.org/taylor-bsg/cse548-18sp-hw/src/master/hw1/src/ariane.sv) top file, containing the
code for the improved [Verilog Tracer](tracer.md)

* A ASCII file with a table containing the following information obtained with the new version of the Verilog Tracer

| Benchmark | event-count-1 | event-count-2 | event-count-..| event-count-N |
|-----------|---------------|---------------|---------------|---------------|
| median    | | | |
| dhrystone | | | |
| multiply  | | | |
| towers    | | | |
| qsort     | | | |
| rsort     | | | |
| vvadd     | | | |

* The events we are interested in are:

    * Global
        + The number of committed instructions (table-name:ci)
        + The number of cycles without committing instructions (table-name:no-ci)
        + The total number of cycles (table-name:total) 

        
    * Frontend stalls and efficiency:
        + The number of stalls due to no-valid instructions in the instruction decode (ID) stage (table-name:id-stall)
        + The number of mispredicts for every 1000 committed instructions (miss per kilo insturctions) (table-name:mpki) 
        
    * Middle-end stalls:
        + The number of stalls due to no-space in the scoreboard (NR_SB_ENTRIES) (table-name:sb-stall)
        + The number of stalls due to an unresolved branch (table-name:br-stall)
        + The number of exceptions or instructions-that-not-use-functional-units (table-name:exfu)


    * Backend stalls:
        + The number of stalls due to unavailable operands in the issue-stage (table-name:operand-stall)
        + The number of stalls due to target functional unit busy (table-name:fu-busy-stall)
        + The number of stalls due to WAW hazerds (table-name:waw-stall)

Multiple events related to frontend and backend stalls can happen at the same time, therefore we would want to count them
properly. For example, a frontend stall has precedence over backend stalls. Therefore, we created a pseudocode that
will allow you to make this count right.

```
if (no-valid-instruction-id-stage) // frontend stall
{
    stall-reason = id-stall
else if (no-space-in-scoreboard) // frontend stall
    stall-reason = sb-stall
else if (unresolved-branch) // frontend stall
    stall-reason = br-stall
else if (exception || instruction-that-not-use-functional-units) // not-a-stall-but-we-like-to-count-it
    stall-reason = exfu
}
else
{
if (unavailble-operand) // backend stall
    stall-reason = operand-stall
else if (functional-unit-busy) // backend stall
    stall-reason = fu-busy-stall
else if (waw-hazard) // backend stall
    stall-reason = waw-stall
}
```

## Setup

Rebuild the Docker image

1. Go to [setup](https://bitbucket.org/taylor-bsg/cse548-18sp-hw/src/master/setup/) folder
2. Run `make`

## Helpers for the homework

1. Ariane top file is now located at `src/ariane.sv` or [ariane.sv](https://bitbucket.org/taylor-bsg/cse548-18sp-hw/src/master/hw1/src/ariane.sv)
2. [Profile Ariane with a Verilog Tracer](tracer.md)
3. [Compile and run assembly code on Ariane](assembly.md)
4. [Compile and run c code on Ariane](c.md)
5. [Compile and run benchmarks on Ariane](benchmark.md)
