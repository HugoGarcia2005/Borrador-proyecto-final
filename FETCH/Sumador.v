module SUMADOR (	
	input [31:0]operando,
	output reg [31:0]suma
);

always @* begin
	suma = operando + 4;
end

endmodule 
