`timescale 1ns/1ns

module Colparity 
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

integer i, x, y, prev_i, present_i, slice = 0;

reg [0:24] in_temp;
reg [0:24] prev_slice;
reg [0:24] present_slice;
reg x1, x2, x3;

always @(posedge clock, posedge reset) begin
    if (reset) begin
        slice = 0;
    end
    else if (start && slice == 0) begin
        mem_r = 1;
        mem_adr = 63;
        mem_w = 0;
        #1;
        prev_slice <= in;
        #1;
        mem_adr = slice;
        #1;
        present_slice <= in;
        #1;
        for (i = 0 ; i < 25 ; i = i + 1) begin 
            x = i % 5;
            present_i = (x - 1) % 5;
            if (present_i < 0) begin
                present_i = present_i + 5;
            end
            prev_i = (x + 1) % 5;

            x1 = present_slice[i];
            x2 = prev_slice[prev_i] ^ prev_slice[prev_i + 5] ^ 
                 prev_slice[prev_i + 10] ^ prev_slice[prev_i + 15] ^ prev_slice[prev_i + 20];

            x3 = present_slice[present_i] ^ present_slice[present_i + 5] ^ 
                 present_slice[present_i + 10] ^ present_slice[present_i + 15] ^ present_slice[present_i + 20];
            #1;
            in_temp[i] <= x1 ^ x2 ^ x3;
            #1;
        end

        #5;
        mem_r = 0;
        mem_w = 1;
        #1;
        mem_in = in_temp;
        #5;
        slice = slice + 1;
        #1;
        mem_r = 0;
        mem_w = 0;
        #1;
        prev_slice <= present_slice;
        #1;
    end

    else if (start && slice < 64) begin
        mem_r = 1;
        mem_w = 0;
        mem_adr = slice;
        #1;
        present_slice <= in;
        #1;
        for (i = 0 ; i < 25 ; i = i + 1) begin 
            x = i % 5;
            present_i = (x - 1) % 5;
            prev_i = (x + 1) % 5;
            if (present_i < 0) begin
                present_i = present_i + 5;
            end

            x1 = present_slice[i];
            x2 = prev_slice[prev_i] ^ prev_slice[prev_i + 5] ^ 
                 prev_slice[prev_i + 10] ^ prev_slice[prev_i + 15] ^ prev_slice[prev_i + 20];

            x3 = present_slice[present_i] ^ present_slice[present_i + 5] ^ 
                 present_slice[present_i + 10] ^ present_slice[present_i + 15] ^ present_slice[present_i + 20];
            #1;
            in_temp[i] <= x1 ^ x2 ^ x3;
            #1;
        end

        #5;
        mem_r = 0;
        mem_w = 1;
        #1;
        mem_in = in_temp;
        #5;
        slice = slice + 1;
        #1;
        mem_r = 0;
        mem_w = 0;
        #1;
        prev_slice <= present_slice;
        #1;
    end
    else begin
        mem_r = 0;
        mem_w = 0;
    end
end

assign done = (slice == 64) ? 1 : 0;
endmodule