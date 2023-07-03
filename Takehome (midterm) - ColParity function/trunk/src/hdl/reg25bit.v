module reg25bit #(parameter read_file_name)(
    in,
    out,
    clk,
    rst,
    ld
);
    input [24 : 0] in;
    output [24 : 0] out;
    reg [24 : 0] out_;
    input clk, rst;
    input ld;
    integer scan_file, read_file_buffer;
    reg [24:0] in_arr_temp;
    initial begin
        read_file_buffer = $fopen(read_file_name, "r");
        $fclose(read_file_name);
        while (!$feof(read_file_buffer)) begin
            scan_file = $fscanf(read_file_buffer, "%b\n", in_arr_temp); 
        end
    end
    always @(posedge clk, posedge rst) begin
        if (rst)
            out_ <= in_arr_temp;
        else
            if (ld)
                out_ <= in;
    end
    assign out = out_;

endmodule