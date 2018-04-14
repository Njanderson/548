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

A sample trace for this baseline implementation Verilog Tracer is:


```
cycle:00004156 pc:0x000000008000142e instruction:0x0017e793 ori     a5, a5, 1
cycle:00004157 no instruction to commit why?
cycle:00004158 no instruction to commit why?
cycle:00004159 pc:0x0000000080001432 instruction:0x00000717 auipc   a4, 0x0
cycle:00004160 no instruction to commit why?
cycle:00004161 no instruction to commit why?
cycle:00004162 pc:0x0000000080001436 instruction:0xbcf73723 sd      a5, -1074(a4)
cycle:00004163 pc:0x000000008000143a instruction:0x0000006f j       pc + 0x0
cycle:00004164 no instruction to commit why?
cycle:00004165 no instruction to commit why?
cycle:00004166 no instruction to commit why?
cycle:00004167 pc:0x000000008000143a instruction:0x0000006f j       pc + 0x0
cycle:00004168 no instruction to commit why?
cycle:00004169 no instruction to commit why?
cycle:00004170 no instruction to commit why?
cycle:00004171 no instruction to commit why?
cycle:00004172 no instruction to commit why?
cycle:00004173 no instruction to commit why?
cycle:00004174 pc:0x000000008000143a instruction:0x0000006f j       pc + 0x0
cycle:00004175 no instruction to commit why?
```

Signals can be monitored down in the hierarchy without passing wires through the modules and using instances names instead.
For example, if one wants to probe the `flush_dcache` signal inside the controller, then one should
use `controller_i.flush_dcache` from `ariane.sv`
