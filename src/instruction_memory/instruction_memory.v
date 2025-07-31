`timescale 1ns / 100ps

module instruction_memory(
    input  wire [31:0] A,  //  endereco
    output wire [31:0] RD  //  dados
);

    //  declara a memoria rom
    reg [31:0] rom [0:255];

    //  le os dados do endereco selecionado
    assign RD = rom[A >> 2];

endmodule
