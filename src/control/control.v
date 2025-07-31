`timescale 1ns / 100ps

module control(
    PCSrc, ResultSrc, MemWrite, ALUControl, ALUSrc, ImmSrc, RegWrite,
    op, funct3, funct7, Zero
);
    input       [6:0]   op;
    input       [2:0]   funct3;
    input               funct7;
    input               Zero;

    output              PCSrc;
    output reg          ResultSrc;
    output reg          MemWrite;
    output reg  [2:0]   ALUControl;
    output reg          ALUSrc;
    output reg  [1:0]   ImmSrc;
    output reg          RegWrite;

    reg                 Branch;
    reg         [1:0]   ALUOp;

    assign PCSrc = Zero & Branch;

    // Main Decoder
    always @(*) begin
        ResultSrc <= 0;
        MemWrite <= 0;
        ALUControl <= 3'b111;
        ALUSrc <= 0;
        ImmSrc <= 2'b00;
        RegWrite <= 0;
        Branch <= 0;
        ALUOp <= 2'b00;

        case (op)
            // LW
            7'b000_0011: begin
                RegWrite <= 1;
                ALUSrc <= 1;
                ResultSrc <= 1;
                ALUOp <= 2'b00;
            end

            // SW
            7'b010_0011: begin
                MemWrite <= 1;
                ALUSrc <= 1;
                ImmSrc <= 2'b01;
                ALUOp <= 2'b00;
            end

            // R-type
            7'b011_0011: begin
                RegWrite <= 1;
                ALUOp <= 2'b10;
            end

            // BEQ
            7'b110_0011: begin
                ImmSrc <= 2'b10;
                Branch <= 1;
                ALUOp <= 2'b01;
            end

            // ADDI
            7'b0010011: begin
                RegWrite <= 1;
                ALUSrc <= 1;
                ALUOp <= 2'b10;
            end

            default: begin
                ResultSrc <= 0;
                MemWrite <= 0;
                ALUControl <= 3'b111;
                ALUSrc <= 0;
                ImmSrc <= 2'b00;
                RegWrite <= 0;
                Branch <= 0;
                ALUOp <= 2'b00;
            end
        endcase
    end

    //ALU Decoder
    always @(*) begin
        case (ALUOp)
            2'b00: ALUControl <= 3'b000; // ADD
            2'b01: ALUControl <= 3'b001; // SUB
            2'b10: begin
                case (funct3)
                    3'b000: ALUControl <= ({op[5], funct7} == 2'b11) ? 3'b001 : 3'b000; // ? SUB : ADD
                    3'b010: ALUControl <= 3'b101; // SLT
                    3'b110: ALUControl <= 3'b011; // OR
                    3'b111: ALUControl <= 3'b010; // AND
                    default: ALUControl <= 3'b111;
                endcase
            end
            default: ALUControl <= 3'b111;
        endcase
    end

endmodule
