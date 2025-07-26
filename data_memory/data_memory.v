module data_memory (
    input CLK, rst,
    input WE,
    input [31:0] A,
    input [31:0] WD,
    output [31:0] RD
);

    reg [31:0] mem [0:65535];

    always @(posedge CLK) begin
        if(rst)
            mem[32'h2000] <= 10;
        else
            if (WE) begin
                mem[A] <= WD;
            end
    end

    assign RD = mem[A];
    
endmodule