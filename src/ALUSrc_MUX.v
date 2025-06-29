`timescale 1ns / 1ps

module ALUSrc_MUX(reg_data2, imm_data, ALUSrc, ALU_input2);
input [31:0] reg_data2, imm_data;
input ALUSrc;
output [31:0] ALU_input2;

assign ALU_input2 = ALUSrc ? imm_data : reg_data2;
endmodule
