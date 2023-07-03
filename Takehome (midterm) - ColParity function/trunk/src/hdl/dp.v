`timescale 1ns/1ns

module  dp #(parameter read_file_name, write_file_name)(
    clk,
    rst,
    ld,
    read_input,
    write_input,
    rst_counter25,
    rst_in_reg,
    counter25_en,
    ld_ppr,
    counter6bit_en,
    rst_counter6bit,
    cout25,
    cout6bit
);
    wire [24:0] out1, out2;
    input clk, rst, read_input, write_input, rst_counter25, rst_in_reg, ld_ppr, counter6bit_en;
    input ld, counter25_en, rst_counter6bit;
    output cout25, cout6bit;
    reg [24:0] in_arr_temp, in1, in2, in2_;
    integer i, x, y, final_index, depth = 0;
    integer read_file_buffer, scan_file, write_file_buffer;

    initial begin
        depth = 0;
        read_file_buffer = $fopen(read_file_name, "r");
        write_file_buffer = $fopen(write_file_name, "w");
        $fclose(read_file_name);
        $fclose(write_file_name);
    end

    always @(posedge write_input) begin
        if (!(^out2 === 1'bx))
            $fdisplay(write_file_buffer, "%b", out2);
    end

    always @(posedge read_input) begin
        scan_file = $fscanf(read_file_buffer, "%b\n", in_arr_temp); 
    end

    always @(posedge read_input) begin : computation
        in1 <= in_arr_temp;
        if (depth < 66)
            depth = depth + 1;
    end

    wire [4 : 0] out3, out4;
    wire [4 : 0] count_;
    wire [5 : 0] count6bit;
    integer count;
    assign count = count_;

    always @(count) begin
        in2_[count - 2] <= ( out1[(count - 2)] ^ out3[(count - 2) % 5] ^ out4[(count - 2) % 5] );
    end
    
    assign in2 = in2_;

    reg25bit #(read_file_name) in_reg(in1, out1, clk, rst_in_reg, ld);
    reg25bit #(read_file_name) out_reg(in2, out2, clk, rst, ld);
    parity_finder pf(out1, out3);
    prev_parity_reg5bit ppr(out3, clk, rst, ld_ppr, out4);
    counter25 c25(counter25_en, clk, rst_counter25, count_, cout25);
    counter6bit c6b(counter6bit_en, clk, rst_counter6bit, count6bit, cout6bit);

endmodule