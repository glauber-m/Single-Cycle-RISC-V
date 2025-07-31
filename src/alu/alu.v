`timescale 1ns / 100ps

module alu(
    input  wire [31:0] SrcA,       // Primeiro operando
    input  wire [31:0] SrcB,       // Segundo operando
    input  wire [2:0]  ALUControl, // Seleciona a operacao
    output wire        Zero,       // Flag de zero
    output reg  [31:0] ALUResult   // Saida numerica da ALU
);

    wire [31:0] switch_b;     // Operando selecionado para soma ou subtracao
    wire        cin_adder;    // Carry do somador, ativo para subtracao
    wire [31:0] result_adder; // Saida do somador, para soma ou subtracao
    wire [31:0] result_and;
    wire [31:0] result_or;
    wire [31:0] result_slt;

    // Instancia do somador com arvore binaria
    adder adder0(
        .a_in   (SrcA),
        .b_in   (switch_b),
        .car_in (cin_adder),
        .result (result_adder)
    );

    // Flag para resultado igual a zero
    assign Zero = (ALUResult == 32'h00000000);

    // Adapta o somador para subtracao nas operacoes 3'b001 (sub) e 3'b101 (slt)
    assign switch_b  = (!ALUControl[1] && ALUControl[0]) ? (~SrcB) : SrcB;
    assign cin_adder = (!ALUControl[1] && ALUControl[0]);

    // Implementa as operacoes bitwise
    assign result_and = SrcA & SrcB;
    assign result_or  = SrcA | SrcB;

    // Logica para a operacao Set Less Than:
    // Para A e B com sinais opostos, utiliza o bit de sinal de A (1 se A < 0)
    // Para A e B com mesmo sinal, utiliza o bit de sinal da subtracao A - B (1 se A < B)
    assign result_slt[31:1] = {31{1'b0}};
    assign result_slt[0] = (SrcA[31] ^ SrcB[31]) ? SrcA[31] : result_adder[31];

    // Seleciona o resultado com base no codigo de controle
    always @(*) begin
        case(ALUControl)
            3'b000:  ALUResult = result_adder; // 000: Adiciona      = A + B
            3'b001:  ALUResult = result_adder; // 001: Subtrai       = A - B
            3'b010:  ALUResult = result_and;   // 010: Bitwise and   = A & B
            3'b011:  ALUResult = result_or;    // 011: Bitwise or    = A | B
            3'b101:  ALUResult = result_slt;   // 101: Set less than = A < B ? 1 : 0
            default: ALUResult = 32'h00000000; // Instrucoes nao implementadas
        endcase
    end

endmodule
