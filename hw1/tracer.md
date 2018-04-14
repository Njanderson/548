# Profile Ariane with a Verilog Tracer

This Verilog Tracer is implemented in the new top file [ariane.sv](https://bitbucket.org/taylor-bsg/cse548-18sp-hw/src/master/hw1/src/ariane.sv).
The tracer records the number of cycles, program counter (pc), and committed instructions in the processor. The committed instructions are
shown in hex-format and also human readable format for convenience. Additionally, the Verilog Tracer capture the cycles in which no instruction
is committed. Ideally, the processor should commit an instruction every cycle, however this is not the case in reality. These wasted cycles have
the following message "no instruction to commit why?".


The Verilog Tracer code is:

```
    int f;
    logic [63:0] cycles;

    initial begin
        f = $fopen("./out/ariane.trace.dasm", "w");
    end

    always_ff @(posedge clk_i)
        if (~rst_ni)
            cycles <= 0;
        else
            cycles <= cycles + 1;

    always_ff @(posedge clk_i)
        if (rst_ni & commit_ack & ~ex_commit.valid)
            $fwrite(f, "cycle:%08d pc:0x%h instruction:0x%h DASM(%h)\n", cycles, commit_instr_id_commit.pc, commit_instr_id_commit.ex.tval[31:0], commit_instr_id_commit.ex.tval[31:0]);
        else if (cycles != (cycles - 1))
            $fwrite(f, "cycle:%08d no instruction to commit why?\n", cycles);

    final begin
        $fclose(f);
    end
```
