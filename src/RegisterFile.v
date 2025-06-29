`timescale 1ns / 1ps

module RegisterFile(rs1, rs2, rd, write_enable, write_data, read_data1, read_data2, clk);
input [4:0] rs1, rs2, rd;
input write_enable, clk;
input [31:0] write_data;
output [31:0] read_data1, read_data2;
reg [31:0] regfile [31:0];
integer k;

initial begin
for(k=0; k<32; k=k+1) regfile[k] = 32'b0;
end

// Read operation
assign read_data1 = regfile[rs1];
assign read_data2 = regfile[rs2];

// Write Operation
always @(posedge clk)
    begin
        if((write_enable) && (rd!=5'b0)) regfile[rd] <= write_data;
    end
endmodule
