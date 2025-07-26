module extend_tb;

    reg [24:0] in;
    reg [1:0] ImmSrc;
    wire [31:0] out;
    extend dut (.in(in), .ImmSrc(ImmSrc), .out(out));

    initial begin
        in = 25'hF0F0F0F;
        ImmSrc = 2'b00; // I-type
        #10;
        $display("I-type: out = %h", out);

        ImmSrc = 2'b01; // S-type
        #10;
        $display("S-type: out = %h", out);

        ImmSrc = 2'b10; // B-type
        #10;
        $display("B-type: out = %h", out);

        ImmSrc = 2'b11; // J-type
        #10;
        $display("J-type: out = %h", out);
        $stop;
    end
endmodule