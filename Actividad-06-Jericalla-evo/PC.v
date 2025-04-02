module PC(
	input clk,
	input reset,
	output reg [3:0]contador
);

always @(posedge clk or posedge reset) begin
	if(reset)begin
		contador = 4'b0000;
	end
	else if(contador==4'b1111) begin
		contador = 4'b0000;
	end
	else begin
		contador = contador + 1; 
	end
end

endmodule

