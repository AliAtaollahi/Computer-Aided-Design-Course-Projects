`timescale 1ns/1ns

module testbench();
    reg clk = 1'b1, rst = 1'b0, start = 1'b0;
    permutation_func #("file/input_2.txt", "file/output_2.txt") pf(clk, rst, start);
    initial begin
        repeat(1000) #2 clk = ~clk;
    end
    initial begin
        #10 start = 1'b1;
        #10 start = 1'b0;
        #10000 $stop;
    end
endmodule