`timescale 1ns / 1ps

module PC_tb;
reg [31:0] PC_next;
reg clk, reset, PC_write_en;
wire [31:0] PC;

PC DUT_PC (clk, reset, PC, PC_write_en, PC_next);

always #5 clk = ~clk;

initial begin
    clk = 0;
end

initial begin
    reset = 1; PC_write_en = 1; #12;
    reset = 0; PC_write_en = 1; PC_next = 8; #10
    reset = 0; PC_write_en = 1;  PC_next = 20; #10
    PC_write_en = 0; PC_next = 12;
    #50 $finish;
end

initial begin
    $monitor("Time = %0.1f ns | Reset = %b | PC_write_en = %b | PC_next = %h | PC = %h", $realtime, reset, PC_write_en, PC_next, PC);
end
endmodule
