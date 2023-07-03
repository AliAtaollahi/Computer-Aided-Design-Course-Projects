`timescale 1ns/1ns

module  dp #(parameter read_file_name, write_file_name)(
    clk,
    rst,
    ld,
    read_input,
    out
);

    input clk, rst, read_input;
    input ld;
    output [24:0] out;
    reg [24:0] in_arr_temp, in;
    integer i, x, y, final_index, depth = 0;
    integer read_file_buffer, scan_file, write_file_buffer;

    initial begin
        depth = 0;
        read_file_buffer = $fopen(read_file_name, "r");
        write_file_buffer = $fopen(write_file_name, "w");
        $fclose(read_file_name);
        $fclose(write_file_name);
    end

    always @(depth) begin
        if (!(^in === 1'bx))
            $fdisplay(write_file_buffer, "%b", in);
        scan_file = $fscanf(read_file_buffer, "%b\n", in_arr_temp); 
    end

    always @(read_input) begin : computation
        for (i = 0 ; i < 25 ; i = i + 1) begin 
            x = ((i % 5) + 3) % 5;
            y = ((i / 5) + 3) % 5;
            final_index = ((y + 2) % 5) + ((((((2 * x) + (3 * y)) % 5) + 2) % 5 ) * 5);
            in[final_index] = in_arr_temp[i];
        end
        if (depth < 64)
            depth = depth + 1;
    end

    reg25bit out_reg(in, out, clk, rst, ld);

endmodule