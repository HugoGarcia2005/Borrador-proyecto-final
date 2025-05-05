module AC (
	input [2:0] AluOp, 
	input [5:0] Funct,
	output reg [3:0] Op
);

always @* begin
	case (AluOp)
		//R-type
		3'b010:
			case (Funct)
				//add
				6'b100000:
				begin
					Op = 4'b0010;
				end
				//subtract
				6'b100010:
				begin
					Op = 4'b0110;
				end
				//AND
				6'b100100:
				begin
					Op = 4'b0000;
				end
				//OR
				6'b100101:
				begin
					Op = 4'b0001;
				end
				//set on less than
				6'b101010:
				begin
					Op = 4'b0111;
				end
				
				6'b000000:
				begin
					Op = 4'b1111;
				end
			endcase
		//SW/LW
		3'b000:
		begin
			Op = 4'b0010;
		end
		//branch equal
		3'b001:
		begin 
			Op = 4'b0110;
		end
	endcase
end

endmodule