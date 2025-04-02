module ALU(
	input [31:0] DR1_ALU,
	input [31:0] DR2_ALU,
	input [3:0] OP_ALU,
	output reg ZF_ALU,
	output reg [31:0] DW_ALU
);

always @*
	begin
	case (OP_ALU)
	4'b0000: DW_ALU = DR1_ALU & DR2_ALU;
	4'b0001: DW_ALU = DR1_ALU | DR2_ALU;
	4'b0010: DW_ALU = DR1_ALU + DR2_ALU;
	4'b0110: DW_ALU = DR1_ALU - DR2_ALU;
	4'b0111: DW_ALU = (DR1_ALU < DR2_ALU)? 32'd1 : 32'd0;
	4'b1100: DW_ALU = ~(DR1_ALU | DR2_ALU);
	default: DW_ALU = 32'd0;
	endcase
	
	ZF_ALU = (DW_ALU == 1'b0)? 1'b1 : 1'b0;
end

endmodule