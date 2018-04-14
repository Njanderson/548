# Compile and run assembly code on Ariane

1. Build and run [simple.S](https://bitbucket.org/taylor-bsg/cse548-18sp-hw/src/master/hw1/src/simple.S) by `make target=run_asm`

In case you want to compile another asm-source-file:

1. Place file in the `src` folder
2. Open [Makefile](https://bitbucket.org/taylor-bsg/cse548-18sp-hw/src/master/hw1/Makefile)
3. Edit the asm_name variable as `asm_name=<new-file-name>`
4. Run `make target=run_asm`
