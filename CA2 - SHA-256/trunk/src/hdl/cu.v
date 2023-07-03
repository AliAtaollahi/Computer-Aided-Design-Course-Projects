// In the Name of God

module cu
(
    input clock, start,
    input done_addrc, done_colparity, done_permute, done_revaluate, done_rotate,
    input [4 : 0] turn,
    input cout,
    output reg start_addrc, start_colparity, start_permute, start_revaluate, start_rotate,
    output reg reset_addrc, reset_colparity, reset_permute, reset_revaluate, reset_rotate,
    output reg mode, sel64,
    output reg [1 : 0] sel25,
    output reg wr_file,
    output reg done,
    output reg count_en,
    output reg reset_counter
);
    reg [4:0] ps, ns;
    parameter Idle = 0, Init = 1, ResetColParity = 2, StartColParity = 3, DoneColParity = 4, ResetRotate = 5, 
    StartRotate = 6, DoneRotate = 7, ResetPermute = 8, StartPermute = 9, DonePermute = 10, ResetRevaluate = 11, StartRevaluate = 12, DoneRevaluate = 13, 
    ResetAddRc = 14, StartAddRc = 15, DoneAddRc = 16, Finish = 17; 
    
    always @(posedge clock) begin
        ps <= ns; 
    end

    always @(ps, start, cout, done_addrc, done_colparity, done_permute, done_revaluate, done_rotate) begin
        ns = Idle;
        case (ps)
            Idle: ns = start ? Init : Idle;
            Init: ns = start ? Init : ResetColParity;
            ResetColParity: ns = StartColParity;
            StartColParity: ns = done_colparity ? DoneColParity : StartColParity;
            DoneColParity: ns = ResetRotate;

            ResetRotate: ns = StartRotate;
            StartRotate: ns = done_rotate ? DoneRotate : StartRotate;
            DoneRotate: ns = ResetPermute;

            ResetPermute: ns = StartPermute;
            StartPermute: ns = done_permute ? DonePermute : StartPermute;
            DonePermute: ns = ResetRevaluate;

            ResetRevaluate: ns = StartRevaluate;
            StartRevaluate: ns = done_revaluate ? DoneRevaluate : StartRevaluate;
            DoneRevaluate: ns = ResetAddRc;
    
            ResetAddRc: ns = StartAddRc;
            StartAddRc: ns = done_addrc ? DoneAddRc : StartAddRc;
            DoneAddRc: ns = cout ? Finish : ResetColParity;

            Finish: ns = Finish;
            default: ns = Idle;
        endcase
    end

    always @(ps,start,cout) begin

        case (ps)
            Idle:begin
                {start_addrc, start_colparity, start_permute, start_revaluate, start_rotate, reset_addrc, reset_colparity, reset_permute, reset_revaluate, reset_rotate, mode, sel64, wr_file, done, sel25, count_en, reset_counter} = 18'b00000_00000_000000_00;
            end

            Init:begin
                {start_addrc, start_colparity, start_permute, start_revaluate, start_rotate, reset_addrc, reset_colparity, reset_permute, reset_revaluate, reset_rotate, mode, sel64, wr_file, done, sel25, count_en, reset_counter} = 18'b00000_00000_000000_01;
            end
            
            ResetColParity:begin
                {start_addrc, start_colparity, start_permute, start_revaluate, start_rotate, reset_addrc, reset_colparity, reset_permute, reset_revaluate, reset_rotate, mode, sel64, wr_file, done, sel25, count_en, reset_counter} = 18'b00000_01000_100001_00;
            end
            
            StartColParity:begin
                {start_addrc, start_colparity, start_permute, start_revaluate, start_rotate, reset_addrc, reset_colparity, reset_permute, reset_revaluate, reset_rotate, mode, sel64, wr_file, done, sel25, count_en, reset_counter} = 18'b01000_00000_100001_00;
            end

            DoneColParity:begin
                {start_addrc, start_colparity, start_permute, start_revaluate, start_rotate, reset_addrc, reset_colparity, reset_permute, reset_revaluate, reset_rotate, mode, sel64, wr_file, done, sel25, count_en, reset_counter} =  18'b00000_00000_100001_00;                
            end

            ResetRotate:begin
                {start_addrc, start_colparity, start_permute, start_revaluate, start_rotate, reset_addrc, reset_colparity, reset_permute, reset_revaluate, reset_rotate, mode, sel64, wr_file, done, sel25, count_en, reset_counter} =  18'b00000_00001_000000_00;
            end
            
            StartRotate:begin
                {start_addrc, start_colparity, start_permute, start_revaluate, start_rotate, reset_addrc, reset_colparity, reset_permute, reset_revaluate, reset_rotate, mode, sel64, wr_file, done, sel25, count_en, reset_counter} =  18'b00001_00000_000000_00;
            end

            DoneRotate:begin
                {start_addrc, start_colparity, start_permute, start_revaluate, start_rotate, reset_addrc, reset_colparity, reset_permute, reset_revaluate, reset_rotate, mode, sel64, wr_file, done, sel25, count_en, reset_counter} =  18'b00000_00000_000000_00;
            end

            ResetPermute:begin
                {start_addrc, start_colparity, start_permute, start_revaluate, start_rotate, reset_addrc, reset_colparity, reset_permute, reset_revaluate, reset_rotate, mode, sel64, wr_file, done, sel25, count_en, reset_counter} =  18'b00000_00100_100010_00;
            end
            
            StartPermute:begin
                {start_addrc, start_colparity, start_permute, start_revaluate, start_rotate, reset_addrc, reset_colparity, reset_permute, reset_revaluate, reset_rotate, mode, sel64, wr_file, done, sel25, count_en, reset_counter} =  18'b00100_00000_100010_00;
            end

            DonePermute:begin
                {start_addrc, start_colparity, start_permute, start_revaluate, start_rotate, reset_addrc, reset_colparity, reset_permute, reset_revaluate, reset_rotate, mode, sel64, wr_file, done, sel25, count_en, reset_counter} =  18'b00000_00000_100010_00;
            end

            ResetRevaluate:begin
                {start_addrc, start_colparity, start_permute, start_revaluate, start_rotate, reset_addrc, reset_colparity, reset_permute, reset_revaluate, reset_rotate, mode, sel64, wr_file, done, sel25, count_en, reset_counter} =  18'b00000_00010_100011_00;
            end
            
            StartRevaluate:begin
                {start_addrc, start_colparity, start_permute, start_revaluate, start_rotate, reset_addrc, reset_colparity, reset_permute, reset_revaluate, reset_rotate, mode, sel64, wr_file, done, sel25, count_en, reset_counter} =  18'b00010_00000_100011_00;
            end

            DoneRevaluate:begin
                {start_addrc, start_colparity, start_permute, start_revaluate, start_rotate, reset_addrc, reset_colparity, reset_permute, reset_revaluate, reset_rotate, mode, sel64, wr_file, done, sel25, count_en, reset_counter} =  18'b00000_00000_100011_00;
            end

            ResetAddRc:begin
                {start_addrc, start_colparity, start_permute, start_revaluate, start_rotate, reset_addrc, reset_colparity, reset_permute, reset_revaluate, reset_rotate, mode, sel64, wr_file, done, sel25, count_en, reset_counter} =  18'b00000_10000_010000_00;
            end
            
            StartAddRc:begin
                {start_addrc, start_colparity, start_permute, start_revaluate, start_rotate, reset_addrc, reset_colparity, reset_permute, reset_revaluate, reset_rotate, mode, sel64, wr_file, done, sel25, count_en, reset_counter} =  18'b10000_00000_010000_00;
            end

            DoneAddRc:begin
                {start_addrc, start_colparity, start_permute, start_revaluate, start_rotate, reset_addrc, reset_colparity, reset_permute, reset_revaluate, reset_rotate, mode, sel64, wr_file, done, sel25, count_en, reset_counter} =  18'b00000_00000_010000_10;
            end

            Finish:begin
                {start_addrc, start_colparity, start_permute, start_revaluate, start_rotate, reset_addrc, reset_colparity, reset_permute, reset_revaluate, reset_rotate, mode, sel64, wr_file, done, sel25, count_en, reset_counter} = 18'b00000_00000_001100_00;
            end
        endcase
    end
    assign state = ps;

endmodule