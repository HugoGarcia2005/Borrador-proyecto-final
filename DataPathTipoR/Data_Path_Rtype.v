module DPTR (
	input [31:0] instruccion,
	output ZF_DPTR
);

wire uc_br;
wire W_uc_mem;
wire R_uc_mem;
wire uc_mux;
wire [2:0] uc_ac;
wire [31:0] c1;
wire [31:0] c2;
wire [31:0] c3;
wire [3:0] c4;
wire [31:0] c5;
wire [31:0] c6;

UC uc_dptr(
	.OpCode(instruccion[31:26]),
	.MemToReg(uc_mux),
	.MemToRead(R_uc_mem),
	.MemToWrite(W_uc_mem),
	.AluOp(uc_ac),
	.RegWrite(uc_br)
);

BR br_dptr(
	.R_register_1(instruccion[25:21]),
	.R_register_2(instruccion[20:16]),
	.W_register(instruccion[15:11]),
	.W_data(c6),
	.RegEn(uc_br),
	.R_data_1(c2),
	.R_data_2(c1)
);

AC ac_dptr(
	.AluOp(uc_ac), 
	.Funct(instruccion[5:0]),
	.Op(c4)
);

ALU alu_dptr(
	.Op_1(c2),
	.Op_2(c1),
	.Op_Alu(c4),
	.ZF(ZF_DPTR),
	.Res(c3)
);

MEM mem_dptr(
	.address(c3),
	.W_data(c1),
	.Write(W_uc_mem),
	.Read(R_uc_mem),
	.R_data(c5)
);

MUX mux_dptr(
	.Mem_data(c5),
	.Alu_data(c3),
	.Sel(uc_mux),
	.W_data_BR(c6)
);

endmodule