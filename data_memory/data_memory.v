module data_memory (
    input CLK, rst,
    input WE,
    input [31:0] A,
    input [31:0] WD,
    output [31:0] RD
);

    reg [31:0] mem [0:65535];
    initial begin
        integer i;
        for (i = 0; i < 65536; i = i + 1) begin
            mem[i] = 32'h00000000;
        end
    end
    always @(posedge CLK) begin
        if(rst) begin
            mem[32'h2000] <= 10;
        end else begin
            if (WE) begin
                if(A != 0) mem[A] <= WD;
            end
        end
    end

    assign RD = mem[A];
    
endmodule