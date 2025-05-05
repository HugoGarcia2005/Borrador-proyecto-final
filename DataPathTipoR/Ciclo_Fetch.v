module FETCH (
	input clk,
	input reset,
	output [31:0] instruccion
);

wire [31:0] pc_sumador_address;
wire [31:0] sumador_pc;

PC pc_fetch(
	.contador(sumador_pc),
	.clk(clk),
	.reset(reset),
	.acumulador(pc_sumador_address)
);

SUMADOR sumador_fetch(	
	.operando(pc_sumador_address),
	.suma(sumador_pc)
);

MEM_INST mem_inst_fetch(
	.address(pc_sumador_address),
	.dataOut(instruccion)
);

endmodule