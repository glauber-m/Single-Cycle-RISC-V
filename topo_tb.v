module topo_tb();

    reg CLK;
    reg rst;

    topo uut (
        .CLK(CLK),
        .rst(rst)
    );
    always #5 CLK = ~CLK;
    initial begin
        $dumpfile("sim.vcd");
        $dumpvars(0, topo_tb);
        CLK = 0;
        rst = 1;
        #10 rst = 0;
        #1000 $stop;
    end

endmodule