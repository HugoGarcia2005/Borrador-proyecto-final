module DEF_JERICALLA(
	input reset_def_jericalla,
	input clk_def_jericalla,
	output zf_def_jericalla,
	output [31:0]dataOut_def_jericalla
);

wire [3:0]pc_memints;
wire [17:0]meminst_jericalla;

PC pc_def_jericalla(
	.clk(clk_def_jericalla),
	.reset(reset_def_jericalla),
	.contador(pc_memints)
);

MEM_INST meminst_def_jericalla(
	.address(pc_memints),
	.dataOut(meminst_jericalla)
);

JERICALLA_EVO jericalla__evo_def_jericalla(
	.instruccion(meminst_jericalla),
	.clk_jericalla(clk_def_jericalla),
	.zf_jericalla(zf_def_jericalla),
	.dataOut_jericalla(dataOut_def_jericalla)
);

endmodule