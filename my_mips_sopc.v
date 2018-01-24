/**
* 	author:zf
*	data:2018/1/21
*	param: 
*	return:
*	brief：my_mips_sopc模块
*/


`include "defines.v"

module my_mips_sopc(

	input wire clk,
	input wire rst
	
);

  //连接指令存储器
  wire[`inst_addr_bus_width] inst_addr;
  wire[`InstBus] inst;
  wire rom_ce;
 

 my_mips_cpu openmips0(
		.clk(clk),
		.rst(rst),
	
		.rom_addr_o(inst_addr),
		.rom_data_i(inst),
		.rom_ce_o(rom_ce)
	
	);
	
	inst_rom inst_rom0(
		.addr(inst_addr),
		.inst(inst),
		.ce(rom_ce)	
	);


endmodule