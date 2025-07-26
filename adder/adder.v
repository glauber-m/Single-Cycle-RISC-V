module adder(
    input  wire [31:0] OperandA,
    input  wire [31:0] OperandB,
    input  wire        CarryIn,
    output wire        CarryOut,
    output wire [31:0] Sum
);

    assign {CarryOut, Sum} = {1'b0, OperandA} + {1'b0, OperandB} + {{32{1'b0}}, CarryIn};

endmodule
