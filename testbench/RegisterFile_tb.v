`timescale 1ns / 1ps

module RegisterFile_tb;
reg [4:0] rs1, rs2, rd;
reg write_enable, clk;
reg [31:0] write_data;
wire [31:0] read_data1, read_data2;


RegisterFile DUT_regfile (rs1, rs2, rd, write_enable, write_data, read_data1, read_data2, clk);

always #5 clk = ~clk;

initial begin
    clk = 0; rs1 = 0; rs2 = 0; rd = 0; write_enable = 0; write_data = 0;
    #2 rd = 4; write_enable = 1'b1; write_data = 40;
    #10 rd = 10; write_data = 100;
    #10 write_enable = 1'b0; rs1 = 4; rs2 = 10;
    #10 rd = 0; write_enable = 1'b1; write_data = 100;
    #10 write_enable = 1'b0; rs1 = 0;
    #10 $finish;
    end 
    
initial begin
    $monitor("Time = %0.1f ns | WE = %b | rd = x%0d | wr_data = %d | rs1 = x%0d | rs2 = x%0d | r1 = %d | r2 = %d",
         $time, write_enable, rd, write_data, rs1, rs2, read_data1, read_data2);

end
endmodule
