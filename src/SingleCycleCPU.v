`timescale 1ns / 1ps

module SingleCycleCPU(input clk, input reset);
// Instruction Fetch
wire [31:0] PC, PC_next, PC_plus_4, instruction, PC_target;
// Control Signals
wire RegWrite, MemRead, MemWrite, MemToReg, ALUSrc, Branch, Jump;
wire [1:0] ALUOp;
// ALU 
wire [31:0] ALU_input2, ALU_result;
wire isZero;
wire [3:0] alu_control;

// Register file signals
wire [4:0] rs1, rs2, rd;
wire [31:0] reg_data1, reg_data2, write_back_data;
wire [31:0] normal_write_back_data;
// Immediate Generator
wire [31:0] imm_out;
// Memory
wire [31:0] mem_data;
// Branch Comparator
wire branch_taken, PCSrc;

// Fetch Stage
PC PC_inst (.clk(clk), 
            .reset(reset), 
            .PC(PC), 
            .PC_write_en(1'b1), 
            .PC_next(PC_next));
            
PCAdder PCAdder_inst (.PC(PC),
                      .PC_plus_4(PC_plus_4));
                      
instruction_memory IM_inst (.PC(PC),
                            .instruction(instruction));

// Decode Stage
ControlUnit CU_inst (.instruction(instruction),
                     .RegWrite(RegWrite),
                     .MemRead(MemRead),
                     .MemWrite(MemWrite),
                     .MemToReg(MemToReg),
                     .ALUSrc(ALUSrc),
                     .Branch(Branch),
                     .Jump(Jump),
                     .ALUOp(ALUOp));


assign rs1 = instruction[19:15];
assign rs2 = instruction[24:20];
assign rd = instruction[11:7];

RegisterFile regfile_inst (.rs1(rs1),
                           .rs2(rs2),
                           .rd(rd),
                           .write_enable(RegWrite),
                           .write_data(write_back_data),
                           .read_data1(reg_data1),
                           .read_data2(reg_data2), 
                           .clk(clk));

// Immediate Generation
Immediate_Generator IG_inst (.instruction(instruction), .imm_out(imm_out));

// Execution Stage
ALUSrc_MUX ALUMUX (.reg_data2(reg_data2),
                   .imm_data(imm_out),
                   .ALUSrc(ALUSrc),
                   .ALU_input2(ALU_input2));
                   
ALUControl ALUControl_inst (.ALUOp(ALUOp),
                            .funct3(instruction[14:12]),
                            .funct7(instruction[31:25]),
                            .alu_control(alu_control));

ALU ALU_inst (.op1(reg_data1),
              .op2(ALU_input2),
              .alu_control(alu_control),
              .isZero(isZero),
              .result(ALU_result));

// Memory Stage
data_memory DM_inst (.clk(clk),
                     .MemRead(MemRead),
                     .MemWrite(MemWrite),
                     .addr(ALU_result),
                     .write_data(reg_data2),
                     .read_data(mem_data));
                     
// Write Back Stage
MemToReg_MUX MemToReg_MUX_inst (.ALUResult(ALU_result),
                                .mem_data(mem_data),
                                .MemToReg(MemToReg),
                                .write_back_data(normal_write_back_data));
                                
// Branch and Jump Handling
BranchComparator BranchComparator_inst (.funct3(instruction[14:12]),
                                        .reg_data1(reg_data1),
                                        .reg_data2(reg_data2),
                                        .branch_taken(branch_taken));
                                        
assign PCSrc = Jump | (Branch & branch_taken); // Branch taken if instruction is Branch type and condition is also satisfied or Jump
// For jal and branch, PC target is reg_data1 + imm_out
// For jalr, PC target is (reg_data1 + imm_out) & ~32'b1
assign PC_target = (Jump && instruction[6:0] == 7'b1100111) ? 
                   ((reg_data1 + imm_out) & ~32'b1) :
                   (PC + imm_out);


PCSrc_MUX PCSrc_MUX_inst (.PC_plus_4(PC_plus_4),
                           .PC_target(PC_target),
                           .PCSrc(PCSrc),
                           .next_PC(PC_next));   

// For jal, jalr, lui, auipc
assign write_back_data = (instruction[6:0] == 7'b1101111 || // JAL
                          instruction[6:0] == 7'b1100111)   // JALR
                         ? PC_plus_4 :
                         (instruction[6:0] == 7'b0010111    // AUIPC
                          ? (PC + imm_out) :
                          (instruction[6:0] == 7'b0110111   // LUI
                           ? imm_out :
                             normal_write_back_data));

                  
endmodule
