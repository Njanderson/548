top_name = adder
timeout_cycles = 10
#sim_type = run # without waveform
sim_type = run_debug # with waveform

verilator_bin = verilator

hw_dir = $(abspath .)

docker_hw_dir = /home/hw0
docker_image_name = cse548
docker_cmd = docker run -v $(hw_dir):$(docker_hw_dir) -it $(docker_image_name)

src_dir = $(docker_hw_dir)/src

src_files = \
$(src_dir)/$(top_name).v \
$(src_dir)/main.cc

out_dirname = out
docker_out_dir = $(docker_hw_dir)/$(out_dirname)
vcd_file = $(docker_out_dir)/$(top_name).vcd

default: clean
	$(docker_cmd) /usr/bin/make -C $(docker_hw_dir) $(sim_type)

run: $(docker_out_dir)/V$(top_name)
	$<

run_debug: $(docker_out_dir)/V$(top_name)_debug
	$<

$(docker_out_dir)/V$(top_name):
	$(verilator_bin) --cc --exe -Mdir $(docker_out_dir) $(src_files) \
	-CFLAGS "-include V$(top_name).h -DVNAME=V$(top_name) -DTIMEOUT_CYCLES=$(timeout_cycles)" \
	-o $(docker_out_dir)/V$(top_name)
	make -C $(docker_out_dir) -f V$(top_name).mk

$(docker_out_dir)/V$(top_name)_debug:
	$(verilator_bin) --trace --cc --exe -Mdir $(docker_out_dir) $(src_files) \
	-CFLAGS "-include V$(top_name).h -DVNAME=V$(top_name) -DVM_TRACE" \
	-CFLAGS "-DVCD_FILE=$(vcd_file) -DTIMEOUT_CYCLES=$(timeout_cycles)" \
	-o $(docker_out_dir)/V$(top_name)_debug
	make -C $(docker_out_dir) -f V$(top_name).mk

clean:
	$(docker_cmd) /bin/rm -rf $(docker_out_dir)
