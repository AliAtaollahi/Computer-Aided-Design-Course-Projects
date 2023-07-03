module prev_parity_reg5bit(
    in,
    clk,
    rst,
    ld,
    out
);
    input [4 : 0] in;
    reg [4 : 0] out_;
    output [4 : 0] out;
    input clk, rst;
    input ld;

    always @(posedge clk, posedge rst, ld) begin
        if (rst)
            out_ <= 5'd0;
        else
            if (ld) begin
                out_[0] <= in[3];
                out_[1] <= in[4];
                out_[2] <= in[0];
                out_[3] <= in[1];
                out_[4] <= in[2];
            end
    end
    assign out = out_;

endmodule