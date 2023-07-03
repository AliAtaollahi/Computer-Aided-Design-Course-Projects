`timescale 1ns/1ns

module tb_rotate ();

reg clock = 0;
reg start = 0;
reg reset = 0;
reg mode = 0; //remember to change this to 0 for 64 bit mode


wire [5:0]adr25;
wire [0:24]in25;
wire r25;
wire w25;
wire [0:24]out25;

wire [4:0]adr64;
wire [0:63]in64;
wire r64;
wire w64;
wire [0:63]out64;


Memory m1 (
    .adr25(adr25),
    .in25(in25),
    .r25(r25),
    .w25(w25),
    .out25(out25),

    .adr64(adr64),
    .in64(in64),
    .r64(r64),
    .w64(w64),
    .out64(out64),

    .mode(mode)
);

Rotate r1 (
    .in(out64),
    .start(start),
    .clock(clock),
    .done(done),
    .reset(reset),
    .mem_adr(adr64),
    .mem_in(in64),
    .mem_r(r64),
    .mem_w(w64)
);

always #200 clock = ~clock;

initial begin
    #100
    start = 1;
    #50000
    $stop;
end


    
endmodule