`timescale 1ns/1ns

module dp (
    input clock,
    output done_addrc, done_colparity, done_permute, done_revaluate, done_rotate,
    output [4 : 0] turn,
    output cout,
    input start_addrc, start_colparity, start_permute, start_revaluate, start_rotate,
    input reset_addrc, reset_colparity, reset_permute, reset_revaluate, reset_rotate,
    input mode, sel64,
    input [1 : 0] sel25,
    input wr_file,
    input count_en,
    input reset_counter
);

wire [5 : 0] a0, a1, a3, a4, out_mux1;
wire [24 : 0] b0, b1, b3, b4, out_mux2;
wire [4 : 0] a2, a5, out_mux3;
wire [63 : 0] b2, b5, out_mux4;
wire c0, c1, c2, c3, c4, c5, d1, d2, d3, d4, d5, out_mux5, out_mux6, out_mux7, out_mux8;

wire [0:24]out25;
wire [0:63]out64;

mux_4 #(.bits(6)) m1(a0, a1, a3, a4, out_mux1, sel25);
mux_4 #(.bits(25)) m2(b0, b1, b3, b4, out_mux2, sel25);

mux_2 #(.bits(5)) m3(a2, a5, out_mux3, sel64);
mux_2 #(.bits(64)) m4(b2, b5, out_mux4, sel64);

mux_4 #(.bits(1)) m5(c0, c1, c3, c4, out_mux5, sel25);
mux_4 #(.bits(1)) m6(d0, d1, d3, d4, out_mux6, sel25);

mux_2 #(.bits(1)) m7(c2, c5, out_mux7, sel64);
mux_2 #(.bits(1)) m8(d2, d5, out_mux8, sel64);


Memory #(.input_file("file/input_2.txt")) Memory_ (
    .adr25(out_mux1),
    .in25(out_mux2),
    .r25(out_mux5),
    .w25(out_mux6),
    .out25(out25),

    .adr64(out_mux3),
    .in64(out_mux4),
    .r64(out_mux7),
    .w64(out_mux8),
    .out64(out64),

    .mode(mode),
    .wr_file(wr_file)
);

Colparity Colparity_ (
    .in(out25),
    .start(start_colparity),
    .clock(clock),
    .done(done_colparity),
    .reset(reset_colparity),
    .mem_adr(a1),
    .mem_in(b1),
    .mem_r(c1),
    .mem_w(d1)
);

Rotate Rotate_ (
    .in(out64),
    .start(start_rotate),
    .clock(clock),
    .done(done_rotate),
    .reset(reset_rotate),
    .mem_adr(a2),
    .mem_in(b2),
    .mem_r(c2),
    .mem_w(d2)
);

Permute Permute_ (
    .in(out25),
    .start(start_permute),
    .clock(clock),
    .done(done_permute),
    .reset(reset_permute),
    .mem_adr(a3),
    .mem_in(b3),
    .mem_r(c3),
    .mem_w(d3)
);

Revaluate Revaluate_ (
    .in(out25),
    .start(start_revaluate),
    .clock(clock),
    .done(done_revaluate),
    .reset(reset_revaluate),
    .mem_adr(a4),
    .mem_in(b4),
    .mem_r(c4),
    .mem_w(d4)
);

Addrc Addrc_ (
    .in(out64),
    .start(start_addrc),
    .clock(clock),
    .done(done_addrc),
    .reset(reset_addrc),
    .turn(turn),
    .mem_adr(a5),
    .mem_in(b5),
    .mem_r(c5),
    .mem_w(d5)
);

counter24 counter6bit_(
    count_en,
    clock,
    reset_counter,
    turn,
    cout
);
  
endmodule