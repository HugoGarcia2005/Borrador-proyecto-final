`timescale 1ns/1ns
module DataPath_TB();
reg [31:0] instruccion;
wire ZF_DPTR;

DPTR DPTR_TB(
	.instruccion(instruccion),
	.ZF_DPTR(ZF_DPTR)
);

initial begin
	instruccion = 32'b00000001111010011010000000100010;
	#20;
	instruccion = 32'b00000010100010011010000000100010;
	#20;
	instruccion = 32'b00000000101011110111100000100000;
	#20;
	instruccion = 32'b00000001001011110111100000100000;
	#20;
	instruccion = 32'b00000010100011111010100000101010;
	#20;
end
endmodule