module regfile(	input clk,
				        input reset,
                input we3, 
                input [4:0] ra1, ra2, wa3,
                input [31:0] wd3,
                output [31:0] rd1, rd2);

    reg [31:0] rf[31:0];
    integer i;

// three ported register file
// read two ports combinationally
// write third port on rising edge of clk
// register 0 hardwired to 0
// note: for pipelined processor, write third port
// on falling edge of clk
always @(*)
	if (reset)
		for(i = 0; i < 32; i = i + 1)
			rf[i] <= 32'hxxxxxxxx;

always @(posedge clk) 
 	#1  if (we3) rf[wa3] <= wd3;
  assign #1 rd1 = (ra1 != 0) ? rf[ra1] : 0;
  assign #1 rd2 = (ra2 != 0) ? rf[ra2] : 0;
endmodule