`timescale 1ns / 100ps

module register_tb();

    // Testbench signals
    reg  CLK;
    reg  rst;
    reg  [7:0] d;
    wire [7:0] q;

    // Instantiate the Unit Under Test (UUT)
    register#(
        .N(8)
    ) UUT(
        .CLK(CLK),
        .rst(rst),
        .d(d),
        .q(q)
    );

    // Clock generation
    initial     CLK = 1'b0;
    always #(5) CLK = ~CLK;

    // Test sequence
    initial begin
        $display("--------------------------------");
        $display("Time=%3dns: Initial reset", $time);
        rst = 1'b1;
        d   = 8'h12;
        repeat (3) @(negedge CLK);

        $display("Time=%3dns: Releasing reset / Loading 8'h34", $time);
        rst = 1'b0;
        d   = 8'h34;
        repeat (3) @(negedge CLK);

        $display("Time=%3dns: Loading 8'h56", $time);
        rst = 1'b0;
        d   = 8'h56;
        repeat (3) @(negedge CLK);

        $display("Time=%3dns: Asserting reset", $time);
        rst = 1'b1;
        d   = 8'h78;
        repeat (3) @(negedge CLK);

        $display("Time=%3dns: Releasing reset / Loading 8'h90", $time);
        rst = 1'b0;
        d   = 8'h90;
        repeat (3) @(negedge CLK);

        $display("--------------------------------");
        $display("Time=%3dns: Simulation finished", $time);
        $finish;
    end

    // Display results
    always @(posedge CLK) begin
        #(1);
        $display("Time=%3dns: CLK=b%1b, rst=b%1b, d=h%2h, q=h%2h", $time, CLK, rst, d, q);
    end

endmodule
