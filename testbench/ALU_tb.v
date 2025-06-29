`timescale 1ns / 1ps

module ALU_tb;
reg [31:0] op1, op2;
reg [3:0] alu_control;
wire [31:0] result;
wire isZero;

parameter AND = 4'b0000, OR = 4'b0001, ADD = 4'b0010, SUB = 4'b0011, XOR = 4'b0100,
          SLL = 4'b0101, SRL = 4'b0110, SRA = 4'b0111, SLT = 4'b1000, SLTU = 4'b1001;

ALU A1 (op1, op2, alu_control, isZero, result);

initial begin
    op1 = 32'd15; op2 = 32'd10; alu_control = ADD;
    #10;
    $display("ADD: result = %d", result);

    op1 = 32'hFFFF_FF80; op2 = 5; alu_control = SRA;
    #10;
    $display("SRA: result = %h", result);
end


endmodule
