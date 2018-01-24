/**
* 	author:zf
*	data:2018/1/21
*	param: 
*	return:
*	brief：ex模块
*/
`include "defines.v"

module alu(

	input wire rst,
	
	//送到执行阶段的信息
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
	//定义逻辑运算结果的储存器
	reg[`reg_data_bus_width] logicout;
	//移位运算结果储存器
	reg[`RegBus] shiftres;
	
	//逻辑运算
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
					`EXE_AND_OP:		
						begin
							logicout <= reg1_i & reg2_i;
						end
					`EXE_NOR_OP:		
						begin
							logicout <= ~(reg1_i |reg2_i);
						end
					`EXE_XOR_OP:		
						begin
							logicout <= reg1_i ^ reg2_i;
						end
					default:				
						begin
							logicout <= `zero_word;
						end
				endcase
			end  
	end    
	
	//移位运算
	always @ (*)
	begin
		if(rst == `enable_signal) 
			begin
				shiftres <= `zero_word;
			end 
		else 
			begin
				case (aluop_i)
					`EXE_SLL_OP:			
						begin
							shiftres <= reg2_i << reg1_i[4:0] ;
						end
					`EXE_SRL_OP:		
						begin
							shiftres <= reg2_i >> reg1_i[4:0];
						end
					`EXE_SRA_OP:		
						begin
							shiftres <= ({32{reg2_i[31]}} << (6'd32-{1'b0, reg1_i[4:0]}))| reg2_i >> reg1_i[4:0];
						end
					default:				
						begin
							shiftres <= `zero_word;
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