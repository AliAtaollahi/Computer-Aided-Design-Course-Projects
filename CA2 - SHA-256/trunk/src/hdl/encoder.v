`timescale 1ns/1ns

module encoder (
    input start,
    input clock
);
    wire start_addrc, start_colparity, start_permute, start_revaluate, start_rotate;
    wire done, done_addrc, done_colparity, done_permute, done_revaluate, done_rotate;
    wire reset_addrc, reset_colparity, reset_permute, reset_revaluate, reset_rotate;
    wire mode; //remember to change this to 0 for 64 bit mode
    wire sel64;
    wire [1 : 0] sel25;
    wire [4 : 0] turn;
    wire wr_file;
    wire count_en, reset_counter, cout;

    dp dp_
    (
        clock,
        done_addrc, done_colparity, done_permute, done_revaluate, done_rotate,
        turn,
        cout,
        start_addrc, start_colparity, start_permute, start_revaluate, start_rotate,
        reset_addrc, reset_colparity, reset_permute, reset_revaluate, reset_rotate,
        mode, sel64,
        sel25,
        wr_file,
        count_en,
        reset_counter
    );

    cu cu_
    (
        clock, start,
        done_addrc, done_colparity, done_permute, done_revaluate, done_rotate,
        turn,
        cout,
        start_addrc, start_colparity, start_permute, start_revaluate, start_rotate,
        reset_addrc, reset_colparity, reset_permute, reset_revaluate, reset_rotate,
        mode, sel64,
        sel25,
        wr_file,
        done,
        count_en,
        reset_counter
    );


endmodule