`timescale 1ns / 100ps

module control_tb();
    reg     [6:0]   op;
    reg     [2:0]   funct3;
    reg             funct7;
    reg             Zero;

    wire            PCSrc;
    wire            ResultSrc;
    wire            MemWrite;
    wire    [2:0]   ALUControl;
    wire            ALUSrc;
    wire    [1:0]   ImmSrc;
    wire            RegWrite;

    control dut(
        .PCSrc(PCSrc),
        .ResultSrc(ResultSrc),
        .MemWrite(MemWrite),
        .ALUControl(ALUControl),
        .ALUSrc(ALUSrc),
        .ImmSrc(ImmSrc),
        .RegWrite(RegWrite),
        .op(op),
        .funct3(funct3),
        .funct7(funct7),
        .Zero(Zero)
    );

    initial begin
        op = 7'h0;
        funct3 = 3'h0;
        funct7 = 0;
        Zero = 0;
        #10;
        op = 7'h03;
        #10;
        op = 7'h23;
        #10;
        op = 7'h63;
        #10;
        Zero = 1;
        #10;
        Zero = 0;
        op = 7'h33;
        #10;
        {op[5], funct7} = {op[5], funct7} + 1'b1;
        #10;
        {op[5], funct7} = {op[5], funct7} + 1'b1;
        #10;
        {op[5], funct7} = {op[5], funct7} + 1'b1;
        #10;
        {op[5], funct7} = {op[5], funct7} + 1'b1;
        #10;
        funct3 = 3'h2;
        #10;
        funct3 = 3'h6;
        #10;
        funct3 = 3'h7;
        #10;
        funct3 = 3'h1;
        #10;
        funct3 = 3'h3;
        #10;
        funct3 = 3'h4;
        #10;
        funct3 = 3'h5;
        #10;
        funct3 = 3'h0;
        #10;
        $stop;
    end

endmodule
