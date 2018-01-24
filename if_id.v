/**
* 	author:zf
*	data:2018/1/21
*	param:
*	clk��ʱ���ź�
*	rst����λ�ź�
*	if_pc��ȡָ��׶�ȡ��ָ��ĵ�ַ
*	if_inst��ȡָ��׶�ȡ��ָ��Ļ�����
*	return:
*	id_pc������׶�ָ��ĵ�ַ
*	id_inst������׶�ָ��Ļ�����
*	brief��if_idģ��
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