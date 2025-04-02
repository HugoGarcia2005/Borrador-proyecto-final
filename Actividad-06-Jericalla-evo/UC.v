module UNIDAD_CONTROL (
	input [2:0] op_code,
	output reg wEnable_BR,
	output reg SEL_dmx,
	output reg [3:0] OP_alu,
	output reg W_ram,
	output reg R_ram
);

always @* begin
	case (op_code)
		3'b000:
			begin
			wEnable_BR=1'b1;
			SEL_dmx=1'b0;
			OP_alu=4'b0010;
			W_ram=1'b0;
			R_ram=1'b0;
			end
		3'b001:
			begin
			wEnable_BR=1'b1;
			SEL_dmx=1'b0;
			OP_alu=4'b0110;
			W_ram=1'b0;
			R_ram=1'b0;
			end
		3'b010:
			begin
			wEnable_BR=1'b1;
			SEL_dmx=1'b0;
			OP_alu=4'b0111;
			W_ram=1'b0;
			R_ram=1'b0;
			end
		3'b011:
			begin
			wEnable_BR=1'b0;
			SEL_dmx=1'b1;
			OP_alu=4'b0010;
			W_ram=1'b1;
			R_ram=1'b0;
			end
		3'b100:
			begin
			wEnable_BR=1'b0;
			SEL_dmx=1'b1;
			OP_alu=4'b1111;
			W_ram=1'b0;
			R_ram=1'b1;
			end
		default:
			begin
			wEnable_BR=1'b0;
			SEL_dmx=1'b1;
			OP_alu=4'b1111;
			W_ram=1'b0;
			R_ram=1'b0;
			end
	endcase
end

endmodule
