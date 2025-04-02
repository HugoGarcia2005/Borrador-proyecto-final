module JERICALLA_EVO (
	input [17:0] instruccion,
	input clk_jericalla,
	output zf_jericalla,
	output [31:0]dataOut_jericalla
);

//Unidad de control a Banco de registros
wire uc_bff1_BR;//X
wire bff1_bff2_BR;
wire bff2_br_BR;//x
//Unidad de control a Dmx
wire uc__bff1_DMX;//X
wire bff1_dmx_DMX;
//D¿Unidad de control a Alu
wire [3:0]uc_bff1_ALU;//X
wire [3:0]bff1_alu_ALU;
//Unidad de control a W ram
wire uc_bff1_Wram;//X
wire bff1_bff2_Wram;
wire bff2_wram_Wram;
//Unidad de control a R ram
wire uc_bff1_Rram;//X
wire bff1_bff2_Rram;
wire bff2_rram_Rram;
//Banco de registros a Buffer 1
wire [31:0]dr1_bff1;//x
wire [31:0]dr2_bff1;//x
//Buffer 1 a Dmx
wire [31:0]bff1_dmx;
//Buffer 1 AluIn2 y Buffer 2
wire [31:0]bff1_aluin2_bff2;
//Buffer 2 a Alu en DWBR
wire [31:0]alu_bff2_DWBR;
wire [31:0]bff2_dwbr_DWBR;
//Dmx a Alu
wire [31:0]dmx_alu;
//Dmx a RAM
wire [31:0]dmx_bff2_RAM;
wire [31:0]bff2_ram_RAM;
//Buffer2 a DataInRAM
wire [31:0]bff2_dataINram;
//Entrada de instruccion a WA en Banco de registros
wire [4:0]bff1_bff2_WA;
wire [4:0]bff2_wa_WA;
	
UNIDAD_CONTROL uc_jericalla(
	.op_code(instruccion[17:15]),
	.wEnable_BR(uc_bff1_BR),
	.SEL_dmx(uc__bff1_DMX),
	.OP_alu(uc_bff1_ALU),
	.W_ram(uc_bff1_Wram),
	.R_ram(uc_bff1_Rram)
);

BancoRegistros br_jericalla(
	.RA1_BANCO(instruccion[9:5]),
	.RA2_BANCO(instruccion[4:0]),
	.WA_BANCO(bff2_wa_WA),
	.DW_BANCO(bff2_dwbr_DWBR),
	.WE_BANCO(bff2_br_BR),
	.DR1_BANCO(dr1_bff1),
	.DR2_BANCO(dr2_bff1)
);

BUFFER_1 buffer1_jericalla(
	.dataIn_wE_BR(uc_bff1_BR),
	.dataIn_OP_alu(uc_bff1_ALU),
	.dataIn_SEL_dmx(uc__bff1_DMX),
	.dataIn_W_ram(uc_bff1_Wram),
	.dataIn_R_ram(uc_bff1_Rram),
	.dataIn_DR1(dr1_bff1),
	.dataIn_DR2(dr2_bff1),
	.waIn_BR(instruccion[14:10]),
	.clk(clk_jericalla),
	.dataOut_wE_BR(bff1_bff2_BR),
	.dataOut_OP_alu(bff1_alu_ALU),
	.dataOut_SEL_dmx(bff1_dmx_DMX),
	.dataOut_W_ram(bff1_bff2_Wram),
	.dataOut_R_ram(bff1_bff2_Rram),
	.dataOut_DR1(bff1_dmx),
	.dataOut_DR2(bff1_aluin2_bff2),
	.waOut_BR(bff1_bff2_WA)
);

Demultiplexor dmx_jericalla(
	.DR1_DEMUX(bff1_dmx),
	.OP_DEMUX(bff1_dmx_DMX),
	.DR1_ALU_DEMUX(dmx_alu),
	.DR1_MEM_DEMUX(dmx_bff2_RAM)
);

ALU alu_jericalla(
	.DR1_ALU(dmx_alu),
	.DR2_ALU(bff1_aluin2_bff2),
	.OP_ALU(bff1_alu_ALU),
	.ZF_ALU(zf_jericalla),
	.DW_ALU(alu_bff2_DWBR)
);

BUFFER_2 buffer2_jericalla(
	.dataIn_wE_BR(bff1_bff2_BR),
	.dataIn_W_ram(bff1_bff2_Wram),
	.dataIn_R_ram(bff1_bff2_Rram),
	.dataIn_DW_alu(alu_bff2_DWBR),
	.dataIn_DR1(dmx_bff2_RAM),
	.dataIn_DR2(bff1_aluin2_bff2),
	.waIn_BR(bff1_bff2_WA),
	.clk(clk_jericalla),
	.dataOut_wE_BR(bff2_br_BR),
	.dataOut_W_ram(bff2_wram_Wram),
	.dataOut_R_ram(bff2_rram_Rram),
	.dataOut_DW_alu(bff2_dwbr_DWBR),
	.dataOut_DR1(bff2_ram_RAM),
	.dataOut_DR2(bff2_dataINram),
	.waOut_BR(bff2_wa_WA)
);

RAM ram_jericalla(
	.address(bff2_ram_RAM),
	.datoIn(bff2_dataINram),
	.W(bff2_wram_Wram),
	.R(bff2_rram_Rram),
	.datoOut(dataOut_jericalla)
);

endmodule