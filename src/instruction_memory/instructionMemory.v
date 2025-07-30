module instructionMemory (
    input  wire [31:0] A, // endereco
    output      [31:0] RD // dados
);

    reg [31:0] rom [0:255];

    initial begin
        $readmemh("C:/CI_Digital/Trabalho/Single-Cycle-RISC-V/src/instruction_memory/test_1.txt", rom);
    end

    // Le os dados da ROM
    assign RD = rom[A >> 2];

endmodule
