module RAM(
	input [31:0] address,
	input [31:0] datoIn,
	input W,
	input R,
	output reg [31:0] datoOut
);

reg [31:0] mem_ram [0:127]; 

always @* begin
	if (W&&R)begin 
		datoOut=32'd0;
	end
	else if(W)begin
		mem_ram[address]=datoIn;
	end
	else if(R)begin
		datoOut=mem_ram[address];
	end
	else begin
		datoOut=32'd0;
	end
end

endmodule

