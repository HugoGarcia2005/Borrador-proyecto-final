module PC(
	input [31:0]contador,
	input clk,
	output reg [31:0]acumulador
);

always @(posedge clk) begin
	acumulador = acumulador + contador;
end

endmodule
