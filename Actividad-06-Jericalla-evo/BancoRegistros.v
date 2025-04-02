module BancoRegistros(
	input [4:0] RA1_BANCO,
	input [4:0] RA2_BANCO,
	input [4:0] WA_BANCO,
	input [31:0] DW_BANCO,
	input WE_BANCO,
	output reg [31:0] DR1_BANCO,
	output reg [31:0] DR2_BANCO
);

reg [31:0] MEM_BANCO [0:31];

initial begin
	$readmemb("DatosBR.txt",MEM_BANCO);
end

always @* begin
	DR1_BANCO=MEM_BANCO[RA1_BANCO];
	DR2_BANCO=MEM_BANCO[RA2_BANCO];
end

always @* begin
	if(WE_BANCO)begin
		MEM_BANCO[WA_BANCO]=DW_BANCO;
	end
end
endmodule
