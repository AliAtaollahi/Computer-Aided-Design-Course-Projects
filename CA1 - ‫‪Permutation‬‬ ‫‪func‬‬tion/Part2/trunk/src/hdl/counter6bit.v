//in the name of God

module counter6bit 
(
    input count_en,
    input clk,
    input reset,
    output reg [5:0] pout,
    output reg cout
);

    always @(posedge clk, posedge reset) begin

        if (reset == 1) begin
            pout <= 0;
        end
        else if (count_en) begin
            pout <= pout + 1;
        end

        assign cout  = (count_en == 1) ? &{pout} : 0;
    end 
endmodule