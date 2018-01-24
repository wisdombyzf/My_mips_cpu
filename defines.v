/**
*	author:zf
*	date:2018/1/20
*	brief：
*	储存所有宏定义的文件
*	反正也只用几天，所以也没有必要去看verilog的代码规范
*	我开心就好。。。。
*	所以我直接将宏定义用小写表示（我高兴^_^）
*	同时仿照python对begin~end进行对齐
*	并对每个重要模块都准备一个test_bench（有点像Java的测试类）
**/

///////////////////全局//////////////////////
`define enable_signal 1'b1
`define disable_signal 1'b0
`define zero_word 32'h00000000


`define alu_op_bus_width 7:0
`define alu_sele_bus_width 2:0

`define InstValid 1'b0
`define InstInvalid 1'b1
`define Stop 1'b1
`define NoStop 1'b0
`define InDelaySlot 1'b1
`define NotInDelaySlot 1'b0
`define Branch 1'b1
`define NotBranch 1'b0
`define InterruptAssert 1'b1
`define InterruptNotAssert 1'b0
`define TrapAssert 1'b1
`define TrapNotAssert 1'b0
`define True_v 1'b1
`define False_v 1'b0



//指令
`define EXE_ORI  6'b001101


`define EXE_NOP 6'b000000


//AluOp
`define EXE_OR_OP    8'b00100101
`define EXE_ORI_OP  8'b01011010


`define EXE_NOP_OP    8'b00000000

//AluSel
`define EXE_RES_LOGIC 3'b001

`define EXE_RES_NOP 3'b000


//指令存储器inst_rom
`define inst_addr_bus_width 31:0
`define InstBus 31:0
`define InstMemNum 131071
`define InstMemNumLog2 17


//通用寄存器regfile
`define reg_addr_bus_width 4:0
`define reg_data_bus_width 31:0
`define reg_width 32
`define DoubleRegWidth 64
`define DoubleRegBus 63:0
`define reg_num 32
`define reg_num_log2 5
`define NOPRegAddr 5'b00000
