`timescale 1ns / 100ps

module adder_tb();

    // unidade sob teste
    reg  [31:0] a_in;
    reg  [31:0] b_in;
    reg         car_in;
    wire [31:0] result;
    wire        car_out;
    adder uut(
        .a_in    (a_in),
        .b_in    (b_in),
        .car_in  (car_in),
        .result  (result),
        .car_out (car_out)
    );

    // descricao comportamental para referencia
    reg [31:0] result_tb;
    reg        car_out_tb;
    always @(*) begin
        {car_out_tb, result_tb} = {1'b0, a_in} + {1'b0, b_in} + {{32{1'b0}}, car_in};
    end

    // sequencia de estimulos e verificacoes
    reg done;
    initial begin
        $display("teste 1: inicializa todos os bits de entrada com 0 e varre o conjunto a_in[31:16] de 0000 ate ffff");
        a_in   = 32'h00000000;
        b_in   = 32'h00000000;
        car_in = 1'b0;
        done   = 1'b0;
        while(done == 1'b0) #(1) begin
            if((result != result_tb) || (car_out != car_out_tb)) begin
                $display("erro:     a_in=h%8h b_in=h%8h car_in=b%1b result=h%8h car_out=b%1b", a_in, b_in, car_in, result,    car_out);
                $display("esperado: a_in=h%8h b_in=h%8h car_in=b%1b result=h%8h car_out=b%1b", a_in, b_in, car_in, result_tb, car_out_tb);
                $finish;
            end else if (a_in[31:16] < 16'hffff) begin
                a_in[31:16] = a_in[31:16] + 16'h0001;
            end else begin
                done = 1'b1;
            end
        end
        $display("sucesso: teste 1 executado sem erro");

        $display("teste 2: inicializa todos os bits de entrada com 0 e varre o conjunto a_in[23:8] de 0000 ate ffff");
        a_in   = 32'h00000000;
        b_in   = 32'h00000000;
        car_in = 1'b0;
        done   = 1'b0;
        while(done == 1'b0) #(1) begin
            if((result != result_tb) || (car_out != car_out_tb)) begin
                $display("erro:     a_in=h%8h b_in=h%8h car_in=b%1b result=h%8h car_out=b%1b", a_in, b_in, car_in, result,    car_out);
                $display("esperado: a_in=h%8h b_in=h%8h car_in=b%1b result=h%8h car_out=b%1b", a_in, b_in, car_in, result_tb, car_out_tb);
                $finish;
            end else if (a_in[23:8] < 16'hffff) begin
                a_in[23:8] = a_in[23:8] + 16'h0001;
            end else begin
                done = 1'b1;
            end
        end
        $display("sucesso: teste 2 executado sem erro");

        $display("teste 3: inicializa todos os bits de entrada com 0 e varre o conjunto a_in[15:0] de 0000 ate ffff");
        a_in   = 32'h00000000;
        b_in   = 32'h00000000;
        car_in = 1'b0;
        done   = 1'b0;
        while(done == 1'b0) #(1) begin
            if((result != result_tb) || (car_out != car_out_tb)) begin
                $display("erro:     a_in=h%8h b_in=h%8h car_in=b%1b result=h%8h car_out=b%1b", a_in, b_in, car_in, result,    car_out);
                $display("esperado: a_in=h%8h b_in=h%8h car_in=b%1b result=h%8h car_out=b%1b", a_in, b_in, car_in, result_tb, car_out_tb);
                $finish;
            end else if (a_in[15:0] < 16'hffff) begin
                a_in[15:0] = a_in[15:0] + 16'h0001;
            end else begin
                done = 1'b1;
            end
        end
        $display("sucesso: teste 3 executado sem erro");

        $display("teste 4: inicializa todos os bits de entrada com 0 e varre o conjunto b_in[31:16] de 0000 ate ffff");
        a_in   = 32'h00000000;
        b_in   = 32'h00000000;
        car_in = 1'b0;
        done   = 1'b0;
        while(done == 1'b0) #(1) begin
            if((result != result_tb) || (car_out != car_out_tb)) begin
                $display("erro:     a_in=h%8h b_in=h%8h car_in=b%1b result=h%8h car_out=b%1b", a_in, b_in, car_in, result,    car_out);
                $display("esperado: a_in=h%8h b_in=h%8h car_in=b%1b result=h%8h car_out=b%1b", a_in, b_in, car_in, result_tb, car_out_tb);
                $finish;
            end else if (b_in[31:16] < 16'hffff) begin
                b_in[31:16] = b_in[31:16] + 16'h0001;
            end else begin
                done = 1'b1;
            end
        end
        $display("sucesso: teste 4 executado sem erro");

        $display("teste 5: inicializa todos os bits de entrada com 0 e varre o conjunto b_in[23:8] de 0000 ate ffff");
        a_in   = 32'h00000000;
        b_in   = 32'h00000000;
        car_in = 1'b0;
        done   = 1'b0;
        while(done == 1'b0) #(1) begin
            if((result != result_tb) || (car_out != car_out_tb)) begin
                $display("erro:     a_in=h%8h b_in=h%8h car_in=b%1b result=h%8h car_out=b%1b", a_in, b_in, car_in, result,    car_out);
                $display("esperado: a_in=h%8h b_in=h%8h car_in=b%1b result=h%8h car_out=b%1b", a_in, b_in, car_in, result_tb, car_out_tb);
                $finish;
            end else if (b_in[23:8] < 16'hffff) begin
                b_in[23:8] = b_in[23:8] + 16'h0001;
            end else begin
                done = 1'b1;
            end
        end
        $display("sucesso: teste 5 executado sem erro");

        $display("teste 6: inicializa todos os bits de entrada com 0 e varre o conjunto b_in[15:0] de 0000 ate ffff");
        a_in   = 32'h00000000;
        b_in   = 32'h00000000;
        car_in = 1'b0;
        done   = 1'b0;
        while(done == 1'b0) #(1) begin
            if((result != result_tb) || (car_out != car_out_tb)) begin
                $display("erro:     a_in=h%8h b_in=h%8h car_in=b%1b result=h%8h car_out=b%1b", a_in, b_in, car_in, result,    car_out);
                $display("esperado: a_in=h%8h b_in=h%8h car_in=b%1b result=h%8h car_out=b%1b", a_in, b_in, car_in, result_tb, car_out_tb);
                $finish;
            end else if (b_in[15:0] < 16'hffff) begin
                b_in[15:0] = b_in[15:0] + 16'h0001;
            end else begin
                done = 1'b1;
            end
        end
        $display("sucesso: teste 6 executado sem erro");

        $display("teste 7: inicializa todos os bits de entrada com 1 e varre o conjunto a_in[31:16] de ffff ate 0000");
        a_in   = 32'hffffffff;
        b_in   = 32'hffffffff;
        car_in = 1'b1;
        done   = 1'b0;
        while(done == 1'b0) #(1) begin
            if((result != result_tb) || (car_out != car_out_tb)) begin
                $display("erro:     a_in=h%8h b_in=h%8h car_in=b%1b result=h%8h car_out=b%1b", a_in, b_in, car_in, result,    car_out);
                $display("esperado: a_in=h%8h b_in=h%8h car_in=b%1b result=h%8h car_out=b%1b", a_in, b_in, car_in, result_tb, car_out_tb);
                $finish;
            end else if (a_in[31:16] > 16'h0000) begin
                a_in[31:16] = a_in[31:16] - 16'h0001;
            end else begin
                done = 1'b1;
            end
        end
        $display("sucesso: teste 7 executado sem erro");

        $display("teste 8: inicializa todos os bits de entrada com 1 e varre o conjunto a_in[23:8] de ffff ate 0000");
        a_in   = 32'hffffffff;
        b_in   = 32'hffffffff;
        car_in = 1'b1;
        done   = 1'b0;
        while(done == 1'b0) #(1) begin
            if((result != result_tb) || (car_out != car_out_tb)) begin
                $display("erro:     a_in=h%8h b_in=h%8h car_in=b%1b result=h%8h car_out=b%1b", a_in, b_in, car_in, result,    car_out);
                $display("esperado: a_in=h%8h b_in=h%8h car_in=b%1b result=h%8h car_out=b%1b", a_in, b_in, car_in, result_tb, car_out_tb);
                $finish;
            end else if (a_in[23:8] > 16'h0000) begin
                a_in[23:8] = a_in[23:8] - 16'h0001;
            end else begin
                done = 1'b1;
            end
        end
        $display("sucesso: teste 8 executado sem erro");

        $display("teste 9: inicializa todos os bits de entrada com 1 e varre o conjunto a_in[15:0] de ffff ate 0000");
        a_in   = 32'hffffffff;
        b_in   = 32'hffffffff;
        car_in = 1'b1;
        done   = 1'b0;
        while(done == 1'b0) #(1) begin
            if((result != result_tb) || (car_out != car_out_tb)) begin
                $display("erro:     a_in=h%8h b_in=h%8h car_in=b%1b result=h%8h car_out=b%1b", a_in, b_in, car_in, result,    car_out);
                $display("esperado: a_in=h%8h b_in=h%8h car_in=b%1b result=h%8h car_out=b%1b", a_in, b_in, car_in, result_tb, car_out_tb);
                $finish;
            end else if (a_in[15:0] > 16'h0000) begin
                a_in[15:0] = a_in[15:0] - 16'h0001;
            end else begin
                done = 1'b1;
            end
        end
        $display("sucesso: teste 9 executado sem erro");

        $display("teste 10: inicializa todos os bits de entrada com 1 e varre o conjunto b_in[31:16] de ffff ate 0000");
        a_in   = 32'hffffffff;
        b_in   = 32'hffffffff;
        car_in = 1'b1;
        done   = 1'b0;
        while(done == 1'b0) #(1) begin
            if((result != result_tb) || (car_out != car_out_tb)) begin
                $display("erro:     a_in=h%8h b_in=h%8h car_in=b%1b result=h%8h car_out=b%1b", a_in, b_in, car_in, result,    car_out);
                $display("esperado: a_in=h%8h b_in=h%8h car_in=b%1b result=h%8h car_out=b%1b", a_in, b_in, car_in, result_tb, car_out_tb);
                $finish;
            end else if (b_in[31:16] > 16'h0000) begin
                b_in[31:16] = b_in[31:16] - 16'h0001;
            end else begin
                done = 1'b1;
            end
        end
        $display("sucesso: teste 10 executado sem erro");

        $display("teste 11: inicializa todos os bits de entrada com 1 e varre o conjunto b_in[23:8] de ffff ate 0000");
        a_in   = 32'hffffffff;
        b_in   = 32'hffffffff;
        car_in = 1'b1;
        done   = 1'b0;
        while(done == 1'b0) #(1) begin
            if((result != result_tb) || (car_out != car_out_tb)) begin
                $display("erro:     a_in=h%8h b_in=h%8h car_in=b%1b result=h%8h car_out=b%1b", a_in, b_in, car_in, result,    car_out);
                $display("esperado: a_in=h%8h b_in=h%8h car_in=b%1b result=h%8h car_out=b%1b", a_in, b_in, car_in, result_tb, car_out_tb);
                $finish;
            end else if (b_in[23:8] > 16'h0000) begin
                b_in[23:8] = b_in[23:8] - 16'h0001;
            end else begin
                done = 1'b1;
            end
        end
        $display("sucesso: teste 11 executado sem erro");

        $display("teste 12: inicializa todos os bits de entrada com 1 e varre o conjunto b_in[15:0] de ffff ate 0000");
        a_in   = 32'hffffffff;
        b_in   = 32'hffffffff;
        car_in = 1'b1;
        done   = 1'b0;
        while(done == 1'b0) #(1) begin
            if((result != result_tb) || (car_out != car_out_tb)) begin
                $display("erro:     a_in=h%8h b_in=h%8h car_in=b%1b result=h%8h car_out=b%1b", a_in, b_in, car_in, result,    car_out);
                $display("esperado: a_in=h%8h b_in=h%8h car_in=b%1b result=h%8h car_out=b%1b", a_in, b_in, car_in, result_tb, car_out_tb);
                $finish;
            end else if (b_in[15:0] > 16'h0000) begin
                b_in[15:0] = b_in[15:0] - 16'h0001;
            end else begin
                done = 1'b1;
            end
        end
        $display("sucesso: teste 12 executado sem erro");

        $finish;
    end

endmodule
