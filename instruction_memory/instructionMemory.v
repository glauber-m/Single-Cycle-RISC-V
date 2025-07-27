module instructionMemory (
    input wire rst,
    input wire [31:0] A, //endereço
    output reg [31:0] RD //dados
);
    
    reg [31:0] rom [0:255];

    initial begin
        // $readmemh("/home/cidigital/cidigital/circuitos_III/projeto/test_0.txt", rom);
        $readmemh("C:/CI_Digital/Trabalho/Single-Cycle-RISC-V/instruction_memory/test_0.txt", rom);
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

/*
    pressupostos:
    data_mem[0x2000] = 5
    data_mem[0x2008] = 10
    data_mem[0x200C] = 1
    reg_file:
        reg[0] = 0 (hardwired)
        reg[9] = 0x2004 (inicialização)
            


    lw  x1, 8(x9)   // x1 ← mem[0x200C] = 1
    lw  x2, -4(x9)  // x2 ← mem[0x2000] = 5
    lw  x3, 4(x9)   // x3 ← mem[0x2008] = 10

L1: sub x3, x3, x1  // x3 ← x3 - x1 (decrementa x3)
    slt x4, x2, x3  // x4 ← (x2 < x3)? 1 : 0
    beq x4, x0, L1  // se x2 >= x3, sai do loop

    add x5, x2, x1      // x5 ← 5 + 1 = 6
    and x6, x5, x0      // x6 ← 6 & 0 = 0
    or  x6, x5, x0      // x6 ← 6 | 0 = 6
    sw  x6, 0(x9)       // mem[0x2004] ← 6

*/