`timescale 1ns / 1ps

module ALUControl_tb;
reg [1:0] ALUOp;
reg [2:0] funct3;
reg [6:0] funct7;
wire [3:0] alu_control;

ALUControl AC1 (ALUOp, funct3, funct7, alu_control);

initial
    begin
    ALUOp = 2'b10; funct7 = 7'b0000000; funct3 = 3'b000; #10; // ADD
    ALUOp = 2'b10; funct7 = 7'b0100000; funct3 = 3'b000; #10; // SUB
    ALUOp = 2'b00; funct7 = 7'b0100000; funct3 = 3'b000; #10; // ADD
    ALUOp = 2'b10; funct7 = 7'b0000000; funct3 = 3'b100; #10; // XOR
    ALUOp = 2'b10; funct7 = 7'b0000000; funct3 = 3'b101; #10; //SRL
    end
initial 
$monitor("ALUOp = %b, funct7 = %b, funct3 = %b, alu_control = %b", ALUOp, funct7, funct3, alu_control);

endmodule
