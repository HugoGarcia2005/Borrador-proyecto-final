module MEM_INST(
	input [3:0] address,
	output reg [17:0]dataOut
);

reg [17:0] mem_inst [0:15];

initial begin
	$readmemb("Instrucciones.txt",mem_inst);
end

always @* begin
	dataOut=mem_inst[address];
end

endmodule