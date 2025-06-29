`timescale 1ns / 1ps
module PC(clk, reset, PC, PC_write_en, PC_next);
    input clk, reset;
    input [31:0] PC_next;
    input PC_write_en;
    output reg [31:0] PC;
    
    always @ (posedge clk)
    begin
        if(reset) 
            PC <= 32'b0;
        else if (PC_write_en) 
            PC <= PC_next;
    end
    
    
endmodule