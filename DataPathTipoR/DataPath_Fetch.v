module DPTR_FETCH_F1 (
	input clk_f1,
	input reset_f1,
	output zf_f1
);

wire [31:0] c1;

FETCH fetch_f1 (
	.clk(clk_f1),
	.reset(reset_f1),
	.instruccion(c1)
);

DPTR dtpr_f1(
	.clk_dtpr(clk_f1),
	.instruccion(c1),
	.ZF_DPTR(zf_f1)
);

endmodule