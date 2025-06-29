`timescale 1ns / 1ps

module PCAdder(PC, PC_plus_4);
input [31:0] PC;
output [31:0] PC_plus_4;

assign PC_plus_4 = PC + 4;
endmodule
