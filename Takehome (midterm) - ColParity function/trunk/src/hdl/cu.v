`timescale 1ns/1ns

module cu
(
    start,
    clk,
    cout25,
    cout6bit,
    rst_counter,
    rst_in_reg,
    read_input,
    ld_ppr,
    counter25_en,
    counter6bit_en,
    write_input,
    rst_counter6bit,
    done
);
    input start, clk, cout25, cout6bit;
    output reg rst_counter, rst_in_reg, read_input, ld_ppr, counter25_en, write_input, done, counter6bit_en, rst_counter6bit;
    
    reg [2:0] ps, ns;
    parameter Idle = 0,InitCounter = 1,InitReg = 2, ReadFile = 3,Calc = 4, WriteFile = 5, ResetCounter = 6, Finish = 7;
    
    always @(posedge clk) begin
        ps <= ns; 
    end

    always @(ps, start, cout25, cout6bit) begin
        ns = Idle;
        case (ps)
            Idle: ns = start ? InitCounter : Idle;
            InitCounter: ns = start ? InitCounter : InitReg;
            InitReg: ns = ReadFile;
            ReadFile: ns = Calc;
            Calc: ns = cout25 ? WriteFile : Calc;
            WriteFile: ns = cout6bit ? Finish : ResetCounter;
            ResetCounter: ns = ReadFile;
            Finish: ns = Finish;
            default: ns = Idle;
        endcase
    end

    always @(ps, start, cout25, cout6bit) begin
        case (ps)
            Idle:begin
                {rst_counter, rst_in_reg, read_input, ld_ppr, counter25_en, counter6bit_en, write_input, rst_counter6bit, done} <= 9'b000000000;
            end
            InitCounter:begin
                {rst_counter, rst_in_reg, read_input, ld_ppr, counter25_en, counter6bit_en, write_input, rst_counter6bit, done} <= 9'b100000010;
            end
            InitReg:begin
                {rst_counter, rst_in_reg, read_input, ld_ppr, counter25_en, counter6bit_en, write_input, rst_counter6bit, done} <= 9'b010000000;
            end
            ReadFile:begin
                {rst_counter, rst_in_reg, read_input, ld_ppr, counter25_en, counter6bit_en, write_input, rst_counter6bit, done} <= 9'b001100000;
            end
            Calc:begin
                {rst_counter, rst_in_reg, read_input, ld_ppr, counter25_en, counter6bit_en, write_input, rst_counter6bit, done} <= 9'b000010000;
            end
            WriteFile:begin
                {rst_counter, rst_in_reg, read_input, ld_ppr, counter25_en, counter6bit_en, write_input, rst_counter6bit, done} <= 9'b000011100;
            end
            ResetCounter:begin
                {rst_counter, rst_in_reg, read_input, ld_ppr, counter25_en, counter6bit_en, write_input, rst_counter6bit, done} <= 9'b100000000;
            end
            Finish:begin
                {rst_counter, rst_in_reg, read_input, ld_ppr, counter25_en, counter6bit_en, write_input, rst_counter6bit, done} <= 9'b000000001;
            end
        endcase
    end
    assign state = ps;

endmodule