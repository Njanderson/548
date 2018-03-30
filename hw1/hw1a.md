# Ariane Scavenger Hunt

In this homework, we are going to accomplish three goals:

1. First, we're going to swap back in the undergraduate architecture material, with maybe a few new twists.
2. Second, we're going to get familiar with a modern implementation of one of the first open-source Linux capable cores to exist: Ariane.
   This thing has caches, virtual memory, TLBs, protection, the whole kitchen sink! Well, no FPU yet. =)
3. Third, we're going to build your Verilog reading skills

In this homework, we will help you out in these goals by leading you on a scavenger hunt. The awesome thing about Ariane
is that it is only about 15K lines of code, and yet it is complete. And the code is quite simply and straight-forwardly written.
So we are going to ask a bunch of questions about Ariane, with the goal of being able to figure out how the Ariane
solved the major decision designs of implementing an in-order RISC-V core.

## Tips for the homework

* You will get a question about a microarchitectural feature of the processor
* Your answer will consist in the following two items:
    * Your answer in plain text
    * The line-number or code-block backing up your answer, for example:
        * Does the processor has an instruction cache?
            * Yes, [code](https://github.com/pulp-platform/ariane/blob/master/src/ariane.sv#L653) (this would be a line-number example)
        * What performance events related to the L1-cache are supported?
            * i-cache miss and d-cache miss [code](https://github.com/pulp-platform/ariane/blob/master/src/perf_counters.sv#L32-L33) (this would be a code-block example)
* You will submit a pdf file containing the questions and answers as shown [here](https://github.com/vegaluisjose/cse548-18sp-hw/blob/master/hw1/hw1a_john_doe.pdf)
* You will create the pdf with google-docs and use the link feature described [here](https://support.google.com/docs/answer/45893?co=GENIE.Platform%3DDesktop&hl=en)
* Where are the implementation files for the processor?
    * [Source](https://github.com/pulp-platform/ariane/tree/master/src)
    * [Include](https://github.com/pulp-platform/ariane/tree/master/include)
* Ask questions if you don't understand something


## Questions

1. How many bits wide is the datapath?
2. What are the latencies and occupancies of the functional units?
3. What is the BTB number of entries, replacement algorithm, hashing algorithm, and branch taken penalty
4. Does the system have any prefetchers? If so, then what is the algorithm? What patterns can it prefetch and can it not prefetch?
5. What is the iTLB and dTLB # of entries, hashing algorithm, latency, and replacement algorithm (is the system virtually indexed, physically tag, or something else?)
6. What are the L1 data and instruction cache sizes, block size, replacement policies, associativity and latencies. Any additional latency for byte accesses?
6a. Are the caches write-thru or write-back? How many words are written into the cache at a time during a miss? What information does it track about a line? Is it write-allocate?
7. Can the L1 pipeline do unaligned loads? How does it accomplish this? Does it need to read the data memory multiple times, and what happens to the pipeline?
8. How does the pipeline handle a load to the same address as an immediately preceding store instruction?
9. Are the L1 caches non-blocking, and if so, under what conditions is it non-blocking (i.e. how many simultaneous misses, and requirements on addresses?)
10.  If the L1 cache is non-blocking, how does it handle RAW hazards through memory?
11. What is the Branch predictor algorithm, geometric of table, replacement strategy, mispredict latency
12. Is the divider iterative or pipelined? What is the latency and occupancy? Can other instructions execute while it is running?
13. Is the multiplier iterative or pipelined? What is the latency and occupancy? Can other instructions execute while it is running?
14. Is the TLB multi-level?
15. Is it possible to execute more than one instruction at a time at the same time (i.e. superscalar)?
16. What performance counters available? 
17. A TLB miss is handled via software or hardware in this processor? Describe how it works?
18. How many bits wide are virtual and physical addresses in the system
19. How does the processor connect to DRAM?
20. What important questions did we miss?
