/**
* 	author:zf
*	data:2018/1/21
*	param: 
*	return:
*	brief：mem_wb模块
*/
`include "defines.v"

module mem_wb(

	input wire clk,
	input wire rst,
	

	//来自访存阶段的信息	
	input wire[`reg_addr_bus_width] mem_wd,
	input wire mem_wreg,
	input wire[`reg_data_bus_width] mem_wdata,

	//送到回写阶段的信息
	output reg[`reg_addr_bus_width] wb_wd,
	output reg wb_wreg,
	output reg[`reg_data_bus_width] wb_wdata	       
	
);


	always @ (posedge clk) 
	begin
		if(rst == `enable_signal) 
			begin
				wb_wd <= `NOPRegAddr;
				wb_wreg <= `disable_signal;
				wb_wdata <= `zero_word;	
			end
		else 
			begin
				wb_wd <= mem_wd;
				wb_wreg <= mem_wreg;
				wb_wdata <= mem_wdata;
			end    
	end    
		
		

endmodule