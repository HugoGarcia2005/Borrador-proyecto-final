`timescale 1ns/1ns
module TB_DEF_JERICALLA();

reg tb_reset_def_jericalla;
reg clk_def_jericalla;
wire tb_zf_def_jericalla;
wire [31:0]tb_dataOut_def_jericalla;

DEF_JERICALLA tb_def_jericalla(
	.reset_def_jericalla(tb_reset_def_jericalla),
	.clk_def_jericalla(clk_def_jericalla),
	.zf_def_jericalla(tb_zf_def_jericalla),
	.dataOut_def_jericalla(tb_dataOut_def_jericalla)
);

initial begin
        clk_def_jericalla = 0;       
        forever #10 clk_def_jericalla = ~clk_def_jericalla;  
end

initial begin 
	tb_reset_def_jericalla = 1'b1;
	#5;
	tb_reset_def_jericalla = 1'b0;
	#5;
end

endmodule


