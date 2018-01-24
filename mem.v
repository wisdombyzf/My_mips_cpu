/**
* 	author:zf
*	data:2018/1/21
*	param: 
*	wd_i���ô��Ҫд���Ŀ�ļĴ�����ַ
*	wreg_i���ô���Ƿ���Ҫд���Ŀ�ļĴ���
*	wdata_i:Ҫд�������
*	return:
*	brief��memģ��
*/
`include "defines.v"

module mem(

	input wire rst,
	
	//����ִ�н׶ε���Ϣ	
	input wire[`reg_addr_bus_width] wd_i,
	input wire wreg_i,
	input wire[`reg_data_bus_width] wdata_i,
	
	//�͵���д�׶ε���Ϣ
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