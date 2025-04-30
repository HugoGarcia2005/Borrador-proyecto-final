module MUX (
	input [31:0] Mem_data,
	input [31:0] Alu_data,
	input Sel,
	output reg [31:0] W_data_BR
);

always @* begin
	if (Sel) begin
		W_data_BR = Mem_data;
	end
	else begin
		W_data_BR = Alu_data;
	end
end

endmodule

