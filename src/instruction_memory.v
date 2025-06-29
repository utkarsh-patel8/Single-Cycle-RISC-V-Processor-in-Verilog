`timescale 1ns / 1ps

module instruction_memory(PC, instruction);
input [31:0] PC;
output [31:0] instruction;

parameter N = 128; // Number of instruction words
reg [31:0] mem [0:N-1];

assign instruction = mem[{PC[6:2]}]; // Because instruction memory array is indexed by instruction number

initial begin
    $readmemh("program.mem", mem);
end
endmodule
