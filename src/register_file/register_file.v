module register_file#(
    parameter DATA_WIDTH = 32,
    parameter ADDR_WIDTH = 5,
    parameter REG_COUNT  = 32
)(
    input  wire                  CLK,
    input  wire                  WE3,
    input  wire [ADDR_WIDTH-1:0] A1,
    input  wire [ADDR_WIDTH-1:0] A2,
    input  wire [ADDR_WIDTH-1:0] A3,
    input  wire [DATA_WIDTH-1:0] WD3,
    output wire [DATA_WIDTH-1:0] RD1,
    output wire [DATA_WIDTH-1:0] RD2
);

    // Banco de registradores
    reg [DATA_WIDTH-1:0] registers [0:REG_COUNT-1];

    // Leitura assincrona
    // Utiliza logica combinacional para o registro 0 (hardwired em 0)
    assign RD1 = (A1 != 0) ? registers[A1] : 0;
    assign RD2 = (A2 != 0) ? registers[A2] : 0;

    // Escrita sincrona
    // Protege contra escrita no registro 0
    always @(posedge CLK) begin
        if (WE3) begin
            if (A3 != 0) begin
                registers[A3] <= WD3;
            end
        end
    end

endmodule
