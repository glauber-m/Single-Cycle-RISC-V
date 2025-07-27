`timescale 1ns / 1ns

module topo_tb();

    // Declara sinais do DUT
    reg CLK;
    reg rst;

    // Cria instancia do DUT
    topo DUT (
        .CLK(CLK),
        .rst(rst)
    );

    // Gera sinal de clock com periodo de 20ns (f=50MHz)
    initial #0  CLK = 1'b0;
    always  #10 CLK = ~CLK;

    // Gera pulso de reset durante terceiro e quarto ciclo de clock
    initial #0  rst = 1'b0;
    initial #45 rst = 1'b1;
    initial #75 rst = 1'b0;

    // Task para adicionar linhas de monitoramento ao log da simulacao
    task print_line();
        $display(
            "| %3tns |",
            $time
        );
    endtask

    initial begin
        // Abre arquivo VCD para o DUT com profundidade 1
        $dumpfile("sim.vcd");
        $dumpvars(0, DUT);

        $display("Iniciando teste da microarquitetura RISC-V single cycle...");
        $display("----------------------------------------------------------");
        $display("| Tempo |");
        $display("----------------------------------------------------------");

        // Mostra o estado do sistema antes e apos o reset
        @(posedge rst) print_line();
        @(negedge rst) print_line();

        // Monitora o estado do sistema durante o carregamento das instrucoes
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

        // Suspende a execucao do teste para analise
        $stop;

        $display("Encerrando teste da microarquitetura RISC-V single cycle...");
        $finish;
    end

endmodule
