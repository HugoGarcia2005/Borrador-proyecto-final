module MEM_INST (
	input [31:0]address,
	output reg [31:0]dataOut
);

reg [7:0] mem_inst [0:999];

initial begin 
	$readmemb("Instrucciones.txt",mem_inst);
end

always @* begin
	dataOut = {mem_inst[address],mem_inst[address+1],mem_inst[address+2],mem_inst[address+3]};
end

endmodule