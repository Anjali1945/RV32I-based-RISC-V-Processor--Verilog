```verilog 

`timescale 1ns / 1ps

module top_tb;

    // Testbench signals
    reg clk;
    reg reset;

    // Device Under Test (DUT)
    top dut (
        .clk(clk),
        .reset(reset)
    );

    // 20 ns clock period = 50 MHz
    always #10 clk = ~clk;

    // Reset and simulation control
    initial begin
        clk   = 1'b0;
        reset = 1'b1;

        // Keep reset active for 25 ns
        #25;
        reset = 1'b0;

        // Allow the instruction sequence to execute
        #1100;

        // Print selected register values
        $display("");
        $display("================================");
        $display(" FINAL REGISTER VALUES");
        $display("================================");

        $display("x1  = %h", dut.dpu.rfu.reg_mem[1]);
        $display("x2  = %h", dut.dpu.rfu.reg_mem[2]);
        $display("x3  = %h", dut.dpu.rfu.reg_mem[3]);
        $display("x5  = %h", dut.dpu.rfu.reg_mem[5]);
        $display("x7  = %h", dut.dpu.rfu.reg_mem[7]);
        $display("x8  = %h", dut.dpu.rfu.reg_mem[8]);
        $display("x9  = %h", dut.dpu.rfu.reg_mem[9]);
        $display("x10 = %h", dut.dpu.rfu.reg_mem[10]);
        $display("x13 = %h", dut.dpu.rfu.reg_mem[13]);
        $display("x15 = %h", dut.dpu.rfu.reg_mem[15]);
        $display("x24 = %h", dut.dpu.rfu.reg_mem[24]);
        $display("x26 = %h", dut.dpu.rfu.reg_mem[26]);

        $display("Data memory dm[0] = %h",
                 dut.dpu.d_mem.dm[0]);

        $display("Final PC = %h", dut.ifu.pc);
        $display("================================");

        $finish;
    end

    // Print a trace whenever the PC or instruction changes
    initial begin
        $monitor(
            "Time=%0t ns | PC=%h | Instruction=%h | Reset=%b",
            $time,
            dut.ifu.pc,
            dut.imu.instruction_code,
            reset
        );
    end

endmodule

```
