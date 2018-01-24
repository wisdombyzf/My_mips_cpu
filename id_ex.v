/**
* 	author:zf
*	data:2018/1/21
*	param:
*	clk：时钟信号
*	rst：复位信号
*	id_aluop：译码阶段alu的操作
*	id_alusel：译码阶段alu的操作
*
*	return（同上）:
*
*	brief：id_ex模块
*/
`include "defines.v"

module id_ex(

	input wire clk,
	input wire rst,

	
	//从译码阶段传递的信息
	input wire[`alu_op_bus_width] id_aluop,
	input wire[`alu_sele_bus_width] id_alusel,
	input wire[`reg_data_bus_width] id_reg1,
	input wire[`reg_data_bus_width] id_reg2,
	input wire[`reg_addr_bus_width] id_wd,
	input wire id_wreg,	
	
	//传递到执行阶段的信息
	output reg[`alu_op_bus_width] ex_aluop,
	output reg[`alu_sele_bus_width] ex_alusel,
	output reg[`reg_data_bus_width] ex_reg1,
	output reg[`reg_data_bus_width] ex_reg2,
	output reg[`reg_addr_bus_width] ex_wd,
	output reg ex_wreg
	
);

	always @ (posedge clk) begin
		if (rst == `enable_signal) 		//当复位时
			begin
				ex_aluop <= `EXE_NOP_OP;
				ex_alusel <= `EXE_RES_NOP;
				ex_reg1 <= `zero_word;
				ex_reg2 <= `zero_word;
				ex_wd <= `NOPRegAddr;
				ex_wreg <= `disable_signal;
			end 
		else 
			begin		
				ex_aluop <= id_aluop;
				ex_alusel <= id_alusel;
				ex_reg1 <= id_reg1;
				ex_reg2 <= id_reg2;
				ex_wd <= id_wd;
				ex_wreg <= id_wreg;		
			end
	end	
endmodule