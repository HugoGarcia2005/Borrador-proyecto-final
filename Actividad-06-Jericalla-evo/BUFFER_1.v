module BUFFER_1(
	input dataIn_wE_BR,
	input [3:0]dataIn_OP_alu,
	input dataIn_SEL_dmx,
	input dataIn_W_ram,
	input dataIn_R_ram,
	input [31:0]dataIn_DR1,
	input [31:0]dataIn_DR2,
	input [4:0] waIn_BR,
	input clk,
	output reg dataOut_wE_BR,
	output reg [3:0]dataOut_OP_alu,
	output reg dataOut_SEL_dmx,
	output reg dataOut_W_ram,
	output reg dataOut_R_ram,
	output reg [31:0]dataOut_DR1,
	output reg [31:0]dataOut_DR2,
	output reg [4:0] waOut_BR
);

always @(posedge clk) begin
	dataOut_wE_BR = dataIn_wE_BR;
	dataOut_OP_alu = dataIn_OP_alu;
	dataOut_SEL_dmx = dataIn_SEL_dmx;
	dataOut_W_ram = dataIn_W_ram;
	dataOut_R_ram = dataIn_R_ram;
	dataOut_DR1 = dataIn_DR1;
	dataOut_DR2 = dataIn_DR2;
	waOut_BR = waIn_BR;
end

endmodule