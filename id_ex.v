/**
* 	author:zf
*	data:2018/1/21
*	param:
*	clk��ʱ���ź�
*	rst����λ�ź�
*	id_aluop������׶�alu�Ĳ���
*	id_alusel������׶�alu�Ĳ���
*
*	return��ͬ�ϣ�:
*
*	brief��id_exģ��
*/
`include "defines.v"

module id_ex(

	input wire clk,
	input wire rst,

	
	//������׶δ��ݵ���Ϣ
	input wire[`alu_op_bus_width] id_aluop,
	input wire[`alu_sele_bus_width] id_alusel,
	input wire[`reg_data_bus_width] id_reg1,
	input wire[`reg_data_bus_width] id_reg2,
	input wire[`reg_addr_bus_width] id_wd,
	input wire id_wreg,	
	
	//���ݵ�ִ�н׶ε���Ϣ
	output reg[`alu_op_bus_width] ex_aluop,
	output reg[`alu_sele_bus_width] ex_alusel,
	output reg[`reg_data_bus_width] ex_reg1,
	output reg[`reg_data_bus_width] ex_reg2,
	output reg[`reg_addr_bus_width] ex_wd,
	output reg ex_wreg
	
);

	always @ (posedge clk) begin
		if (rst == `enable_signal) 		//����λʱ
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