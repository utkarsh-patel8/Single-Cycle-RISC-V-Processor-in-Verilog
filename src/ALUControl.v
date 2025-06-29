`timescale 1ns / 1ps

module ALUControl(ALUOp, funct3, funct7, alu_control);
input [1:0] ALUOp;
input [2:0] funct3;
input [6:0] funct7;
output reg [3:0] alu_control;

parameter AND = 4'b0000, OR = 4'b0001, ADD = 4'b0010, SUB = 4'b0011, XOR = 4'b0100,
          SLL = 4'b0101, SRL = 4'b0110, SRA = 4'b0111, SLT = 4'b1000, SLTU = 4'b1001;
          
parameter ERR = 4'b1111;
          
always@(*)
    begin
        case(ALUOp)
            2'b00: alu_control = ADD;
            2'b01: alu_control = SUB;
            2'b10: case(funct3)
                        3'b000: alu_control = (funct7 == 7'b0100000) ? SUB : ADD;
                        3'b111: alu_control = AND;
                        3'b110: alu_control = OR;
                        3'b100: alu_control = XOR;
                        3'b001: alu_control = SLL;
                        3'b101: alu_control = (funct7 == 7'b0100000) ? SRA : SRL;
                        3'b010: alu_control = SLT;
                        3'b011: alu_control = SLTU;
                        default: alu_control = ERR;
                     endcase
            default: alu_control = ERR;
        endcase
    end
endmodule
