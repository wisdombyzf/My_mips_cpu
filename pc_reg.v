/**
* 	author:zf
*	data:2018/1/21
*	param:
*	clk��ʱ���ź�
*	rst����λ�ź�
*
*	return:
*	pc:��һ��ָ��Ҫ��ȡ�ĵ�ַ
*	ce:ָ�����ʹ���ź�
*	brief��pcģ��
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
		if (rst == `enable_signal) 		//��λʱ��ָ��������ܶ�
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
		if (ce == `disable_signal) 			//��ce�źŶ�����rst�ź��жϣ�Ϊ�����nopָ���ṩ����
			begin
				pc <= 32'h00000000;
			end 
		else 
			begin
				pc <= pc + 4'h4;			//pc��4
			end
	end
endmodule