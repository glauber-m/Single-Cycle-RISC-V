module data_memory_tb;
    
    reg clk, rst; 
    reg WE;
    reg [31:0] A;
    reg [31:0] WD;
    wire [31:0] RD;

    data_memory dut(
        clk, rst,
        WE,
        A,
        WD,
        RD
    );

    integer i;

    always #1 clk = ~clk;

    initial begin
        clk = 0;
        rst = 1;
        A = 32'h2000;
        #2 rst = 0; 
        WE = 1;

        for (i = 0; i<10; i = i+1) begin
            A = i;
            WD = i+2;
            #2;
        end

        for (i = 9; i>=0; i = i-1) begin
            A = i;
            WD = i+3;
            #2;
        end

        #2 $stop;
    end

endmodule