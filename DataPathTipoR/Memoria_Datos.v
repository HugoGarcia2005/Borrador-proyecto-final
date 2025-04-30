module MEM (
	input [31:0] address,
	input [31:0] W_data,
	input Write,
	input Read,
	output reg [31:0] R_data
);

reg [31:0] MEM_DATOS [0:127]; 

always @* begin
	if (Write&&Read)begin 
		R_data=32'd0;
	end
	else if(Write)begin
		MEM_DATOS[address]=W_data;
	end
	else if(Read)begin
		R_data=MEM_DATOS[address];
	end
	else begin
		R_data=32'd0;
	end
end

endmodule
