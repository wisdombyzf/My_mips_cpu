/**
* 	author:zf
*	data:2018/1/21
*	param: 
*	return:
*	brief��exģ��
*/
`include "defines.v"

module alu(

	input wire rst,
	
	//�͵�ִ�н׶ε���Ϣ
	input wire[`alu_op_bus_width] aluop_i,
	input wire[`alu_sele_bus_width] alusel_i,
	input wire[`reg_data_bus_width] reg1_i,
	input wire[`reg_data_bus_width] reg2_i,
	input wire[`reg_addr_bus_width] wd_i,
	input wire wreg_i,

	
	output reg[`reg_addr_bus_width] wd_o,
	output reg wreg_o,
	output reg[`reg_data_bus_width] wdata_o
	
);
	//�����߼��������Ĵ�����
	reg[`reg_data_bus_width] logicout;
	
	always @ (*) 
	begin
		if(rst == `enable_signal) 
			begin
				logicout <= `zero_word;
			end 
		else 
			begin
				case (aluop_i)
					`EXE_OR_OP:			
						begin
							logicout <= reg1_i | reg2_i;
						end
					default:				
						begin
							logicout <= `zero_word;
						end
				endcase
			end  
	end    


	always @ (*) 
	begin
	 wd_o <= wd_i;	 	 	
	 wreg_o <= wreg_i;
	 case ( alusel_i ) 
	 	`EXE_RES_LOGIC:		
			begin
				wdata_o <= logicout;
			end
	 	default:					
			begin
				wdata_o <= `zero_word;
			end
	 endcase
 end	

endmodule