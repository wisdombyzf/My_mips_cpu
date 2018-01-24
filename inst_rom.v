/**
* 	author:zf
*	data:2018/1/21
*	param: 
*	return:
*	brief£ºÖ¸Áî´¢´æÆ÷Ä£¿é
*/
`include "defines.v"

module inst_rom(

//	input	wire										clk,
	input wire ce,
	input wire[`inst_addr_bus_width] addr,
	output reg[`InstBus] inst
	
);

	reg[`InstBus] inst_mem[0:`InstMemNum-1];

	initial $readmemh ( "inst_rom.data", inst_mem );

	always @ (*) 
	begin
		if (ce == `disable_signal) 
			begin
				inst <= `zero_word;
			end 
		else 
			begin
			inst <= inst_mem[addr[`InstMemNumLog2+1:2]];
			end
	end

endmodule