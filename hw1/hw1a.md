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
2. List the functional units available?
3. List the ALU instructions available?
4. How many execution cycles for an ALU operation?
5. Does this implementation support multiplication? if so, how many execution cycles for multiplication?
6. Does this implementation support division? if so, how many execution cycles for division?
7. Does this implementation support floating point?
8. How many entries for the instruction Translation Lookaside Buffer (TLB)?
9. How many entries for the data TLB?
10. What is the TLB replacement algorithm?
11. How many levels has the TLB?
12. How many entries available for the Branch Target Buffer (BTB)?
13. What branch prediction algorithm is used?
14. Is it possible to execute more than one fuctional unit at the same time?
15. List the performance counters available?
16. What is the size in bytes of the instruction cache?
17. What is the associativity of the instruction cache?
18. What is the total size in bytes of the data-memory used in the data cache?
19. What is the total size in bytes of the tag-memory used in the data cache?
20. Is the data cache blocking or non-blocking?
21. A TLB miss is handled via software or hardware in this processor?
22. How many bits wide is the address of the virtual memory system?
