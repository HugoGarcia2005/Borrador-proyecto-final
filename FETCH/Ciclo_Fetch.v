module FETCH (
	input clk,
	output instruccion
);

wire pc_sumador_address;
wire sumador_pc;

PC pc_fetch(
	.contador(sumador_pc),
	.clk(clk),
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