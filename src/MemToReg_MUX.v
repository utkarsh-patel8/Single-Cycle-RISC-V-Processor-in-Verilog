`timescale 1ns / 1ps

module MemToReg_MUX(ALUResult, mem_data, MemToReg, write_back_data);
input [31:0] ALUResult, mem_data;
input MemToReg;
output [31:0] write_back_data;

assign write_back_data = MemToReg ? mem_data : ALUResult;
endmodule
