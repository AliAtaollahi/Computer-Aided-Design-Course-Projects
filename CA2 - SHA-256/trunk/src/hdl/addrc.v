`timescale 1ns/1ns

module Addrc 
(
    input [0:63] in,
    input start,
    input clock,
    input reset,
    input [4:0] turn,
    output reg done,
    output reg [4:0] mem_adr,
    output reg [0:63] mem_in,
    output reg mem_r,
    output reg mem_w
);

integer i, x, y, final_index, lane = 0;

reg [0:63] in_temp;

reg [0:63] rc [0:23];

initial begin
    done = 0;
    rc[0]  = 64'h0000000000000001;
    rc[1]  = 64'h0000000000008082;
    rc[2]  = 64'h800000000000808A;
    rc[3]  = 64'h8000000080008000;
    rc[4]  = 64'h000000000000808B;
    rc[5]  = 64'h0000000080000001;
    rc[6]  = 64'h8000000080008081;
    rc[7]  = 64'h8000000000008009;
    rc[8]  = 64'h000000000000008A;
    rc[9]  = 64'h0000000000000088;
    rc[10] = 64'h0000000080008009;
    rc[11] = 64'h000000008000000A;
    rc[12] = 64'h000000008000808B;
    rc[13] = 64'h800000000000008B;
    rc[14] = 64'h8000000000008089;
    rc[15] = 64'h8000000000008003;
    rc[16] = 64'h8000000000008002;
    rc[17] = 64'h8000000000000080;
    rc[18] = 64'h000000000000800A;
    rc[19] = 64'h800000008000000A;
    rc[20] = 64'h8000000080008081;
    rc[21] = 64'h8000000000008080;
    rc[22] = 64'h0000000080000001;
    rc[23] = 64'h8000000080008008;
end

always @(posedge clock, posedge reset) begin
    if (reset) begin
        done = 0;
    end
    else if (start && ~done) begin
        mem_r = 1;
        mem_adr = 5'd12;
        mem_w = 0;
        #3;
        in_temp = in;
        #2;
        in_temp = in_temp ^ rc[turn];
        #2
        mem_in = in_temp;
        #5;
        mem_r = 0;
        mem_w = 1;
        done = 1;
        #2;
        mem_w = 0;
        #2;
    end
    else begin
        mem_r = 0;
        mem_w = 0;
    end
end

endmodule