`timescale 1ns / 1ps

module Immediate_Generator_tb;
reg [31:0] instruction;
wire [31:0] imm_out;

Immediate_Generator immgen (instruction, imm_out);

initial begin
       instruction = 32'b000000000101_00010_000_00001_0010011; // Expected imm = 5, I Type
   #10 instruction = 32'b0000000_00001_00010_010_00100_0100011; // Expected imm = 4, S Type
   #10 instruction = 32'b000000_00010_00001_000_00000_1100011; // Expected imm = 0, B Type
   #10 instruction = 32'b00010010001101000101_00101_0110111; // Expected imm = 0x12345000, U Type
   #10 instruction = 32'b000000000100_00000000_0_00000000_00001_1101111; // Expected imm = fff00000, J Type    
   #10 $finish;
end

initial begin
    $monitor("Time = %0t ns | Instruction = %h | Immediate = %d (hex = %h)", $time, instruction, imm_out, imm_out); 
end
endmodule
