/**
* 	author:zf
*	data:2018/1/21
*	param: 
*	clk：时钟信号
*	rst：复位信号
*	write_enable：写使能信号
*	write_addr:写地址
*	write_data:写数据
*	read_enble0:0号端口读使能
*	read_addr0:0号端口读地址
*	read_enble1:1号端口读使能
*	read_addr1:1号端口读地址
*	return:
*	read_data0:0号端口读数据
*	read_data1:1号端口读数据
*
*	brief：32个32位双端口寄存器堆模块
*/

`include "defines.v"

module regfile(

	input wire clk,
	input wire rst,
	
	//写端口
	input wire we,
	input wire[`reg_addr_bus_width] waddr,
	input wire[`reg_data_bus_width] wdata,
	
	//读端口1
	input wire re1,
	input wire[`reg_addr_bus_width] raddr1,
	output reg[`reg_data_bus_width] rdata1,
	
	//读端口2
	input wire re2,
	input wire[`reg_addr_bus_width] raddr2,
	output reg[`reg_data_bus_width] rdata2
	
);

	reg[`reg_data_bus_width]  regs[0:`reg_num-1];

	always @ (posedge clk) 
	begin
		if (rst == `disable_signal) 
			begin
				//当写信号有效，且写入寄存器不为0时（因为$0寄存器只能为0）。。。。完全想不到
				if((we == `enable_signal) && (waddr != `reg_num_log2'h0)) 
					begin
						regs[waddr] <= wdata;
					end
			end
	end
	
	/**
	*	下面两条always语句其实就是实现计组书上寄存器在
	*	前半个周期写，后半个周期读的功能。。。。
	*	（话说上计组课时还真以为有半个时钟周期这个东西呢)
	*	
	* 	具体实现思路：如果下一个周期要读取的寄存器，正好是下一个周期要写入的寄存器
	*	就直接将写的数据作为读取结果输出。
	*/
	//一号端口
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

	//二号端口
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