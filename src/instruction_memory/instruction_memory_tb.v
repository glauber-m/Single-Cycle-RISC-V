`timescale 1ns / 100ps

module instruction_memory_tb();

    reg  [31:0] A;
    wire [31:0] RD;

    instruction_memory dut(A, RD);

    // inicializa posicoes do instruction_memory com programa de teste
    initial begin
        $readmemh("/home/aluno/Single-Cycle-RISC-V-main/src/instruction_memory/test_1.txt", dut.rom);
    end

    initial begin
        $display("Lendo dados de todos os enderecos da memoria...");

        for(A = 0; A < 1024; A = A + 4) begin
            #(10);
            $display("Endereco: %3d | Dado: h%8h", (A >> 2), RD);
        end

        $finish;
    end

endmodule
