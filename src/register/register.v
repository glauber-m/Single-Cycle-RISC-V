module register #(parameter N = 32)(
    input CLK,        
    input rst,
    input [N-1:0] d,     
    output reg [N-1:0] q
);

    always @(posedge CLK or posedge rst) begin
        if (rst) begin
            q <= {N{1'b0}};
        end else begin
            q <= d;
        end
    end
endmodule
