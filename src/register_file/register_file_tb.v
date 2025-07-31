`timescale 1ns / 1ns

module register_file_tb();

    localparam DATA_WIDTH = 32;
    localparam ADDR_WIDTH = 5;
    localparam REG_COUNT  = 32;

    reg                   CLK;
    reg                   WE3;
    reg  [ADDR_WIDTH-1:0] A1;
    reg  [ADDR_WIDTH-1:0] A2;
    reg  [ADDR_WIDTH-1:0] A3;
    reg  [DATA_WIDTH-1:0] WD3;
    wire [DATA_WIDTH-1:0] RD1;
    wire [DATA_WIDTH-1:0] RD2;

    register_file#(DATA_WIDTH, ADDR_WIDTH, REG_COUNT)
    dut(CLK, WE3, A1, A2, A3, WD3, RD1, RD2);

    integer i;

    initial     CLK = 1'b0;
    always #(1) CLK = ~CLK;

    initial begin
        WE3 = 1'b0;
        for (i = 0; i < REG_COUNT; i = i + 1) begin
            A1 = i;
            A2 = i;
            #(2);
        end

        WE3 = 1'b1;
        for (i = 0; i < REG_COUNT; i = i + 1) begin
            A3  = i;
            WD3 = i + 10;
            #(2);
        end

        WE3 = 1'b0;
        for (i = 0; i < REG_COUNT; i = i + 1) begin
            A1 = i;
            A2 = i;
            #(2);
        end

        $stop;
    end

endmodule
