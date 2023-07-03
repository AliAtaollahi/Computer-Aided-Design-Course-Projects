module Memory #(parameter input_file)
(
    input [5:0]adr25,
    input [0:24]in25,
    input r25,
    input w25,
    output reg [0:24]out25,
    
    input [4:0]adr64,
    input [0:63]in64,
    input r64,
    input w64,
    output reg [0:63]out64,

    input mode,
    input wr_file
);
    // craete 64x25 bit memory
    reg [0:24] memory[0:63];



    //for testing
    initial begin
        $readmemb(input_file, memory);
    end

    integer i;

    parameter Mode64 = 0;
    parameter Mode25 = 1;

    always @(adr25 or in25 or r25 or w25 or adr64 or in64 or r64 or w64 or mode)begin
        case (mode)
            Mode64: begin
                if (r64) begin
                    for (i = 0; i < 64; i = i + 1) begin
                        out64[i] <= memory[i][adr64];
                    end   
                end
                if (w64) begin
                    for (i = 0; i < 64; i = i + 1) begin
                        memory[i][adr64] <= in64[i];
                    end
                end
            end
            Mode25: begin
                if (r25) begin
                    out25 <= memory[adr25];
                end
                if (w25) begin
                    memory[adr25] <= in25;
                end
            end
        endcase
    end
    always @(wr_file) begin
        if(wr_file) begin
            $writememb("output.txt", memory);
        end
    end
endmodule