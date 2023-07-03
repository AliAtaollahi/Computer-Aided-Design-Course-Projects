module mux_4 #(parameter bits = 1)(
    a0,
    a1,
    a2,
    a3,
    out,
    sel
);
    input [bits - 1 : 0] a0, a1, a2, a3;
    input [1 : 0] sel;

    output [bits - 1 : 0] out;

    assign out =    sel == 2'b00 ? a0 :
                    sel == 2'b01 ? a1 :
                    sel == 2'b10 ? a2 :
                    sel == 2'b11 ? a3 :
                    30'bZ;       

endmodule