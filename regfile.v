/**
* 	author:zf
*	data:2018/1/21
*	param: 
*	clk��ʱ���ź�
*	rst����λ�ź�
*	write_enable��дʹ���ź�
*	write_addr:д��ַ
*	write_data:д����
*	read_enble0:0�Ŷ˿ڶ�ʹ��
*	read_addr0:0�Ŷ˿ڶ���ַ
*	read_enble1:1�Ŷ˿ڶ�ʹ��
*	read_addr1:1�Ŷ˿ڶ���ַ
*	return:
*	read_data0:0�Ŷ˿ڶ�����
*	read_data1:1�Ŷ˿ڶ�����
*
*	brief��32��32λ˫�˿ڼĴ�����ģ��
*/

`include "defines.v"

module regfile(

	input wire clk,
	input wire rst,
	
	//д�˿�
	input wire we,
	input wire[`reg_addr_bus_width] waddr,
	input wire[`reg_data_bus_width] wdata,
	
	//���˿�1
	input wire re1,
	input wire[`reg_addr_bus_width] raddr1,
	output reg[`reg_data_bus_width] rdata1,
	
	//���˿�2
	input wire re2,
	input wire[`reg_addr_bus_width] raddr2,
	output reg[`reg_data_bus_width] rdata2
	
);

	reg[`reg_data_bus_width]  regs[0:`reg_num-1];

	always @ (posedge clk) 
	begin
		if (rst == `disable_signal) 
			begin
				//��д�ź���Ч����д��Ĵ�����Ϊ0ʱ����Ϊ$0�Ĵ���ֻ��Ϊ0������������ȫ�벻��
				if((we == `enable_signal) && (waddr != `reg_num_log2'h0)) 
					begin
						regs[waddr] <= wdata;
					end
			end
	end
	
	/**
	*	��������always�����ʵ����ʵ�ּ������ϼĴ�����
	*	ǰ�������д���������ڶ��Ĺ��ܡ�������
	*	����˵�ϼ����ʱ������Ϊ�а��ʱ���������������)
	*	
	* 	����ʵ��˼·�������һ������Ҫ��ȡ�ļĴ�������������һ������Ҫд��ļĴ���
	*	��ֱ�ӽ�д��������Ϊ��ȡ��������
	*/
	//һ�Ŷ˿�
	always @ (*) 
	begin
		if(rst == `enable_signal) 
			begin
				rdata1 <= `zero_word;
			end 
		else if(raddr1 == `reg_num_log2'h0) 
			begin
					rdata1 <= `zero_word;
			end 
		else if((raddr1 == waddr) && (we == `enable_signal)&& (re1 == `enable_signal)) 
			begin
				rdata1 <= wdata;
			end 
		else if(re1 == `enable_signal) 
			begin
				rdata1 <= regs[raddr1];
			end 
		else 
			begin
				rdata1 <= `zero_word;
			end
	end

	//���Ŷ˿�
	always @ (*) 
	begin
		if(rst == `enable_signal)
			begin
				rdata2 <= `zero_word;
			end 
		else if(raddr2 == `reg_num_log2'h0) 
			begin
				rdata2 <= `zero_word;
			end 
		else if((raddr2 == waddr) && (we == `enable_signal) && (re2 == `enable_signal)) 
			begin
				rdata2 <= wdata;
			end 
		else if(re2 == `enable_signal) 
			begin
				rdata2 <= regs[raddr2];
			end 
		else 
			begin
				rdata2 <= `zero_word;
			end
	end

endmodule