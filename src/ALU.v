`timescale 1ns / 1ps
module ALU(op1, op2, alu_control, isZero, result);
input [31:0] op1, op2;
input [3:0] alu_control;
output isZero;
output reg [31:0] result;

parameter AND = 4'b0000, OR = 4'b0001, ADD = 4'b0010, SUB = 4'b0011, XOR = 4'b0100,
          SLL = 4'b0101, SRL = 4'b0110, SRA = 4'b0111, SLT = 4'b1000, SLTU = 4'b1001;

assign isZero = (result==0);

always @(*)
begin
    case(alu_control)
        AND: result = op1 & op2;
        OR: result = op1 | op2;
        ADD: result = op1 + op2;
        SUB: result = op1 - op2;
        XOR: result = op1 ^ op2;
        SLL: result = op1 << op2[4:0];
        SRL: result = op1 >> op2[4:0];
        SRA: result = $signed(op1) >>> op2[4:0];
        SLT: result = ($signed(op1)<$signed(op2));
        SLTU: result = (op1<op2);
        default: result = 32'b0;   
    endcase
end
endmodule
