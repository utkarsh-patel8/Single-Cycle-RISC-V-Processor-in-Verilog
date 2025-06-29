`timescale 1ns / 1ps

module data_memory_tb;
reg clk, MemRead, MemWrite;
reg [31:0] addr, write_data;
wire [31:0] read_data;

data_memory DUT_dm (clk, MemRead, MemWrite, addr, write_data, read_data);

always #5 clk = ~clk;

initial
    begin
        clk = 1'b0;
        #1
        MemWrite = 1; MemRead = 0;
        addr = 5; write_data = 32'hDEADCAFE; #10;
        addr = 10; write_data = 32'h12345678; #10;
        
        MemWrite = 0; MemRead = 1;
        addr = 5; #10;
        addr = 10; #10;
        
        MemRead = 0; #10;
        $finish;
    end

initial begin
    $monitor("Time = %0t | Addr = %d | Write = %b | Read = %b | Write Data = %h | Read Data = %h", $time, addr, MemWrite, MemRead, write_data, read_data);
end    
endmodule
