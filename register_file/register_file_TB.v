module register_file_TB;
    localparam DATA_WIDTH = 32;
    localparam ADDR_WIDTH = 5;// 4 registros ; 2 bits de endereço
    localparam REG_COUNT = 32;

    reg clk, rst;
    reg WE3 ;
    reg [DATA_WIDTH -1:0] WD3 ;
    reg [ADDR_WIDTH -1:0] A1 ;
    reg [ADDR_WIDTH -1:0] A2 ;
    reg [ADDR_WIDTH -1:0] A3 ;

    wire[DATA_WIDTH -1:0] RD1 ;
    wire[DATA_WIDTH -1:0] RD2 ;


    integer i;

    register_file #(32,5,32) dut
    (clk,rst, WE3, WD3, A1, A2, A3, RD1, RD2,);

    always #1 clk = ~clk;

    initial begin
        clk = 0;
        for (i = 0; i < REG_COUNT-1; i = i + 1) begin
            A1 = i;
            A2 = i;
            #2;
        end

        WE3 = 1;

        for (i = 0; i < REG_COUNT-1; i = i + 1) begin
            A3 = i; WD3 = i; #2;
        end

        for (i = 0; i < REG_COUNT-1; i = i + 1) begin
            A1 = i; A2 = i; #2;
        end
        $stop;
    end



endmodule