TOP = noc
GTKWAVE = gtkwave

V_SRC = $(wildcard *.v) #wildcard用於查找指定目錄下的文件列表
#(wildcard ./vsrc/*.v)
TESTBENCH_SRC = $(wildcard *.cpp)
INC = -Ivsrc
VTOP = ${TOP}.v
#./vsrc/${TOP}.v

# 增加 CPPFLAGS 以启用调试支持
CPPFLAGS = -DVL_DEBUG

.DEFAULT_GOAL := all
all: vhdl

obj_dir/V${TOP}.mk: ${V_SRC} ${TESTBENCH_SRC} 
	verilator -Wall --Wno-BLKSEQ --Wno-UNDRIVEN --Wno-PINCONNECTEMPTY --Wno-unused --Wno-UNOPTFLAT --Wno-IMPLICIT --Wno-WIDTH --cc --exe --build ${TESTBENCH_SRC} ${INC} ${VTOP} --trace
	
obj_dir/V${TOP} : obj_dir/V${TOP}.mk
	$(MAKE) -C obj_dir -f V${TOP}.mk


.PHONY : vhdl
vhdl: obj_dir/V${TOP}.mk

.PHONY: run
run: obj_dir/V${TOP}
	 obj_dir/V${TOP}

.PHONY: wave
wave: run
	${GTKWAVE} wave.vcd

.PHONY: clean
clean:
		rm -rf obj_dir wave.vcd