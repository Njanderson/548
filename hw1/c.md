# Compile and run c code on Ariane

1. Build and run [hello-world](https://bitbucket.org/taylor-bsg/cse548-18sp-hw/src/master/hw1/src/hello.c) by `make target=run_c`
2. Disassemble binary by `make target=riscv_dasm`
3. The disassembled file is located at `./out/hello.riscv.dasm`

In case you want to compile another c-source-file:

1. Place file in the `src` folder
2. Open [Makefile](https://bitbucket.org/taylor-bsg/cse548-18sp-hw/src/master/hw1/Makefile)
3. Edit the c_name variable as `c_name=<new-file-name>`
4. Run `make target=run_c`
