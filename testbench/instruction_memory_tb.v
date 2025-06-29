`timescale 1ns / 1ps

module instruction_memory_tb;
    reg [31:0] PC;
    wire [31:0] instruction;
    
    instruction_memory IM1 (PC, instruction);
    
    initial begin
        PC = 0; #10;
        PC = 4; #10;
        PC = 8; #10;
        PC = 12; #10;
    end
    
    initial begin
        $monitor("Time = %0t | PC = %h | Instruction = %h", $time, PC, instruction);
    end
endmodule
