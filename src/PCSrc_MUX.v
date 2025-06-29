`timescale 1ns / 1ps

module PCSrc_MUX(PC_plus_4, PC_target, PCSrc, next_PC);
input [31:0] PC_plus_4, PC_target;
input PCSrc;
output [31:0] next_PC;

assign next_PC = PCSrc ? PC_target : PC_plus_4;
endmodule
