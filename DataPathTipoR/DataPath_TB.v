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
	#5;
	instruccion = 32'b00000010100010011010100000100010;
	#5;
	instruccion = 32'b00000000101011111011000000100000;
	#5;
	instruccion = 32'b00000001001011111011100000100000;
	#5;
	instruccion = 32'b00000010100011111100000000101010;
end
endmodule