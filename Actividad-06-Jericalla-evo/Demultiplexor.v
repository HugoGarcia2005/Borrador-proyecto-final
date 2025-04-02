module Demultiplexor(
	input [31:0] DR1_DEMUX,
	input OP_DEMUX,
	output reg [31:0] DR1_ALU_DEMUX,
	output reg [31:0] DR1_MEM_DEMUX
);

always @* begin
	DR1_ALU_DEMUX = 32'd0;
	DR1_MEM_DEMUX = 32'd0;

	case (OP_DEMUX)
		1'b1: DR1_MEM_DEMUX = DR1_DEMUX;
		1'b0: DR1_ALU_DEMUX = DR1_DEMUX;
	endcase
end
endmodule