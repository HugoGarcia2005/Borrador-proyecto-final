`timescale 1ns/1ns
module Ciclo_Fetch_TestBench();

reg clk;
reg reset;
wire [31:0] instruccion;

FETCH FTB(
	.clk(clk),
	.reset(reset),
	.instruccion(instruccion)
);

initial begin
        clk = 0;       
        forever #20 clk = ~clk;  
end

initial begin 
	reset = 1'b1;
	#2;
	reset = 1'b0;
	#2;
end

endmodule