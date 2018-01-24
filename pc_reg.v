/**
* 	author:zf
*	data:2018/1/21
*	param:
*	clk：时钟信号
*	rst：复位信号
*
*	return:
*	pc:下一条指令要读取的地址
*	ce:指令储存器使能信号
*	brief：pc模块
*/

`include "defines.v"

module pc(

	input wire clk,
	input wire rst,
	
	output reg[`inst_addr_bus_width] pc,
	output reg ce	
	);

	always @ (posedge clk) 
	begin
		if (rst == `enable_signal) 		//复位时，指令储存器不能读
			begin
				ce <= `disable_signal;
			end 
		else 
			begin
				ce <= `enable_signal;
			end
	end
	
	always @ (posedge clk) 
	begin
		if (ce == `disable_signal) 			//用ce信号而不是rst信号判断，为后面的nop指令提供方便
			begin
				pc <= 32'h00000000;
			end 
		else 
			begin
				pc <= pc + 4'h4;			//pc加4
			end
	end
endmodule