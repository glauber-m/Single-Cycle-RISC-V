module instructionMemory (
    input wire rst,
    input wire [31:0] A, //endereço
    output reg [31:0] RD //dados
);
    
    reg [31:0] rom [0:255];

    initial begin
        // $readmemh("/home/cidigital/cidigital/circuitos_III/projeto/data.txt", rom);
        $readmemh("C:/CI_Digital/Trabalho/Single-Cycle-RISC-V/instruction_memory/data.txt", rom);
        /*
        FFC4A303 L7 lw  x6, -4(x9)  // Result --> 10 (2000)
        0064A423  sw  x6, 8(x9)     // Result --> 10 (200C)
        0062E233  or  x4, x5, x6    // Result --> 1010(10) or 0110(6) = 1110(14) 
        FE420AE3  beq x4, x4, L7    // Result --> 
        */  
    end

    // Lê os dados da ROM na borda sensível
    always @(*) begin
        if(rst) RD <= 0;
        else RD = rom[(A >> 2)];
        //else if(A > 32'h0000_0000_0001_0000 && A<32'h0000_0000_0001_00FF) RD = rom[(A >> 2)];
    end
endmodule