# Profile Ariane

In this homework, we are going to figure out how good an implementation of an in-order core Ariane is,
and also identify opportunities for optimization, by writing a profiler.

To write the profiler, we will insert instrumentation code in SystemVerilog at the top level in order to profile Ariane and find sources of inefficiency (stalls).
You will first perform this on a set of hand-written tests that you design which will help you debug your code and understand
the Ariane pipeline better.

Then after this is done, you will run the profiler on the benchmark suite available in [riscv-tests] (See https://github.com/riscv/riscv-tests).

* Here is a set of starter stalls to look at:

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

Attributing a stall to a particular source requires deep thought about the processor pipeline.
Some stalls will freeze other parts of the pipeline and prevent them from addressing their own stalls. For example, in the traditional 5-stage pipeline, a data cache stall will freeze the front end (fetch unit) of the processor
preventing it from filling empty pipeline stages. In this case, when attributing a stall, we should prefer to attribute a stall to the data cache over the front end of the pipeline,
since the data cache may be freezing the front end and preventing it from doing work.

We loosely attribute the sources of stalls in the Ariane pipeline to being frontend stalls, middle-end stalls, and backend stalls. Front end stalls are those associated with fetching instructions; 
e.g. branch mispredict latencies, instruction cache misses, i-tlb misses, etc. Middle-end stalls are related to the control logic that schedules instructions. Back-end stalls are related to delays in actually executing instructions; 
i.e. a data cache stall, or a stall due to an iterative divider being busy.

In Ariane, the front end and the backend can work in parallel, so a backend cache stall does not necessarily prevent the front end from advancing. So we must build our own
prioritization map for stalls in Ariane. (Of course, if both caches are missing and there is contention on the external memory system, that could be another such dependence creeping in. 
Perhaps we need some kind of independent DRAM contention stall counter? =P )

Moreover, we must be aware that in advanced pipelines (such as Ariane), the pipeline may overlap stalls that are happening from different instructions in time. 
This forces us to abandon the notion that if we reduce the number of a particular type of stall, that we will necessarily see a decrease in total stalls. 
Optimizing the pipeline or the code to eliminate one class of stall may just cause other stalls to be unmasked.

Below we have written some pseudo code for what we think the stall-attribution calculation should be. But this is just a starting place -- you will need to examine this and make it better!

```
if (no-valid-instruction-id-stage) // frontend stall
    stall-reason = id-stall
else if (no-space-in-scoreboard) // middle-end stall
    stall-reason = sb-stall
else if (unresolved-branch) // middle-end stall
    stall-reason = br-stall
else if (exception || instruction-that-not-use-functional-units) // not-a-stall-but-we-like-to-count-it
    stall-reason = exfu
else if (unavailable-operand-load-store-unit) // backend stall
    stall-reason = load-store-operand-stall    
else if (unavailable-operand) // backend stall
    stall-reason = operand-stall
else if (functional-unit-load-store-busy && uses fu-load-store) // backend stall
    stall-reason = fu-load-store-busy-stall
else if (functional-unit-busy) // backend stall
    stall-reason = fu-unit-busy-stall
else if (waw-hazard) // backend stall
    stall-reason = waw-stall
```

## Infrastructure

What we're asking you to do is not particularly easy, but hey, you're taking a UW grad quals class, and when you complete this assignment, you will understand Ariane very well, and the Ariane core will
be yours to use and modify for any project you undertake. Strap on those superpowers!

To speed you on your way, we're going to give some protips and infrastructure, based on Prof. Taylor and Super TA Luis's experience hacking processors and SystemVerilog:

1. Ariane top file is now located at `src/ariane.sv` or [ariane.sv](https://bitbucket.org/taylor-bsg/cse548-18sp-hw/src/master/hw1/src/ariane.sv)
2. [Compile and run c code on Ariane](c.md)
3. [Compile and run benchmarks on Ariane](benchmark.md)

    This will allow you to run some larger test programs, and also to run the final phase of the assignment.

4. [Profile Ariane with a Verilog Tracer](tracer.md)

    This allows you to run some code and see on what cycles instruction commits (in the very last stage of execution!) and what the PC and dissasembly of the instruction is. 
    This a starting place for understanding the behavior of the processor,
    before you have written any instrumentation coe, and will help you hunt for stall conditions to incorporate in your profiler. The commit stage is nice because it is very
    concrete and easy to observe. But the challenge is, it is a little too late in the processor to help you say *why* the processor did not commit on a particular cycle. The stall reason could have
    happened a hundred cycles ago.

5. Make commands for disassembling your RISC-V binaries.
6. [Compile and run assembly code on Ariane](assembly.md)
7. [RISC-V reference card](https://www.cl.cam.ac.uk/teaching/1617/ECAD+Arch/files/docs/RISCVGreenCardv8-20151013.pdf)
8. [RISC-V Assembly Programmer's Manual](https://github.com/riscv/riscv-asm-manual/blob/master/riscv-asm.md)

    For writing your test programs to start isolating and reproducing stalls. You can observe with the tracer program delays in commits,
    and insert SystemVerilog at the top level to start counting stalls.

    After you have looked at some example traces of commit, and get an intuition of some of the sources of stalls, and 

## Setup

Rebuild the Docker image

1. Go to [setup](https://bitbucket.org/taylor-bsg/cse548-18sp-hw/src/master/setup/) folder
2. Run `make`


## Turnin using Canvas

* The modified version of the [Ariane](https://bitbucket.org/taylor-bsg/cse548-18sp-hw/src/master/hw1/src/ariane.sv) top file, containing your
instrumentation code. See the [Verilog Tracer](tracer.md) code for an example. 

* You should have an explanation of the stall conditions you detect and explain the rules you developed for stall attribution, and justify them.

* The assembly tests for testing individual stall conditions. Place a comment at the top of the test indicating which stall condition you are testing. You should also explain the rational for how the code executes that particular stall condition.

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
