`timescale 1ns/1ns
module ALU (
	input [31:0] Op_1,
	input [31:0] Op_2,
	input [3:0] Op_Alu,
	output reg ZF,
	output reg [31:0] Res
);

always @*
	begin
	case (Op_Alu)
		//ADD
		4'b0010:
		begin
			Res = Op_1 + Op_2;
		end
		//SUB
		4'b0110:
		begin
			Res = Op_1 - Op_2;
		end
		//AND
		4'b0000:
		begin
			Res = Op_1 & Op_2;
		end
		//OR
		4'b0001:
		begin
			Res = Op_1 | Op_2;
		end
		//SLT
		4'b0111:
		begin
			Res = (Op_1 < Op_2)? 32'd1 : 32'd0;
		end
		
		4'b1111:
		begin
			Res = Op_2 << 1;
		end
		
		default: 
			Res = 32'd0;
	endcase
	
	ZF = (Res == 1'b0)? 1'b1 : 1'b0;
	//#100;
	
end

endmodule
