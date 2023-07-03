// In the Name of God

module cu
(
    start,
    clk,
    cout,
    reset_counter,
    count,
    load_reg,
    reset_reg,
    ready,
    read_input,
    write_output
);
    input start, clk, cout;
    output reg reset_counter, count, load_reg, reset_reg, ready, read_input, write_output;
    reg [2:0] ps, ns;
    parameter Idle = 0,Init = 1,Read = 2,Load = 3,Write = 4,Finish = 5;
    
    always @(posedge clk) begin
        ps <= ns; 
    end

    always @(ps,start,cout) begin
        ns = Idle;
        case (ps)
            Idle: ns = start ? Init : Idle;
            Init: ns = start ? Init : Read;
            Read: ns = Load;
            Load: ns = Write;
            Write: ns = cout ? Finish : Read;
            Finish: ns = Finish;
            default: ns = Idle;
        endcase
    end

    always @(ps,start,cout) begin

        case (ps)
            Idle:begin
                {reset_counter, count, load_reg, reset_reg, ready, read_input, write_output} = 7'b0000000;
            end
            Init:begin
                {reset_counter, count, load_reg, reset_reg, ready, read_input, write_output} = 7'b1001000;
            end
            Read:begin
                {reset_counter, count, load_reg, reset_reg, ready, read_input, write_output} = 7'b0000010;
            end
            Load:begin
                {reset_counter, count, load_reg, reset_reg, ready, read_input, write_output} = 7'b0010000;
            end
            Write:begin
                {reset_counter, count, load_reg, reset_reg, ready, read_input, write_output} = 7'b0100001;
            end
            Finish:begin
                {reset_counter, count, load_reg, reset_reg, ready, read_input, write_output} = 7'b0000100;
            end
        endcase
    end

endmodule