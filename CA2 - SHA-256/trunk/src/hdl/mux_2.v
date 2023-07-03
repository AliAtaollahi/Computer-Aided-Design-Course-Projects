module mux_2 #(parameter bits = 1) (
    a0,
    a1,
    out,
    sel
);
    input [bits - 1 : 0] a0, a1;
    input sel;

    output [bits - 1 : 0] out;

    assign out =    sel == 1'b0 ? a0 :
                    sel == 1'b1 ? a1 :
                    10'bZ;    

endmodule