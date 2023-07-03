`timescale 1ns/1ns

module permutation_func #(parameter read_file_name, write_file_name)(
    clk,
    rst,
    start
);
    input clk, rst, start;
    reg ld = 1'b1;
    wire [24:0] out;
    wire [5:0] pout;
    wire reset_counter, count, load_reg, reset_reg,ready, read_input, write_output, cout;
    cu c1 (start, clk, cout, reset_counter, count, load_reg, reset_reg, ready, read_input, write_output);
    counter6bit conter1(count, clk, reset_counter, pout, cout);
    dp #(read_file_name, write_file_name) dp_(clk, rst, ld, read_input, out);
endmodule