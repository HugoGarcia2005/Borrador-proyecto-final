module UNIDAD_CONTROL (
	input [5:0] OpCode,
	output reg MemToReg,
	output reg MemToRead,
	output reg MemToWrite,
	output reg [2:0] OpAlu,
	output reg RegWrite
);

always @* begin
	case (OpCode)
		//Type-R
		6'b000000:
			begin
			MemToReg = 1'b0;
			MemToRead = 1'b0;
			MemToWrite = 1'b0;
			OpAlu = 3'b010;
			RegWrite = 1'b1;
			end
		//SW
		6'b101011:
		//LW
		6'b100011:
		default:
			begin
			
			end
	endcase
end

endmodule
