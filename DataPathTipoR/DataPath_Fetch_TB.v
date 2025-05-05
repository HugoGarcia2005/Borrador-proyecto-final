`timescale 1ns/1ns
module DPTR_FETCH_F1_TB();

reg clk;
reg reset;

wire zf;

DPTR_FETCH_F1 f1_tb(
	.clk_f1(clk),
	.reset_f1(reset),
	.zf_f1(zf)
);

initial begin
        clk = 0;       
        forever #10 clk = ~clk;  
end

initial begin
	reset = 1'b1;
	#5;
	reset = 1'b0;
	#200;
	$stop;
end

endmodule


