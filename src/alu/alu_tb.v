`timescale 1ns / 100ps

module alu_tb();

    reg  [31:0] SrcA;
    reg  [31:0] SrcB;
    reg  [2:0]  ALUControl;
    wire        Zero;
    wire [31:0] ALUResult;

    // Instancia da unidade sob teste
    alu uut(
        .SrcA       (SrcA),
        .SrcB       (SrcB),
        .ALUControl (ALUControl),
        .Zero       (Zero),
        .ALUResult  (ALUResult)
    );

    reg        Zero_tb;
    reg [31:0] ALUResult_tb;

    // Modelo comportamental para referencia
    always @(*) begin
        Zero_tb = (ALUResult_tb == 0);
    end
    always @(*) begin
        case(ALUControl)
            3'b000:  ALUResult_tb = SrcA + SrcB;
            3'b001:  ALUResult_tb = SrcA - SrcB;
            3'b010:  ALUResult_tb = SrcA & SrcB;
            3'b011:  ALUResult_tb = SrcA | SrcB;
            3'b101:  ALUResult_tb = $signed(SrcA) < $signed(SrcB);
            default: ALUResult_tb = 0;
        endcase
    end

    // Task para registrar resultados auto-verificados em formato de tabela
    task print_line();
        begin
            $write(
                "| %3dns | b%3b (%s) | h%8h | h%8h | h%8h |   b%1b |",
                $time,
                ALUControl,
                (ALUControl == 3'b000) ? "add" :
                (ALUControl == 3'b001) ? "sub" :
                (ALUControl == 3'b010) ? "and" :
                (ALUControl == 3'b011) ? " or" :
                (ALUControl == 3'b101) ? "slt" :
                "---",
                SrcA,
                SrcB,
                ALUResult,
                Zero
            );
            if(ALUResult == ALUResult_tb) begin
                $write("  ok ");
            end else begin
                $write(" ERRO");
            end
            if(Zero == Zero_tb) begin
                $write("  ok ");
            end else begin
                $write(" ERRO");
            end
            $display(" |");
        end
    endtask

    // Sequencia de estimulos e verificacoes com informativos
    initial begin
        $display("-----------------------------------------------------------------------------");
        $display("> Teste da ALU iniciado em %0dns", $time);
        $display("-----------------------------------------------------------------------------");
        $display("| Tempo | ALUControl |      SrcA |      SrcB | ALUResult | Zero | AutoCheck |");
        $display("-----------------------------------------------------------------------------");

        // Teste da operacao ADD
        ALUControl = 3'b000;
        SrcA = 32'h00000000;
        SrcB = 32'h00000000;
        #10 print_line();
        SrcA = 32'h00001234;
        SrcB = 32'h00005678;
        #10 print_line();
        SrcA = 32'hffffffff;
        SrcB = 32'h00000001;
        #10 print_line();
        SrcA = 32'h80e0e0e0;
        SrcB = 32'h80203040;
        #10 print_line();

        // Teste da operacao SUB
        ALUControl = 3'b001;
        SrcA = 32'h00005678;
        SrcB = 32'h00001234;
        #10 print_line();
        SrcA = 32'h00001234;
        SrcB = 32'h00001234;
        #10 print_line();
        SrcA = 32'h00000000;
        SrcB = 32'h00000001;
        #10 print_line();
        SrcA = 32'h7fffffff;
        SrcB = 32'hffffffff;
        #10 print_line();

        // Teste da operacao AND
        ALUControl = 3'b010;
        SrcA = 32'hffffffff;
        SrcB = 32'h01000010;
        #10 print_line();
        SrcA = 32'ha5a5a5a5;
        SrcB = 32'h5a5a5a5a;
        #10 print_line();
        SrcA = 32'hf0f0f0f0;
        SrcB = 32'h0f0f0f0f;
        #10 print_line();
        SrcA = 32'h12345678;
        SrcB = 32'h87654321;
        #10 print_line();

        // Teste da operacao OR
        ALUControl = 3'b011;
        SrcA = 32'hffff0000;
        SrcB = 32'h0000ffff;
        #10 print_line();
        SrcA = 32'h00000000;
        SrcB = 32'h11112222;
        #10 print_line();
        SrcA = 32'h1c1c1c1c;
        SrcB = 32'hc1c1c1c1;
        #10 print_line();
        SrcA = 32'hf0f0f0f0;
        SrcB = 32'h0f0f0f0f;
        #10 print_line();

        // Teste da operacao SLT
        ALUControl = 3'b101;
        SrcA = 32'h00000100;
        SrcB = 32'h00000130;
        #10 print_line();
        SrcA = 32'h00000340;
        SrcB = 32'h00000050;
        #10 print_line();
        SrcA = 32'hffffff33;
        SrcB = 32'hffffffee;
        #10 print_line();
        SrcA = 32'h12345678;
        SrcB = 32'hfedcba98;
        #10 print_line();

        // Teste do caso default
        ALUControl = 3'b110;
        SrcA = 32'h12341234;
        SrcB = 32'habcdabcd;
        #10 print_line();

        $display("-----------------------------------------------------------------------------");
        $display("> Teste da ALU finalizado em %0dns", $time);
        $display("-----------------------------------------------------------------------------");
        $finish;
    end

endmodule
