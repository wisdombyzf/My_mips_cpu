/**
* 	author:zf
*	data:2018/1/21
*	param: 
*	return:
*	brief£ºmy_mips_sopcÄ£¿é
*/
`include "defines.v"
`timescale 1ns/1ps

module test_my_mips_sopc();

  reg CLOCK_50;
  reg rst;
  
       
  initial 
  begin
    CLOCK_50 = 1'b0;
    forever #10 CLOCK_50 = ~CLOCK_50;
  end
      
  initial 
  begin
    rst = `enable_signal;
    #195 rst= `disable_signal;
    #1000 $stop;
  end
       
  my_mips_sopc openmips_min_sopc0(
		.clk(CLOCK_50),
		.rst(rst)	
	);

endmodule