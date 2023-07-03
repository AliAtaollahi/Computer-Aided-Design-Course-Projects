`timescale 1ns/1ns

module tb ();
    reg start = 1'b0, clock = 1'b1;
    encoder encoder_(start, clock);

    always #100 clock = ~clock;

    initial begin
        #1000
        start = 1'b1;
        #1000
        start = 1'b0;
        #1500000


        $stop;
    end
    
endmodule