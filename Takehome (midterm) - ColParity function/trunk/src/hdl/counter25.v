module counter25 
(
    count_en,
    clk,
    rst,
    pout,
    cout
);
    input count_en;
    input clk;
    input rst;
    output reg [4:0] pout;
    output reg cout;
    always @(posedge clk, posedge rst) begin

        if (rst == 1) begin
            pout <= 5'd0;
        end
        else if (count_en) begin
            pout <= pout + 1;
        end

        assign cout = (count_en == 1) ? pout == 5'd26 : 0;
    end 
endmodule