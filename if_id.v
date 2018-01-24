/**
* 	author:zf
*	data:2018/1/21
*	param:
*	clk：时钟信号
*	rst：复位信号
*	if_pc：取指令阶段取出指令的地址
*	if_inst：取指令阶段取出指令的机器码
*	return:
*	id_pc：译码阶段指令的地址
*	id_inst：译码阶段指令的机器码
*	brief：if_id模块
*/

`include "defines.v"

module if_id(
	input wire clk,
	input wire rst,
	input wire[`inst_addr_bus_width] if_pc,
	input wire[`InstBus] if_inst,
	
	output reg[`inst_addr_bus_width] id_pc,
	output reg[`InstBus] id_inst  	
);

	always @ (posedge clk) 
	begin
		if (rst == `enable_signal) 
			begin
				id_pc <= `zero_word;
				id_inst <= `zero_word;
			end 
		else 
			begin
				id_pc <= if_pc;
				id_inst <= if_inst;
			end
	end

endmodule