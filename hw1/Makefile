target ?= ariane

test ?= benchmarks/median.riscv

verilator_bin = verilator

hw_dir = $(abspath .)

# output dir
out_dirname = out
out_dir = $(hw_dir)/$(out_dirname)
src_dir = $(hw_dir)/src

# ariane variables
ariane_top_module_name = ariane_wrapped

ariane_ver = 5f194d9c9558a1fed8dc55fff43358c750a1489a
ariane_dir = $(hw_dir)/ariane

# ariane_dir env-variable is defined in Dockerfile
ariane_src_dir = $(ariane_dir)/src
ariane_tb_dir = $(ariane_dir)/tb
ariane_inc_dir = $(ariane_dir)/include

ariane_pkg_files = \
$(ariane_inc_dir)/ariane_pkg.sv \
$(ariane_inc_dir)/nbdcache_pkg.sv

# remove regfile and ariane files from ariane-src-dir
# use ariane-top from src/ariane.sv instead
ariane_vfiles = \
$(filter-out $(ariane_src_dir)/regfile.sv $(ariane_src_dir)/ariane.sv, $(wildcard $(ariane_src_dir)/*.sv)) \
$(docker_hw_dir)/src/ariane.sv \
$(ariane_src_dir)/util/cluster_clock_gating.sv \
$(ariane_src_dir)/util/behav_sram.sv \
$(ariane_src_dir)/axi_mem_if/axi2mem.sv \
$(ariane_tb_dir)/agents/axi_if/axi_if.sv

ariane_cfiles = \
$(ariane_tb_dir)/ariane_tb.cpp \
$(ariane_tb_dir)/simmem.cpp

# riscv tests
rvtests_ver = fc3d7e8196dfb567a9b6c34dd97c1b43260b4cd5
rvtests_dir = $(hw_dir)/riscv-tests

# docker variables
docker_hw_dir = /home/hw1
docker_out_dir = $(docker_hw_dir)/$(out_dirname)
docker_image_name = cse548
docker_cmd = docker run -v $(hw_dir):$(docker_hw_dir) -it $(docker_image_name)

# simulation options
# sim_opt = -p, show simulation
sim_opt = "--vcd=$(out_dir)/ariane.vcd" #, store waveform in test.vcd

default:
	$(docker_cmd) /usr/bin/make -C $(docker_hw_dir) $(target)

run_docker:
	$(docker_cmd)

ariane: $(out_dir)/ariane

# fesvr_dir env-variable is define in Dockerfile
$(out_dir)/ariane: $(ariane_dir)
	mkdir -p $(dir $@)
	$(verilator_bin) --trace --cc --exe -Wno-fatal --unroll-count 256 --Wall \
	-CFLAGS "-I$(fesvr_dir) -std=c++11 -I${fesvr_dir}" \
	-LDFLAGS "-L$(fesvr_dir)/install/lib -lfesvr" \
	-Mdir $(docker_out_dir) -o $@ --top-module $(ariane_top_module_name) +incdir+$(ariane_inc_dir) \
	$(ariane_pkg_files) $(ariane_vfiles) $(ariane_cfiles)
	cd $(docker_out_dir) && make -j -f V$(ariane_top_module_name).mk

$(ariane_dir):
	git clone https://github.com/pulp-platform/ariane.git $@
	git -C $(ariane_dir) checkout $(ariane_ver) -b cse548
	git -C $(ariane_dir) submodule update --init --recursive

# riscv tests

rvtests: $(out_dir)/rvtests

run_test: rvtests ariane
	$(out_dir)/ariane $(sim_opt) $(out_dir)/rvtests/share/riscv-tests/$(test)

$(out_dir)/rvtests: $(rvtests_dir)
	cd $(rvtests_dir) && autoconf
	mkdir -p $(rvtests_dir)/build
	cd $(rvtests_dir)/build && $(rvtests_dir)/configure --prefix=$@
	cd $(rvtests_dir)/build && make
	cd $(rvtests_dir)/build && make install

$(rvtests_dir):
	git clone https://github.com/riscv/riscv-tests.git $@
	git -C $@ checkout $(rvtests_ver) -b cse548
	git -C $@ submodule update --init --recursive

# hello world
CC = riscv64-unknown-elf-gcc
OBJDUMP = riscv64-unknown-elf-objdump

hello: $(out_dir)/hello.riscv

run_hello: hello ariane
	$(out_dir)/ariane $(sim_opt) $(out_dir)/hello.riscv

$(out_dir)/hello.riscv: $(src_dir)/hello.c $(rvtests_dir)
	mkdir -p $(dir $@)
	$(CC) -I$(rvtests_dir)/benchmarks/../env -I$(rvtests_dir)/benchmarks/common \
	-DPREALLOCATE=1 -mcmodel=medany -static -std=gnu99 -O2 -ffast-math -fno-common \
	-fno-builtin-printf $(rvtests_dir)/benchmarks/common/syscalls.c -static -nostdlib \
	$(rvtests_dir)/benchmarks/common/crt.S  -nostartfiles -lm -lgcc \
	-T $(rvtests_dir)/benchmarks/common/test.ld -o $@ $<

$(out_dir)/hello.riscv.dasm: $(out_dir)/hello.riscv
	$(OBJDUMP) --disassemble-all --disassemble-zeroes --section=.text --section=.text.startup --section=.data $< > $@

riscv_dasm: $(out_dir)/hello.riscv.dasm

clean:
	$(docker_cmd) /bin/rm -rf $(docker_out_dir)
