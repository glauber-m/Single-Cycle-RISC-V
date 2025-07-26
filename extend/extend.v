module extend(in, ImmSrc, out);

    input wire [24:0] in;
    input wire [1:0] ImmSrc;
    output reg [31:0] out;

    //ImmSrc --> 0 para load e 1 para store
    //ImmSrc --> 00: tipo I, 01: tipo S, 10 tipo B

    wire [31:0] aux;

    assign aux[31:7] = in;
    assign aux[6:0] = 7'b0; //zero padding

    always@(*)begin  
        case (ImmSrc)
            2'b00: begin
                out <= {{20{aux[31]}},aux[31:20]};
            end
            2'b01: begin
                out <= {{20{aux[31]}},aux[31:25],aux[11:7]};
            end
            2'b10: begin
                out <= {{20{aux[31]}},aux[7],aux[30:25],aux[11:8],1'b0};
            end
            2'b11:begin
                out <= {{12{aux[31]}},aux[19:12],aux[20],aux[30:21],1'b0};
            end
            default: out <= 32'd0;
        endcase
    end
endmodule

/*
00 {{20{Instr[31]}}, Instr[31:20]} I 12-bit signed immediate
01 {{20{Instr[31]}}, Instr[31:25], Instr[11:7]} S 12-bit signed immediate
10 {{20{Instr[31]}}, Instr[7], Instr[30:25], Instr[11:8], 1’b0} B 13-bit signed immediate
11 {{12{Instr[31]}}, Instr[19:12], Instr[20], Instr[30:21], 1’b0} J 21-bit signed immediate
*/