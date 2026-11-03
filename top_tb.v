```verilog 
`timescale 1ns / 1ps

module top_tb;

reg clk = 0;
reg reset = 1;

top dut (.clk(clk), .reset(reset));

always #10 clk = ~clk;      // 20 ns clock

initial begin
    #25  reset = 0;         // release reset
    #800;                   // program is done by about 770 ns

    $display("x1  = %0d (expect 10)",       dut.dpu.rfu.reg_mem[1]);
    $display("x2  = %0d (expect 20)",       dut.dpu.rfu.reg_mem[2]);
    $display("x3  = %0d (expect 30)",       dut.dpu.rfu.reg_mem[3]);
    $display("x5  = %0d (expect 77)",       dut.dpu.rfu.reg_mem[5]);
    $display("x10 = %0d (expect 20)",       dut.dpu.rfu.reg_mem[10]);
    $display("x13 = %0d (expect 1)",        dut.dpu.rfu.reg_mem[13]);
    $display("x15 = %0d (expect 5)",        dut.dpu.rfu.reg_mem[15]);
    $display("x24 = %h (expect 12345000)",  dut.dpu.rfu.reg_mem[24]);
    $display("x26 = %0d (expect 30)",       dut.dpu.rfu.reg_mem[26]);
    $display("dm[0] = %0d (expect 30)",     dut.dpu.d_mem.dm[0]);
    $display("PC  = %h (expect 000000a0)",  dut.ifu.pc);

    $finish;
end

endmodule

