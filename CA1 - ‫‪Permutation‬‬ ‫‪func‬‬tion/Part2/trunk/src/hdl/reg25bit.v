module reg25bit(
    in,
    out,
    clk,
    rst,
    ld
);
    input [24 : 0] in;
    output [24 : 0] out;
    reg [24 : 0] out_;
    input clk, rst;
    input ld;

    always @(posedge clk, posedge rst) begin
        if (rst)
            out_ <= 25'd0;
        else
            if (ld)
                out_ <= in;
    end
    assign out = out_;

endmodule