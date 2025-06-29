`timescale 1ns / 1ps

module ControlUnit_tb;
reg [31:0] instruction;
wire RegWrite, MemRead, MemWrite, MemToReg, ALUSrc, Branch, Jump;
wire [1:0] ALUOp;

ControlUnit DUT_CU (instruction, RegWrite, MemRead, MemWrite, MemToReg, ALUSrc, Branch, Jump, ALUOp);

initial begin
    instruction = 32'h002081B3; #10; // R-type
    instruction = 32'h00508093; #10; // I-type ADDI
    instruction = 32'h00408183; #10; // I-type LW
    instruction = 32'h00610223; #10; // S-type SW
    instruction = 32'h00208063; #10; // B-type BEQ
    instruction = 32'h001000EF; #10; // J-type JAL
    instruction = 32'h00108067; #10; // I-type JALR
    instruction = 32'h123452B7; #10; // U-type LUI
    instruction = 32'h12345317; #10; // U-type AUIPC
    instruction = 32'hFFFFFFFF; #10; // Invalid 
    $finish;
end

initial begin
    $monitor("Time: %0t | Instruction = %h | RegWrite = %b | MemRead = %b | MemWrite = %b | MemToReg = %b | ALUSrc = %b | Branch = %b | Jump = %b | ALUOp = %b", $time, instruction, RegWrite, MemRead, MemWrite, MemToReg, ALUSrc, Branch, Jump, ALUOp);
end
endmodule
