# Profile Ariane

In this homework, we are going to figure out how good an implementation of an in-order core Ariane is,
and also identify opportunities for optimization.

We will insert instrumentation code in SystemVerilog at the top level in order to profile Ariane and find sources of inefficiency (stalls).
You will first perform this on a set of hand-written tests that you design which will help you debug your code and understand
the Ariane pipeline better.

Then after this is done, you will run the profiler on the benchmark suite available in [riscv-tests] (See https://github.com/riscv/riscv-tests).

## Turnin using Canvas

* The modified version of the [Ariane](https://bitbucket.org/taylor-bsg/cse548-18sp-hw/src/master/hw1/src/ariane.sv) top file, containing your
instrumentation code. See the [Verilog Tracer](tracer.md) code for an example. You will

* The assembly tests for testing individual stall conditions. Place a comment at the top of the test indicating which stall condition you are testing. You should also explain the rational for the particular stall condition.

* An ASCII file with a table containing the following information obtained with your instrumentation code.

| Benchmark | event-count-1 | event-count-2 | event-count-..| event-count-N |
|-----------|---------------|---------------|---------------|---------------|
| test_1    | | | |
| test_2    | | | |
| test_3    | | | |
| test_4    | | | |
| test_5    | | | |
| test_6    | | | |
| test_..   | | | |
| test_N    | | | |
| median    | | | |
| dhrystone | | | |
| multiply  | | | |
| towers    | | | |
| qsort     | | | |
| rsort     | | | |
| vvadd     | | | |

This table will contain the data for both your tests and for the benchmarks. Each type of stall should have a specific test that exercises that stall, and it should be evident from the above data that you have written a good test that
really hammers on this stall condition!

* The events we are interested in are:

    * Global
        + The total number of cycles (table-name:total) 
        + The number of committed instructions (table-name:ci)
        + The number of cycles without committing instructions (table-name:no-ci)
    * Frontend stalls and efficiency:
        + The number of stalls due to no-valid instructions in the instruction decode (ID) stage (table-name:frontend-stall)
        + The number of mispredicts for every 1000 committed instructions (miss per kilo insturctions) (table-name:mpki)
    * Middle-end stalls:
        + The number of stalls due to no-space in the scoreboard (NR_SB_ENTRIES) (table-name:sb-stall)
        + The number of stalls due to an unresolved branch (table-name:br-stall)
        + The number of exceptions or instructions-that-dont-use-functional-units (table-name:exfu)
    * Backend stalls:
        + The number of stalls due to unavailable operands in the issue-stage (table-name:operand-stall)
        + The number of stalls due to functional unit <name> busy (table-name:fu-<name>-busy-stall)
        + The number of stalls due to WAW hazerds (table-name:waw-stall)

Multiple events related to frontend and backend stalls can happen at the same time, therefore we would want to count them
properly. For example, a frontend stall has precedence over backend stalls. Therefore, we created a pseudocode that
will allow you to make this count right.

```
if (no-valid-instruction-id-stage) // frontend stall
    stall-reason = id-stall
else if (no-space-in-scoreboard) // middle-end stall
    stall-reason = sb-stall
else if (unresolved-branch) // middle-end stall
    stall-reason = br-stall
else if (exception || instruction-that-not-use-functional-units) // not-a-stall-but-we-like-to-count-it
    stall-reason = exfu
else if (unavailable-operand) // backend stall
    stall-reason = operand-stall
else if (functional-unit-A-busy && uses fu-A) // backend stall
    stall-reason = fu-A-busy-stall
else if (functional-unit-B-busy && uses fu-B) // backend stall
    stall-reason = fu-B-busy-stall
else if (functional-unit-..-busy && uses fu-C ) // backend stall
    stall-reason = fu-..-busy-stall
else if (waw-hazard) // backend stall
    stall-reason = waw-stall
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
