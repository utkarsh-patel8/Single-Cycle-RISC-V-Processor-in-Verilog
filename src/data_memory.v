`timescale 1ns / 1ps

module data_memory(clk, MemRead, MemWrite, addr, write_data, read_data);
input clk, MemRead, MemWrite;
input [31:0] addr, write_data;
output [31:0] read_data;
parameter size = 128;
reg [31:0] memory [size-1:0];   // 128 words size for simulation

initial begin
    $readmemh("data.mem", memory);
end

// Read Operation
assign read_data = MemRead ? memory[addr[6:2]] : 32'b0; // Memory is word addressed

// Write Operation
always @(posedge clk)
begin
    if(MemWrite) memory[addr[6:2]] <= write_data;   // Memory is word addressed
end

endmodule
