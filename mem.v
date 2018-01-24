/**
* 	author:zf
*	data:2018/1/21
*	param: 
*	wd_i：访存段要写入的目的寄存器地址
*	wreg_i：访存段是否有要写入的目的寄存器
*	wdata_i:要写入的数据
*	return:
*	brief：mem模块
*/
`include "defines.v"

module mem(

	input wire rst,
	
	//来自执行阶段的信息	
	input wire[`reg_addr_bus_width] wd_i,
	input wire wreg_i,
	input wire[`reg_data_bus_width] wdata_i,
	
	//送到回写阶段的信息
	output reg[`reg_addr_bus_width] wd_o,
	output reg wreg_o,
	output reg[`reg_data_bus_width] wdata_o
	
);

	
	always @ (*) 
	begin
		if(rst == `enable_signal) 
			begin
				wd_o <= `NOPRegAddr;
				wreg_o <= `disable_signal;
				wdata_o <= `zero_word;
			end 
		else 
			begin
				wd_o <= wd_i;
				wreg_o <= wreg_i;
				wdata_o <= wdata_i;
			end   
	end      
			
endmodule