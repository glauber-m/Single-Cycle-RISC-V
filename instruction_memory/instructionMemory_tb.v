module instructionMemory_tb;
    reg rst;
    reg [31:0] A;
    wire [31:0] D;

    integer i;

    instructionMemory instructionMemory (rst, A,D);

    initial begin
        rst = 1;
        #10 rst = 0;
        #10
        for(i=0;i<256;i=i+1)begin
            A= i;
            #10;
            if(D)begin 
                $display("\nNo endereco %d temos o dado %h", i, D);
            end
        end
        $display("\nO restante das memorias nao foram definidas");
        $stop;
    end

endmodule