`timescale 1ns / 100ps

module top_tb();

    // declara sinais do dut
    reg CLK;
    reg rst;

    // cria instancia do dut
    top dut(
        .CLK(CLK),
        .rst(rst)
    );

    // inicializa posicoes do data_memory para teste
    initial begin
        dut.dataMem.mem[32'h00002000] = 32'h00000005;
        dut.dataMem.mem[32'h00002008] = 32'h0000000a;
        dut.dataMem.mem[32'h0000200c] = 32'h00000001;
    end

    // inicializa posicoes do instruction_memory com programa de teste
    initial begin
        $readmemh("/home/aluno/Single-Cycle-RISC-V-main/src/instruction_memory/test_1.txt", dut.instMem.rom);
    end

    // inicializa posicoes do register_file para teste
    initial begin
        dut.regFile.registers[0] <= 32'h00000000;
        dut.regFile.registers[9] <= 32'h00002004;
    end

    // gera sinal de clock com periodo de 20ns (f=50MHz)
    initial      CLK = 1'b0;
    always #(10) CLK = ~CLK;

    // gera pulso de reset durante terceiro e quarto ciclo de clock
    initial       rst = 1'b0;
    initial #(45) rst = 1'b1;
    initial #(85) rst = 1'b0;

    // task para adicionar linhas de monitoramento ao log da simulacao
    task print_line();
        begin
            $write(
                "| %3dns | h%8h | h%8h | h%8h | h%8h | h%8h | h%8h | h%8h | h%8h |",
                $time,
                dut.PC,
                dut.PCNext,
                dut.Instr,
                dut.ImmExt,
                dut.SrcA,
                dut.SrcB,
                dut.WriteData,
                dut.Result
            );
        end
    endtask

    reg [31:0] calc_before_clk;

    initial begin
        // abre arquivo vcd para o dut
        $dumpfile("sim.vcd");
        $dumpvars(0, dut);

        $display("Iniciando teste da microarquitetura RISC-V single cycle...");
        $display("---------------------------------------------------------------------------------------------------------------------");
        $display("| Tempo |        PC |    PCNext |     Instr |    ImmExt |      SrcA |      SrcB | WriteData |    Result | AutoCheck |");
        $display("---------------------------------------------------------------------------------------------------------------------");

        // mostra o estado do sistema antes e apos o reset
        @(posedge rst) print_line();
        $display(" ---       |");
        $display("\nAplicando reset: PC deve iniciar com h00000000 e PCNext com h00000004\n");
        @(negedge rst) print_line();
        if((dut.PC == 32'h00000000) && (dut.PCNext == 32'h00000004)) begin
            $display(" SUCCESS   |");
        end else begin
            $display(" FAILED    |");
        end

        // monitora o estado do sistema durante o carregamento de cada instrucao
        $display("\nInstr 1 | lw x1, 8(x9) -> ler dataMem[h200C, gravar em regFile[1]: = 1\n");
        calc_before_clk = dut.dataMem.mem[32'h0000200c];
        @(negedge CLK) print_line();
        if(dut.regFile.registers[1] == calc_before_clk) begin
            $display(" SUCCESS   |");
        end else begin
            $display(" FAILED    |");
        end

        $display("\nInstr 2 | lw x2, -4(x9) -> ler dataMem[h2000], gravar em regFile[2]: = 5\n");
        calc_before_clk = dut.dataMem.mem[32'h00002000];
        @(negedge CLK) print_line();
        if(dut.regFile.registers[2] == calc_before_clk) begin
            $display(" SUCCESS   |");
        end else begin
            $display(" FAILED    |");
        end

        $display("\nInstr 3 | lw x3, 4(x9) -> ler dataMem[h2008], gravar em regFile[3]: = 10\n");
        calc_before_clk = dut.dataMem.mem[32'h00002008];
        @(negedge CLK) print_line();
        if(dut.regFile.registers[3] == calc_before_clk) begin
            $display(" SUCCESS   |");
        end else begin
            $display(" FAILED    |");
        end

        while(dut.regFile.registers[2] < dut.regFile.registers[3]) begin
            $display("\nInstr 4 | L1: sub x3, x3, x1 -> calcular (regFile[3] - regFile[1]), gravar em regFile[3]: %0d - 1 = %0d\n", (calc_before_clk + 1), calc_before_clk);
            calc_before_clk = dut.regFile.registers[3] - dut.regFile.registers[1];
            @(negedge CLK) print_line();
            if(dut.regFile.registers[3] == calc_before_clk) begin
                $display(" SUCCESS   |");
            end else begin
                $display(" FAILED    |");
            end

            $display("\nInstr 5 | slt x4, x3, x2 -> comparar (regFile[3] < regFile[2]), gravar em regFile[4]: %0d < 5 = false (0)\n", calc_before_clk);
            calc_before_clk = (dut.regFile.registers[3] < dut.regFile.registers[2]) ? 32'h00000001 : 32'h00000000;
            @(negedge CLK) print_line();
            if(dut.regFile.registers[4] == calc_before_clk) begin
                $display(" SUCCESS   |");
            end else begin
                $display(" FAILED    |");
            end

            $display("\nInstr 6 | beq x4, x0, L1 -> comparar (regFile[4] == regFile[0]), se verdadeiro voltar a L1: 0 == 0 = true (volta)\n");
            calc_before_clk = dut.PC - 32'h00000008;
            @(negedge CLK) print_line();
            if(dut.PC == calc_before_clk) begin
                $display(" SUCCESS   |");
            end else begin
                $display(" FAILED    |");
            end
        end

        $display("\nInstr 4 | L1: sub x3, x3, x1 -> calcular (regFile[3] - regFile[1]), gravar em regFile[3]: 5 - 1 = 4\n");
        calc_before_clk = dut.regFile.registers[3] - dut.regFile.registers[1];
        @(negedge CLK) print_line();
        if(dut.regFile.registers[3] == calc_before_clk) begin
            $display(" SUCCESS   |");
        end else begin
            $display(" FAILED    |");
        end

        $display("\nInstr 5 | slt x4, x3, x2 -> comparar (regFile[3] < regFile[2]), gravar em regFile[4]: 4 < 5 = true (1)\n", calc_before_clk);
        calc_before_clk = (dut.regFile.registers[3] < dut.regFile.registers[2]) ? 32'h00000001 : 32'h00000000;
        @(negedge CLK) print_line();
        if(dut.regFile.registers[4] == calc_before_clk) begin
            $display(" SUCCESS   |");
        end else begin
            $display(" FAILED    |");
        end

        $display("\nInstr 6 | beq x4, x0, L1 -> comparar (regFile[4] == regFile[0]), se verdadeiro voltar a L1: 1 == 0 = false (continua)\n");
        calc_before_clk = dut.PC + 32'h00000004;
        @(negedge CLK) print_line();
        if(dut.PC == calc_before_clk) begin
            $display(" SUCCESS   |");
        end else begin
            $display(" FAILED    |");
        end

        $display("\nInstr 7 | add x5, x2, x1 -> calcular (regFile[2] + regFile[1]), gravar em regFile[5]: 5 + 1 = 6\n");
        calc_before_clk = dut.regFile.registers[2] + dut.regFile.registers[1];
        @(negedge CLK) print_line();
        if(dut.regFile.registers[5] == calc_before_clk) begin
            $display(" SUCCESS   |");
        end else begin
            $display(" FAILED    |");
        end

        $display("\nInstr 8 | and x6, x5, x0 -> calcular (regFile[5] & regFile[0]), gravar em regFile[6]: 6 & 0 = 0\n");
        calc_before_clk = dut.regFile.registers[5] & dut.regFile.registers[0];
        @(negedge CLK) print_line();
        if(dut.regFile.registers[6] == calc_before_clk) begin
            $display(" SUCCESS   |");
        end else begin
            $display(" FAILED    |");
        end

        $display("\nInstr 9 | or x6, x5, x0 -> calcular (regFile[5] | regFile[0]), gravar em regFile[6]: 6 | 0 = 6\n");
        calc_before_clk = dut.regFile.registers[5] | dut.regFile.registers[0];
        @(negedge CLK) print_line();
        if(dut.regFile.registers[6] == calc_before_clk) begin
            $display(" SUCCESS   |");
        end else begin
            $display(" FAILED    |");
        end

        $display("\nInstr 10 | sw x6, 0(x9) -> ler regFile[6], gravar em dataMem[regFile[9]]: = 6\n");
        calc_before_clk = dut.regFile.registers[6];
        @(negedge CLK) print_line();
        if(dut.dataMem.mem[dut.regFile.registers[9]] == calc_before_clk) begin
            $display(" SUCCESS   |");
        end else begin
            $display(" FAILED    |");
        end

        $display("\nInstr 11 | addi x7, x0, 2047 -> calcular (regFile[0] + 2047), gravar em regFile[7]: 0 + 2047 = 2047 (h000007ff)\n");
        calc_before_clk = dut.regFile.registers[0] + 2047;
        @(negedge CLK) print_line();
        if(dut.regFile.registers[7] == calc_before_clk) begin
            $display(" SUCCESS   |");
        end else begin
            $display(" FAILED    |");
        end

        // suspende a execucao do teste para analise
        $stop;

        $display("Encerrando teste da microarquitetura RISC-V single cycle...");
        $finish;
    end

endmodule
