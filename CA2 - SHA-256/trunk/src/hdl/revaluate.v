`timescale 1ns/1ns

module Revaluate 
(
    input [0:24] in,
    input start,
    input clock,
    input reset,
    output reg done,
    output reg [5:0] mem_adr,
    output reg [0:24] mem_in,
    output reg mem_r,
    output reg mem_w 
);

integer i, y, x1, x2, slice = 0;

reg [0:24] in_temp;
// reg a, b, c;

always @(posedge clock, posedge reset) begin
    if (reset) begin
        slice = 0;
    end
    else if (start && slice < 64) begin
        mem_r = 1;
        mem_adr = slice;
        mem_w = 0;

        for (i = 0 ; i < 25 ; i = i + 1) begin
            y  = i / 5;
            x1 = y * 5 + (i + 1) % 5;
            x2 = y * 5 + (i + 2) % 5;
            #1;
            // a = in[i];
            // b = in[x1];
            // c = in[x2];
            in_temp[i] <= in[i] ^ ((~in[x1]) & (in[x2]));
        end
        #5
        mem_r = 0;
        mem_w = 1;
        #1
        mem_in = in_temp;
        #5
        slice = slice + 1;
        #1
        mem_r = 0;
        mem_w = 0;
    end
    else begin
        mem_r = 0;
        mem_w = 0;
    end
end

assign done = (slice == 64) ? 1 : 0;
endmodule