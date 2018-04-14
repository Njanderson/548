# Compile and run assembly code on Ariane

* Build and run [simple.S](https://bitbucket.org/taylor-bsg/cse548-18sp-hw/src/master/hw1/src/simple.S) by `make target=run_asm`

In case you want to compile another asm-source-file:

    1. Place file in the `src` folder
    2. Open [Makefile](https://bitbucket.org/taylor-bsg/cse548-18sp-hw/src/master/hw1/Makefile)
    3. Edit the asm_name variable as `asm_name=<new-file-name>`
    4. Run `make target=run_asm`

Writing assembly programs can be useful to understand low level details of the processor. For example, the idea of `simple.S` is
adding two numbers:
	
```
	lui a0, 0xdead // help identify start of block
	li a1, 23
	li a2, 10
	add a3, a1, a2
	lui a0, 0xbeef // help identify end of block
```

Load upper immediate (lui) instructions are added for identify this code block in the execution of the final binary. A commonly used
pattern for these tasks is `0xdeadbeef`. The final binary will have processor-bookkeeping code before and after this tiny program.
For example, the total instructions committed by this assembly program is:

```
cycle:00000265 pc:0x0000000080000000 instruction:0x04c0006f j       pc + 0x4c
cycle:00000275 pc:0x000000008000004c instruction:0xf1402573 csrr    a0, mhartid
cycle:00000279 pc:0x0000000080000050 instruction:0x00051063 bnez    a0, pc + 0
cycle:00000282 pc:0x0000000080000054 instruction:0x00000297 auipc   t0, 0x0
cycle:00000284 pc:0x0000000080000058 instruction:0x01028293 addi    t0, t0, 16
cycle:00000285 pc:0x000000008000005c instruction:0x30529073 csrw    mtvec, t0
cycle:00000287 pc:0x0000000080000060 instruction:0x18005073 csrwi   satp, 0
cycle:00000295 pc:0x0000000080000064 instruction:0x00000297 auipc   t0, 0x0
cycle:00000297 pc:0x0000000080000068 instruction:0x01c28293 addi    t0, t0, 28
cycle:00000298 pc:0x000000008000006c instruction:0x30529073 csrw    mtvec, t0
cycle:00000300 pc:0x0000000080000070 instruction:0xfff00293 li      t0, -1
cycle:00000314 pc:0x0000000080000080 instruction:0x00000297 auipc   t0, 0x0
cycle:00000316 pc:0x0000000080000084 instruction:0x01828293 addi    t0, t0, 24
cycle:00000317 pc:0x0000000080000088 instruction:0x30529073 csrw    mtvec, t0
cycle:00000319 pc:0x000000008000008c instruction:0x30205073 csrwi   medeleg, 0
cycle:00000321 pc:0x0000000080000090 instruction:0x30305073 csrwi   mideleg, 0
cycle:00000323 pc:0x0000000080000094 instruction:0x30405073 csrwi   mie, 0
cycle:00000324 pc:0x0000000080000098 instruction:0x00000193 li      gp, 0
cycle:00000325 pc:0x000000008000009c instruction:0x00000297 auipc   t0, 0x0
cycle:00000328 pc:0x00000000800000a0 instruction:0xf6828293 addi    t0, t0, -152
cycle:00000331 pc:0x00000000800000a4 instruction:0x30529073 csrw    mtvec, t0
cycle:00000332 pc:0x00000000800000a8 instruction:0x00100513 li      a0, 1
cycle:00000334 pc:0x00000000800000ac instruction:0x01f51513 slli    a0, a0, 31
cycle:00000336 pc:0x00000000800000b0 instruction:0x00055863 bgez    a0, pc + 16
cycle:00000345 pc:0x00000000800000c0 instruction:0x80000297 auipc   t0, 0x80000
cycle:00000348 pc:0x00000000800000c4 instruction:0xf4028293 addi    t0, t0, -192
cycle:00000349 pc:0x00000000800000c8 instruction:0x00028e63 beqz    t0, pc + 28
cycle:00000361 pc:0x00000000800000e4 instruction:0x30005073 csrwi   mstatus, 0
cycle:00000371 pc:0x00000000800000e8 instruction:0x00000297 auipc   t0, 0x0
cycle:00000373 pc:0x00000000800000ec instruction:0x01428293 addi    t0, t0, 20
cycle:00000374 pc:0x00000000800000f0 instruction:0x34129073 csrw    mepc, t0
cycle:00000376 pc:0x00000000800000f4 instruction:0xf1402573 csrr    a0, mhartid
cycle:00000378 pc:0x00000000800000f8 instruction:0x30200073 mret
cycle:00000387 pc:0x00000000800000fc instruction:0x0180006f j       pc + 0x18
cycle:00000396 pc:0x0000000080000114 instruction:0x0dead537 lui     a0, 0xdead
cycle:00000399 pc:0x0000000080000118 instruction:0x01700593 li      a1, 23
cycle:00000400 pc:0x000000008000011c instruction:0x00a00613 li      a2, 10
cycle:00000403 pc:0x0000000080000120 instruction:0x00c586b3 add     a3, a1, a2
cycle:00000406 pc:0x0000000080000124 instruction:0x0beef537 lui     a0, 0xbeef
cycle:00000407 pc:0x0000000080000128 instruction:0x0180006f j       pc + 0x18
cycle:00000419 pc:0x0000000080000140 instruction:0x0ff0000f fence
cycle:00000938 pc:0x0000000080000144 instruction:0x00100193 li      gp, 1
cycle:00000949 pc:0x0000000080000004 instruction:0x34202f73 csrr    t5, mcause
cycle:00000950 pc:0x0000000080000008 instruction:0x00800f93 li      t6, 8
cycle:00000952 pc:0x000000008000000c instruction:0x03ff0a63 beq     t5, t6, pc + 52
cycle:00000960 pc:0x0000000080000040 instruction:0x00001f17 auipc   t5, 0x1
cycle:00000963 pc:0x0000000080000044 instruction:0xfc3f2023 sw      gp, -64(t5)
cycle:00000964 pc:0x0000000080000048 instruction:0xff9ff06f j       pc - 0x8
cycle:00000969 pc:0x0000000080000040 instruction:0x00001f17 auipc   t5, 0x1
cycle:00000972 pc:0x0000000080000044 instruction:0xfc3f2023 sw      gp, -64(t5)
cycle:00000976 pc:0x0000000080000048 instruction:0xff9ff06f j       pc - 0x8
```
