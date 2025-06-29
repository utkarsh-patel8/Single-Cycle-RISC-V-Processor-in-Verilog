`timescale 1ns / 1ps

module CPU_tb;
reg clk, reset;

SingleCycleCPU CPU (.clk(clk),
                    .reset(reset));

always #5 clk = ~clk;

initial
    begin
        clk = 0; reset = 1;
        #11 reset = 0;
        
        #70 $finish;
    end
    
    
initial begin
$monitor("Time=%0.1f | PC=%h | Inst=%h | x1=%h | x2=%h | x5=%h | x6=%h | x7=%h | x8=%h | x9=%h | Mem[0]=%h", 
         $time, CPU.PC, CPU.instruction,
         CPU.regfile_inst.regfile[1], CPU.regfile_inst.regfile[2],
         CPU.regfile_inst.regfile[5], CPU.regfile_inst.regfile[6],
         CPU.regfile_inst.regfile[7], CPU.regfile_inst.regfile[8], 
         CPU.regfile_inst.regfile[9],
         CPU.DM_inst.memory[0]);



end

endmodule
