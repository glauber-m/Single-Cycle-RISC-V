`timescale 1ns / 100ps

module register#(
    parameter N = 32
)(
    input  wire CLK,
    input  wire rst,
    input  wire [N-1:0] d,
    output reg  [N-1:0] q
);

    always @(posedge CLK or posedge rst) begin
        if (rst) begin
            q <= {N{1'b0}};
        end else begin
            q <= d;
        end
    end

endmodule
