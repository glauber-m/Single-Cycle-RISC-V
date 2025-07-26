module mux (
    input [31:0] in0, in1,
    input sel,
    output [31:0] d
);

    assign d = sel ? in1 : in0;
    
endmodule