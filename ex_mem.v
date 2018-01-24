/**
* 	author:zf
*	data:2018/1/21
*	param: 
*	return:
*	brief：ex_mem模块
*/
`include "defines.v"

module ex_mem(

	input wire clk,
	input wire rst,
	
	
	//来自执行阶段的信息	
	input wire[`reg_addr_bus_width] ex_wd,
	input wire ex_wreg,
	input wire[`reg_data_bus_width] ex_wdata, 	
	
	//送到访存阶段的信息
	output reg[`reg_addr_bus_width] mem_wd,
	output reg mem_wreg,
	output reg[`reg_data_bus_width] mem_wdata
	
	
);


	always @ (posedge clk) 
	begin
		if(rst == `enable_signal) 
			begin
				mem_wd <= `NOPRegAddr;
				mem_wreg <= `disable_signal;
				mem_wdata <= `zero_word;	
			end 
		else 
			begin
				mem_wd <= ex_wd;
				mem_wreg <= ex_wreg;
				mem_wdata <= ex_wdata;			
			end  
	end      
			

endmodule