module data_memory (
    input  wire        CLK,
    input  wire        WE,
    input  wire [31:0] A,
    input  wire [31:0] WD,
    output wire [31:0] RD
);

    reg [31:0] mem [0:65535];

    assign RD = mem[A];

    always @(posedge CLK) begin
        if (WE) begin
            mem[A] <= WD;
        end
    end

    initial begin
        // Initialize memory with some values for testing
        mem[32'h2000] = 32'h00000005; // Example data at address 0x2000
        mem[32'h2008] = 32'h0000000A; // Example data at address 0x2008
        mem[32'h200C] = 32'h00000001; // Example data at address 0x200C
    end

endmodule
