# SystemVerilog hello world

The goal of this homework is to test if you have setup your environment correctly. You will be simulating an adder with registered input and output.

## Environment setup

If you have not built the Docker image please read [this](https://bitbucket.org/taylor-bsg/cse548-18sp-hw/src/master/setup)

## Run simulation

Run `make`

## Simulation output

There are two ways of debugging hardware designs: using standard output or waveforms. This homework is configured to generate both.

* Standard output is done by the following [printf](https://bitbucket.org/taylor-bsg/cse548-18sp-hw/src/master/hw0/src/main.cc#L50)
* The waveform file (vcd) is created after running `make` and it is located at `./out/adder.vcd`
    * [GTKWave](http://gtkwave.sourceforge.net) can be used for viewing vcd files

## Turnin using [canvas](https://canvas.uw.edu/courses/1199347/assignments/4178080)

* Text file (.txt) containing the standard output of `make`
* Waveform file (.vcd) containing the signals corresponding to the design
