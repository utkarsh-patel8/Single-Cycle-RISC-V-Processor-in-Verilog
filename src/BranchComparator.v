`timescale 1ns / 1ps

module BranchComparator(funct3, reg_data1, reg_data2, branch_taken);
input [2:0] funct3;
input [31:0] reg_data1, reg_data2;
output reg branch_taken;

always @(*)
begin
    case (funct3)
        3'b000: branch_taken = (reg_data1 == reg_data2);               // BEQ
        3'b001: branch_taken = (reg_data1 != reg_data2);               // BNE
        3'b100: branch_taken = ($signed(reg_data1) < $signed(reg_data2)); // BLT
        3'b101: branch_taken = ($signed(reg_data1) >= $signed(reg_data2)); // BGE
        3'b110: branch_taken = (reg_data1 < reg_data2);                // BLTU
        3'b111: branch_taken = (reg_data1 >= reg_data2);               // BGEU
        default: branch_taken = 1'b0;
    endcase
end

endmodule
