`timescale 1ns / 100ps

module data_memory(
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

endmodule
