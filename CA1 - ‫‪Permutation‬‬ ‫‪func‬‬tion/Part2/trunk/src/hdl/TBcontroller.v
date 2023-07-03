//in the name of God

`timescale 1ns/1ns

module TBcontroller ();


    wire [2:0] state;
    reg start = 1 , clk;
    wire reset_counter, count, load_reg, reset_reg,ready, read_input, write_output, cout;

    cu c1
    (
        .start(start),
        .clk(clk),
        .cout(cout),
        .reset_counter(reset_counter), 
        .count(count), 
        .load_reg(load_reg), 
        .reset_reg(reset_reg),
        .ready(ready), 
        .read_input(read_input), 
        .write_output(write_output),
        .state(state)
    );

    wire [5:0] pout;

    counter6bit conter1
    (
        .count_en(count),
        .clk(clk),
        .reset(reset_counter),
        .pout(pout),
        .cout(cout)
    );

    always begin
        #10 clk = 0;
        #40 clk = 1;
    end

    initial begin
        #130 start = 0;
        #10000 $stop;
    end

    
endmodule