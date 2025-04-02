module BUFFER_2 (
	input dataIn_wE_BR,
	input dataIn_W_ram,
	input dataIn_R_ram,
	input [31:0]dataIn_DW_alu,
	input [31:0]dataIn_DR1,
	input [31:0]dataIn_DR2,
	input [4:0] waIn_BR,
	input clk,
	output reg dataOut_wE_BR,
	output reg dataOut_W_ram,
	output reg dataOut_R_ram,
	output reg [31:0]dataOut_DW_alu,
	output reg [31:0]dataOut_DR1,
	output reg [31:0]dataOut_DR2,
	output reg [4:0] waOut_BR
);

always @(posedge clk) begin
	dataOut_wE_BR = dataIn_wE_BR;
	dataOut_W_ram = dataIn_W_ram;
	dataOut_R_ram = dataIn_R_ram;
	dataOut_DW_alu = dataIn_DW_alu;
	dataOut_DR1 = dataIn_DR1;
	dataOut_DR2 = dataIn_DR2;
	waOut_BR = waIn_BR;
end

endmodule