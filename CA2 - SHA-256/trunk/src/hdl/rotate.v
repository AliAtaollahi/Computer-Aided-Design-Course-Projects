`timescale 1ns/1ns

module Rotate 
(
    input [0:63] in,
    input start,
    input clock,
    input reset,
    output reg done,
    output reg [4:0] mem_adr,
    output reg [0:63] mem_in,
    output reg mem_r,
    output reg mem_w
);

integer i, x, y, final_index, lane = 0;

reg [0:63] in_temp;

reg [5:0] f [0:4] [0:4];

initial begin
    f[0][0] = 0;
    f[0][1] = 36;
    f[0][2] = 3;
    f[0][3] = 41;
    f[0][4] = 18;
    f[1][0] = 1;
    f[1][1] = 44;
    f[1][2] = 10;
    f[1][3] = 45;
    f[1][4] = 2;
    f[2][0] = 62;
    f[2][1] = 6;
    f[2][2] = 43;
    f[2][3] = 15;
    f[2][4] = 61;
    f[3][0] = 28;
    f[3][1] = 55;
    f[3][2] = 25;
    f[3][3] = 21;
    f[3][4] = 56;
    f[4][0] = 27;
    f[4][1] = 20;
    f[4][2] = 39;
    f[4][3] = 8;
    f[4][4] = 14;
end

reg [5:0] rotate_f;

always @(posedge clock, posedge reset) begin
    if (reset) begin
        lane = 0;
    end
    else if (start && lane < 25) begin
        mem_r = 1;
        mem_adr = lane;
        mem_w = 0;

        x = ((lane % 5) + 3) % 5;
        y = ((lane / 5) + 3) % 5;

        rotate_f = f[x][y];

        for (i = 0 ; i < 64 ; i = i + 1) begin 
            #1;
            in_temp[(i + rotate_f) % 64] <= in[i];
        end
        #5
        mem_r = 0;
        mem_w = 1;
        #1
        mem_in = in_temp;
        #5
        lane = lane + 1;
        #1
        mem_r = 0;
        mem_w = 0;
    end
    else begin
        mem_r = 0;
        mem_w = 0;
    end
end

assign done = (lane == 25) ? 1 : 0;
endmodule