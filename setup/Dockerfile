FROM ubuntu:16.04

RUN apt-get update
RUN apt-get -y upgrade
RUN apt-get install -y build-essential
RUN apt-get install -y software-properties-common
RUN apt-get install -y tmux curl git man unzip vim wget

# riscv and verilator dependencies
RUN apt-get install -y flex bison

# riscv dependencies
RUN apt-get install -y autoconf automake autotools-dev curl libmpc-dev
RUN apt-get install -y libmpfr-dev libgmp-dev gawk texinfo gperf libtool
RUN apt-get install -y patchutils bc zlib1g-dev libexpat-dev
RUN apt-get install -y device-tree-compiler

ENV HOME /home
WORKDIR /home

# verilator simulator
ENV verilator_ver 3.904
ENV verilator_top ${HOME}/verilator
ENV verilator_ins ${verilator_top}/install
ENV verilator_dir ${verilator_top}/verilator-${verilator_ver}
ENV verilator_web http://www.veripool.org/ftp/verilator-${verilator_ver}.tgz
ENV verilator_tar ${verilator_top}/verilator-${verilator_ver}.tar.gz

RUN mkdir -p ${verilator_top}
RUN mkdir -p ${verilator_ins}

RUN wget ${verilator_web} -O ${verilator_tar}
RUN tar xf ${verilator_tar} -C ${verilator_top}
RUN cd ${verilator_dir} && ./configure --prefix=${verilator_ins}
RUN make -C ${verilator_dir} verilator_bin
RUN make -C ${verilator_dir} installbin installdata

# ariane riscv-fesvr
ENV fesvr_ver caffc16f703de16866f5d49daaaf3f474900b9a7
ENV fesvr_dir ${HOME}/riscv-fesvr
ENV fesvr_ins ${fesvr_dir}/install
ENV fesvr_bld ${fesvr_dir}/build
ENV LD_LIBRARY_PATH ${fesvr_ins}/lib
RUN git clone https://github.com/pulp-platform/riscv-fesvr.git ${fesvr_dir}
RUN git -C ${fesvr_dir} checkout ${fesvr_ver} -b cse548
RUN mkdir -p ${fesvr_bld} ${fesvr_ins}
RUN cd ${fesvr_bld} && ../configure --prefix=${fesvr_ins}
RUN make -C ${fesvr_bld} install

# riscv gnu toolchain
ENV toolchain_ver b4dae89f85bf882852c6186b1284df11065bfcd9
ENV toolchain_dir ${HOME}/riscv-gnu-toolchain
ENV toolchain_ins ${toolchain_dir}/install
ENV toolchain_bld ${toolchain_dir}/build
RUN git clone --depth=50 https://github.com/riscv/riscv-gnu-toolchain.git ${toolchain_dir}
RUN git -C ${toolchain_dir} checkout ${toolchain_ver} -b cse548
RUN git -C ${toolchain_dir} submodule update --init --recursive
RUN mkdir -p ${toolchain_bld}
RUN cd ${toolchain_bld} && ${toolchain_dir}/configure --prefix=${toolchain_ins}
RUN cd ${toolchain_bld} && make

# riscv isa sim
ENV spike_ver c746388b542eacd2586acfbc0a742b08a5c0bd6f
ENV spike_dir ${HOME}/riscv-isa-sim
ENV spike_ins ${spike_dir}/install
ENV spike_bld ${spike_dir}/build
RUN git clone --depth=50 https://github.com/riscv/riscv-isa-sim.git ${spike_dir}
RUN git -C ${spike_dir} checkout ${spike_ver} -b cse548
RUN mkdir -p ${spike_bld}
RUN cd ${spike_bld} && ${spike_dir}/configure --prefix=${spike_ins} --with-fesvr=${fesvr_ins}
RUN cd ${spike_bld} && make
RUN cd ${spike_bld} && make install

# setting PATH
ENV PATH ${toolchain_ins}/bin:${fesvr_ins}/bin:${verilator_ins}/bin:${spike_ins}/bin:${PATH}

RUN cd ${HOME}

CMD ["bash"]
