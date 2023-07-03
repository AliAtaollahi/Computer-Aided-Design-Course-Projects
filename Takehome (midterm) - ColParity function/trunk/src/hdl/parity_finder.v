module parity_finder(
    in,
    out
);
    input [24 : 0] in;
    output [4 : 0] out;
    wire [4 : 0] out_;

    assign out_ = in[4:0] ^ in[9:5] ^ in[14:10] ^ in[19:15] ^ in[24:20];
    assign out = {out_[0], out_[4 : 1]};

endmodule