`timescale 1ns / 100ps

module mux_tb();

    reg  [31:0] in0;
    reg  [31:0] in1;
    reg         sel;
    wire [31:0] d;

    mux dut(in0, in1, sel, d);

    initial begin
        in0 = 32'hFFFFFFFF;
        in1 = 32'hEEEEEEEE;
        sel = 0; #10;
        sel = 1; #10;
        in0 = 32'h01234567;
        in1 = 32'h89ABCDEF;
        sel = 0; #10;
        sel = 1; #10;
        $stop;
    end

endmodule
