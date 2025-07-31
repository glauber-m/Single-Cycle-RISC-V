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
        dut.dataMem.mem[32'h00002008] = 32'h0000000A;
        dut.dataMem.mem[32'h0000200C] = 32'h00000001;
    end

    // inicializa posicoes do instruction_memory com programa de teste
    initial begin
        // $readmemh("/home/daniel/Single-Cycle-RISC-V-main/src/instruction_memory/data.txt", dut.instMem.rom);
        $readmemh("C:/CI_Digital/Trabalho/Single-Cycle-RISC-V/src/instruction_memory/data.txt", dut.instMem.rom);
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
    initial #(75) rst = 1'b0;

    // task para adicionar linhas de monitoramento ao log da simulacao
    task print_line();
        $display(
            "| %3dns |",
            $time
        );
    endtask

    initial begin
        // abre arquivo vcd para o dut
        $dumpfile("sim.vcd");
        $dumpvars(0, dut);

        $display("Iniciando teste da microarquitetura RISC-V single cycle...");
        $display("----------------------------------------------------------");
        $display("| Tempo |");
        $display("----------------------------------------------------------");

        // mostra o estado do sistema antes e apos o reset
        @(posedge rst) print_line();
        @(negedge rst) print_line();

        // monitora o estado do sistema durante o carregamento das instrucoes
        $display("Carregando primeira instrucao: sub x3, x3, x1");
        $display("Comportamento esperado: glu glu glu");
        @(negedge CLK) print_line();

        $display("Carregando segunda instrucao: slt x4, x2, x3");
        $display("Comportamento esperado: glu glu glu");
        @(negedge CLK) print_line();

        $display("Carregando terceira instrucao: beq x4, x0, L1");
        $display("Comportamento esperado: glu glu glu");
        @(negedge CLK) print_line();

        $display("Carregando quarta instrucao: add x5, x2, x1");
        $display("Comportamento esperado: glu glu glu");
        @(negedge CLK) print_line();

        repeat (40) @(negedge CLK); // temporario, para terminar a execucao

        // suspende a execucao do teste para analise
        $stop;

        $display("Encerrando teste da microarquitetura RISC-V single cycle...");
        $finish;
    end

endmodule
