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
*	brief������ģ��
*/
`include "defines.v"

module id(
	input wire rst,
	input wire[`inst_addr_bus_width] pc_i,
	input wire[`InstBus] inst_i,
	
	//����ִ�н׶ε��źţ�ex_ex��·�жϣ�
	input wire ex_wreg_i,
	input wire[`reg_data_bus_width] ex_wdata_i,
	input wire[`reg_addr_bus_width] ex_wd_i,
	
	//���Էô�׶ε��źţ�ex_mem��·�жϣ�
	input wire mem_wreg_i,
	input wire[`reg_data_bus_width] mem_wdata_i,
	input wire[`reg_addr_bus_width] mem_wd_i,
	
	//Ҫд�������
	input wire[`reg_data_bus_width] reg1_data_i,
	input wire[`reg_data_bus_width] reg2_data_i,

	//�͵�regfile����Ϣ
	output reg reg1_read_o,
	output reg reg2_read_o,     
	output reg[`reg_addr_bus_width] reg1_addr_o,
	output reg[`reg_addr_bus_width] reg2_addr_o, 	      
	
	//�͵�ִ�н׶ε���Ϣ
	output reg[`alu_op_bus_width] aluop_o,
	output reg[`alu_sele_bus_width] alusel_o,
	output reg[`reg_data_bus_width] reg1_o,
	output reg[`reg_data_bus_width] reg2_o,
	output reg[`reg_addr_bus_width] wd_o,
	output reg wreg_o
);

	//ָ����
	wire[5:0] op = inst_i[31:26]; 	
	//������
	wire[4:0] op2 = inst_i[10:6];
	wire[5:0] op3 = inst_i[5:0];
	wire[4:0] op4 = inst_i[20:16];
	reg[`reg_data_bus_width] imm;
	reg instvalid;
  
 
	//�ֽ�ָ��
	always @ (*) 
	begin	
		if (rst == `enable_signal) 
			begin
				aluop_o <= `EXE_NOP_OP;
				alusel_o <= `EXE_RES_NOP;
				wd_o <= `NOPRegAddr;
				wreg_o <= `disable_signal;
				instvalid <= `InstValid;
				reg1_read_o <= 1'b0;
				reg2_read_o <= 1'b0;
				reg1_addr_o <= `NOPRegAddr;
				reg2_addr_o <= `NOPRegAddr;
				imm <= 32'h0;			
			end 
		else 
			begin
				aluop_o <= `EXE_NOP_OP;
				alusel_o <= `EXE_RES_NOP;
				wd_o <= inst_i[15:11];
				wreg_o <= `disable_signal;
				instvalid <= `InstInvalid;	   
				reg1_read_o <= 1'b0;
				reg2_read_o <= 1'b0;
				reg1_addr_o <= inst_i[25:21];
				reg2_addr_o <= inst_i[20:16];		
				imm <= `zero_word;			
				case (op)
				//���֧�ֵ�ָ�
				`EXE_SPECIAL_INST:		
					begin
						case (op2)
						5'b00000:			
							begin
								case (op3)
								`EXE_OR:	
									begin
										wreg_o <= `enable_signal;		
										aluop_o <= `EXE_OR_OP;
										alusel_o <= `EXE_RES_LOGIC; 	
										reg1_read_o <= 1'b1;	
										reg2_read_o <= 1'b1;
										instvalid <= `InstValid;	
									end  
								`EXE_AND:	
									begin
										wreg_o <= `enable_signal;		
										aluop_o <= `EXE_AND_OP;
										alusel_o <= `EXE_RES_LOGIC;	  
										reg1_read_o <= 1'b1;	
										reg2_read_o <= 1'b1;	
										instvalid <= `InstValid;	
									end  	
								`EXE_XOR:	
									begin
										wreg_o <= `enable_signal;		
										aluop_o <= `EXE_XOR_OP;
										alusel_o <= `EXE_RES_LOGIC;		
										reg1_read_o <= 1'b1;	
										reg2_read_o <= 1'b1;	
										instvalid <= `InstValid;	
									end  				
								`EXE_NOR:	
									begin
										wreg_o <= `enable_signal;		
										aluop_o <= `EXE_NOR_OP;
										alusel_o <= `EXE_RES_LOGIC;		
										reg1_read_o <= 1'b1;	
										reg2_read_o <= 1'b1;	
										instvalid <= `InstValid;	
									end 						  									
								default:	
									begin
									end
								endcase
							end
						default: 
							begin
							end
						endcase	
					end	
				`EXE_ORI:			
					begin                        //ORIָ��
						wreg_o <= `enable_signal;		
						aluop_o <= `EXE_OR_OP;
						alusel_o <= `EXE_RES_LOGIC; 
						reg1_read_o <= 1'b1;	
						reg2_read_o <= 1'b0;	  	
						imm <= {16'h0, inst_i[15:0]};		
						wd_o <= inst_i[20:16];
						instvalid <= `InstValid;	
					end 
					
				`EXE_ANDI:			
					begin
						wreg_o <= `enable_signal;		
						aluop_o <= `EXE_AND_OP;
						alusel_o <= `EXE_RES_LOGIC;	
						reg1_read_o <= 1'b1;	
						reg2_read_o <= 1'b0;	  	
						imm <= {16'h0, inst_i[15:0]};		
						wd_o <= inst_i[20:16];		  	
						instvalid <= `InstValid;	
					end	 	
				`EXE_XORI:			
					begin
						wreg_o <= `enable_signal;		
						aluop_o <= `EXE_XOR_OP;
						alusel_o <= `EXE_RES_LOGIC;	
						reg1_read_o <= 1'b1;	
						reg2_read_o <= 1'b0;	  	
						imm <= {16'h0, inst_i[15:0]};		
						wd_o <= inst_i[20:16];		  	
						instvalid <= `InstValid;	
					end	 		
				`EXE_LUI:			
					begin
						wreg_o <= `enable_signal;		
						aluop_o <= `EXE_OR_OP;
						alusel_o <= `EXE_RES_LOGIC; 
						reg1_read_o <= 1'b1;	
						reg2_read_o <= 1'b0;	  	
						imm <= {inst_i[15:0], 16'h0};		
						wd_o <= inst_i[20:16];		  	
						instvalid <= `InstValid;	
					end											  	
				default:			
					begin
					end
				endcase			
					
				
				if (inst_i[31:21] == 11'b00000000000) 
					begin
						if (op3 == `EXE_SLL) 
							begin
								wreg_o <= `enable_signal;		
								aluop_o <= `EXE_SLL_OP;
								alusel_o <= `EXE_RES_SHIFT; 
								reg1_read_o <= 1'b0;	
								reg2_read_o <= 1'b1;	  	
								imm[4:0] <= inst_i[10:6];		
								wd_o <= inst_i[15:11];
								instvalid <= `InstValid;	
							end 
						else if ( op3 == `EXE_SRL ) 
							begin
								wreg_o <= `enable_signal;		
								aluop_o <= `EXE_SRL_OP;
								alusel_o <= `EXE_RES_SHIFT; 
								reg1_read_o <= 1'b0;	
								reg2_read_o <= 1'b1;	  	
								imm[4:0] <= inst_i[10:6];		
								wd_o <= inst_i[15:11];
								instvalid <= `InstValid;	
							end 
						else if ( op3 == `EXE_SRA ) 
							begin
								wreg_o <= `enable_signal;		
								aluop_o <= `EXE_SRA_OP;
								alusel_o <= `EXE_RES_SHIFT; 
								reg1_read_o <= 1'b0;	
								reg2_read_o <= 1'b1;	  	
								imm[4:0] <= inst_i[10:6];		
								wd_o <= inst_i[15:11];
								instvalid <= `InstValid;	
							end
					end		
			end     
	end 
	
	///�Ĵ�������
	//һ�Ŷ˿�
	always @ (*) 
	begin
		if(rst == `enable_signal) 
			begin
				reg1_o <= `zero_word;
			end 
		/**
		*	ex_ex��·
		*	������Ҫ���ļĴ���==aluִ�н׶�Ҫд��Ŀ�ļĴ���
		*	������ֱ�ӽ�alu���ص�������Ϊ���
		*/
		else if((reg1_read_o==`enable_signal)&& (ex_wreg_i == `enable_signal)&& (ex_wd_i == reg1_addr_o))
			begin
				reg1_o <= ex_wdata_i; 
			end
		/**
		*	mem_ex��·
		*	������Ҫ���ļĴ���==�ô�׶�Ҫд��Ŀ�ļĴ���
		*	������ֱ�ӽ��ô�׶δ��ص�������Ϊ���
		*/
		else if((reg1_read_o==`enable_signal)&& (mem_wreg_i == `enable_signal)&& (mem_wd_i == reg1_addr_o))
			begin
				reg1_o <= mem_wdata_i; 
			end
		else if(reg1_read_o == 1'b1) 
			begin
				reg1_o <= reg1_data_i;
			end 
		else if(reg1_read_o == 1'b0) 
			begin
				reg1_o <= imm;
			end 
		else
			begin
				reg1_o <= `zero_word;
			end
	end
	
	always @ (*) 
	begin
		if(rst == `enable_signal) 
			begin
				reg2_o <= `zero_word;
			end 
		/**
		*	ex_ex��·
		*	������Ҫ���ļĴ���==aluִ�н׶�Ҫд��Ŀ�ļĴ���
		*	������ֱ�ӽ�alu���ص�������Ϊ���
		*/
		else if((reg2_read_o==`enable_signal)&& (ex_wreg_i == `enable_signal)&& (ex_wd_i == reg2_addr_o))
			begin
				reg2_o <= ex_wdata_i; 
			end
		/**
		*	mem_ex��·
		*	������Ҫ���ļĴ���==�ô�׶�Ҫд��Ŀ�ļĴ���
		*	������ֱ�ӽ��ô�׶δ��ص�������Ϊ���
		*/
		else if((reg2_read_o==`enable_signal)&& (mem_wreg_i == `enable_signal)&& (mem_wd_i == reg2_addr_o))
			begin
				reg2_o <= mem_wdata_i; 
			end
		else if(reg2_read_o == 1'b1) 
			begin
				reg2_o <= reg2_data_i;
			end 
		else if(reg2_read_o == 1'b0) 
			begin
				reg2_o <= imm;
			end 
		else 
			begin
				reg2_o <= `zero_word;
			end
	end

endmodule