`timescale 1ns/1ns

module tb();
    reg clk = 1'b1, ld = 1'b1, start;
    parity #("file/input_0.txt", "output_0.txt") parity_(clk, ld, start);
    initial begin
        repeat(100000) #30 clk = ~clk;
    end
    initial begin
        #110 start = 1'b1;
        #110 start = 1'b0;
        #100000
        #100000 $stop;
    end
endmodule