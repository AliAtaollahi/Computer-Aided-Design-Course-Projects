`timescale 1ns/1ns

module tb_memory ();

reg [5:0]adr25;
reg [0:24]in25;
reg r25;
reg w25;
wire [0:24]out25;

reg [4:0]adr64;
reg [0:63]in64;
reg r64;
reg w64;
wire [0:63]out64;

reg mode;

Memory uut (
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

initial begin
    adr25 = 0;
    in25 = 0;
    r25 = 0;
    w25 = 0;

    adr64 = 0;
    in64 = 0;
    r64 = 0;
    w64 = 0;

    mode = 0;
end

initial begin
    //write with 25
    adr25 = 5'd3;
    in25 = 25'b00000_11101_00000_00000_00000;
    r25 = 0;
    w25 = 1;
    mode = 1;
    #100
    //write with 64
    adr64 = 4'd3;
    in64 = 64'b1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_0101_0101;
    r64 = 0;
    w64 = 1;
    mode = 0;
    #100
    //read with 64
    adr64 = 5'd3;
    r64 = 1;
    w64 = 0;
    mode = 0;
    #100
    //read with 25
    adr25 = 5'd3;
    r25 = 1;
    w25 = 0;
    mode = 1;
    #100
    $stop;
end


    
endmodule