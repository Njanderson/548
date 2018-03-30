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
    * The line-numbers or code-block backing up your answer, for example:
        * What is the implementation of the fluffaluffagus?
            * The fluffaluffagus employs lungs with high-absorptive oxygen absorbers ([code](https://github.com/pulp-platform/ariane/blob/master/src/ariane.sv#L653)) for improved O2 processing in higher elevations.
            * Fur is used to maintain thermal stability  ([code](https://github.com/pulp-platform/ariane/blob/master/src/ariane.sv#L651). Large feet are implemented ([code](https://github.com/pulp-platform/ariane/blob/master/src/ariane.sv#L651) in order to maximize mobility after snowfall.
* You will submit a pdf file containing the questions and answers as shown [here](https://bitbucket.org/taylor-bsg/cse548-18sp-hw/src/master/hw1/hw1a_john_doe.pdf)
* You will create the pdf with google-docs and use the link feature described [here](https://support.google.com/docs/answer/45893?co=GENIE.Platform%3DDesktop&hl=en)
* Where are the implementation files for the processor?
    * [Source](https://github.com/pulp-platform/ariane/tree/master/src)
    * [Include](https://github.com/pulp-platform/ariane/tree/master/include)
* Ask questions if you don't understand something
* You can pair in group of two for the assignment
* Add the name of the group members to the document

## Questions

1. How many bits wide is the datapath?
2. What are the latencies and occupancies of the functional units?
3. What is the BTB number of entries, replacement algorithm, hashing algorithm, and branch taken penalty
4. Does the system have any prefetchers? If so, then what is the algorithm? What patterns can it prefetch and can it not prefetch?
5. What is the iTLB and dTLB # of entries, hashing algorithm, latency, and replacement algorithm (is the system virtually indexed, physically tag, or something else?)
6. What are the L1 data and instruction cache sizes, block size, replacement policies, associativity and latencies. Any additional latency for byte accesses?
7. Are the caches write-thru or write-back? How many words are written into the cache at a time during a miss? What information does it track about a line? Is it write-allocate?
8. Can the L1 pipeline do unaligned loads? How does it accomplish this? Does it need to read the data memory multiple times, and what happens to the pipeline?
9. How does the pipeline handle a load to the same address as an immediately preceding store instruction?
10. Are the L1 caches non-blocking, and if so, under what conditions is it non-blocking (i.e. how many simultaneous misses, and requirements on addresses?)
11.  If the L1 cache is non-blocking, how does it handle RAW hazards through memory?
12. What is the Branch predictor algorithm, geometric of table, replacement strategy, mispredict latency
13. Is the divider iterative or pipelined? What is the latency and occupancy? Can other instructions execute while it is running?
14. Is the multiplier iterative or pipelined? What is the latency and occupancy? Can other instructions execute while it is running?
15. Is the TLB multi-level?
16. Is it possible to execute more than one instruction at a time at the same time (i.e. superscalar)?
17. What performance counters available? 
18. A TLB miss is handled via software or hardware in this processor? Describe how it works?
19. How many bits wide are virtual and physical addresses in the system
20. How does the processor connect to DRAM?
21. What important microarchitectural questions did we miss, and what is the answer?

## Turnin using [canvas](https://canvas.uw.edu/courses/1199347/assignments/4191655)