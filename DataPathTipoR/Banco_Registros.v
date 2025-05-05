module BR (
    input clk,
    input [4:0] R_register_1,
    input [4:0] R_register_2,
    input [4:0] W_register,
    input [31:0] W_data,
    input RegEn,
    output reg [31:0] R_data_1,
    output reg [31:0] R_data_2
);

    reg [31:0] MEM_BANCO [0:31];

    initial begin
        $readmemb("DatosBR.txt", MEM_BANCO);
    end

always @* begin
	R_data_1=MEM_BANCO[R_register_1];
	R_data_2=MEM_BANCO[R_register_2];
end


    always @(posedge clk) begin
        if (RegEn) begin
            MEM_BANCO[W_register] <= W_data;
        end
    end

endmodule