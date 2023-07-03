`timescale 1ns/1ns

module  parity #(parameter read_file_name, write_file_name) (
    clk,
    ld,
    start
);
    input clk, ld, start;
    wire rst, read_input, write_input, rst_counter25, rst_counter6bit , rst_in_reg, count_en , ld_ppr, counter25_en, counter6bit_en;
    wire done;
    wire cout25, cout6bit;
    dp #(read_file_name, write_file_name) 
        dp_(clk, rst, ld, read_input, write_input, rst_counter25, rst_in_reg, counter25_en, ld_ppr,counter6bit_en, rst_counter6bit, cout25, cout6bit);
    cu cu_(start, clk, cout25, cout6bit, rst_counter25, rst_in_reg, read_input, ld_ppr, counter25_en, counter6bit_en, write_input, rst_counter6bit, done);

endmodule