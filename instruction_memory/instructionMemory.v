module instructionMemory (
    input wire rst,
    input wire [31:0] A, //endereço
    output reg [31:0] RD //dados
);
    
    reg [31:0] rom [0:255];

    initial begin
        $readmemh("/home/cidigital/cidigital/circuitos_III/projeto/data.txt", rom);
    end

    // Lê os dados da ROM na borda sensível
    always @(*) begin
        if(rst)RD<=0;
        else RD = rom[A];
    end
endmodule