`timescale 1ns / 1ps

module ControlUnit(instruction, RegWrite, MemRead, MemWrite, MemToReg, ALUSrc, Branch, Jump, ALUOp);
input [31:0] instruction;
output reg RegWrite, MemRead, MemWrite, MemToReg, ALUSrc, Branch, Jump;
output reg [1:0] ALUOp;

always @(*) begin
    case(instruction[6:0])
        // R Type
        7'b0110011: begin
                    RegWrite = 1'b1; ALUOp = 2'b10;                  
                    MemRead = 1'b0; MemWrite = 1'b0; MemToReg = 1'b0; ALUSrc = 1'b0; Branch = 1'b0; Jump = 1'b0;
                    end
        // I Type (arithmetic)
        7'b0010011: begin
                    RegWrite = 1'b1; ALUSrc = 1'b1; ALUOp = 2'b10;
                    MemRead = 1'b0; MemWrite = 1'b0; MemToReg = 1'b0; Branch = 1'b0; Jump = 1'b0;
                    end
        // I Type (load)
        7'b0000011: begin
                    RegWrite = 1'b1; ALUSrc = 1'b1; ALUOp = 2'b00; MemRead = 1'b1;
                    MemWrite = 1'b0; MemToReg = 1'b1; Branch = 1'b0; Jump = 1'b0;
                    end
        // I Type (jalr)
        7'b1100111: begin
                    ALUSrc = 1'b1; RegWrite = 1'b1; Jump = 1'b1; ALUOp = 2'b00;
                    MemRead = 1'b0; MemWrite = 1'b0; MemToReg = 1'b0; Branch = 1'b0;
                    end
        // S type (sw)
        7'b0100011: begin 
                    ALUSrc = 1'b1; MemWrite = 1'b1; ALUOp = 2'b00; 
                    RegWrite = 1'b0; MemRead = 1'b0; MemToReg = 1'b0; Branch = 1'b0; Jump = 1'b0;
                    end
        // B type
        7'b1100011: begin
                    ALUSrc = 1'b0; Branch = 1'b1; ALUOp = 2'b01;
                    RegWrite = 1'b0; MemRead = 1'b0; MemToReg = 1'b0; Jump = 1'b0; MemWrite = 1'b0;
                    end
        // J type(jal)
        7'b1101111: begin
                    ALUSrc = 1'b0; Jump = 1'b1; ALUOp = 2'b00;
                    RegWrite = 1'b1; MemRead = 1'b0; MemToReg = 1'b0; Branch = 1'b0; MemWrite = 1'b0;
                    end
        // U type
        7'b0110111, 
        7'b0010111: begin
                    ALUSrc = 1'b1; RegWrite = 1'b1; ALUOp = 2'b00;
                    MemRead = 1'b0; MemToReg = 1'b0; Branch = 1'b0; MemWrite = 1'b0; Jump = 1'b0;
                    end
         default: begin
                  RegWrite = 1'b0; ALUOp = 2'b00;                  
                  MemRead = 1'b0; MemWrite = 1'b0; MemToReg = 1'b0; ALUSrc = 1'b0; Branch = 1'b0; Jump = 1'b0;
                  end           
                    
                    
    endcase
end
endmodule
