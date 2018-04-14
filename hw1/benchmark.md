# Compile and run benchmarks on Ariane

* These benchmarks are based on [riscv-tests](https://github.com/riscv/riscv-tests)
* Download, build, run `make target=run_benchmark`
* The list of benchmarks are defined by the `bmarks` variable in the [Makefile](https://bitbucket.org/taylor-bsg/cse548-18sp-hw/src/master/hw1/Makefile) as:

```
bmarks = \
median \
dhrystone \
multiply \
towers \
qsort \
rsort \
vvadd
```
