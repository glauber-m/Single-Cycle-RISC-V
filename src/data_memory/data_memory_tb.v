`timescale 1ns / 100ps

module data_memory_tb();

    reg         CLK;
    reg         WE;
    reg  [31:0] A;
    reg  [31:0] WD;
    wire [31:0] RD;

    data_memory dut(CLK, WE, A, WD, RD);

    integer i;

    initial     CLK = 1'b0;
    always #(1) CLK = ~CLK;

    initial begin
        WE = 1'b1;
        for (i = 0; i < 10; i = i + 1) begin
            A = i;
            WD = i + 3;
            #(2);
        end

        WE = 1'b0;
        for (i = 0; i < 10; i = i + 1) begin
            A = i;
            #(2);
        end

        $stop;
    end

endmodule
