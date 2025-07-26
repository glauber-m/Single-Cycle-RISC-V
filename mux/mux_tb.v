module mux_tb;

    reg [31:0] in0, in1;
    reg sel;
    wire [31:0] d;

    mux dut (
        in0, in1,
        sel,
        d
    );

    initial begin
        in0 = 32'hFFFFFFFF;
        in1 = 32'hEEEEEEEE;
        #2;
        sel = 0;
        #2;
        sel = 1;
        #2$stop;
    end
    
endmodule