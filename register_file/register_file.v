module register_file #(
    parameter DATA_WIDTH = 32,
    parameter ADDR_WIDTH = 5,// 4 registros, 2 bits de endereço
    parameter REG_COUNT = 32
)(
    input wire clk,rst,
    input wire WE3,
    input wire [DATA_WIDTH -1:0] WD3,
    input wire [ADDR_WIDTH -1:0] A1,
    input wire [ADDR_WIDTH -1:0] A2,
    input wire [ADDR_WIDTH -1:0] A3,
    output wire [DATA_WIDTH -1:0] RD1,
    output wire [DATA_WIDTH -1:0] RD2
);

    // Banco de registradores
    reg [DATA_WIDTH -1:0] registers [0:REG_COUNT -1];
    integer i;

    // Escrita síncrona
    always @(posedge clk) begin
        if (rst) begin
            for (i = 0; i < REG_COUNT; i=i+1 ) registers[i] <= 0;
            registers[5] <= 6; // Inicializando o registrador 5 com 6
            registers[9] <= 32'h2004; // Inicializando o registrador 9 com 2004h
        end
            
        else begin
            if (WE3 && A3 != 0) registers[A3] <= WD3;
        end
            
    end

    // // Leitura combinacional (assíncrona)
    assign RD1 = registers[A1];
    assign RD2 = registers[A2];

endmodule