```verilog 
`timescale 1ns / 1ps

module top(
    input clk,
    input reset
);

//====================================================
// Internal Signals
//====================================================

// Control Signals
wire        jump;
wire        branch;
wire        branch_control;
wire        mem_read;
wire        mem_write;
wire        lui_control;

// Datapath Signals
wire [5:0]  alu_control;
wire [31:0] imm_val_top;

wire [31:0] pc;
wire [31:0] current_pc;
wire [31:0] jump_addr;
wire [31:0] instruction_code;

//====================================================
// Instruction Fetch Unit
//====================================================
instruction_fetch_unit ifu(
    clk,
    reset,
    jump_addr,
    imm_val_top,
    branch_control,
    jump,
    pc,
    current_pc
);

//====================================================
// Instruction Memory
//====================================================
instruction_memory imu(
    clk,
    reset,
    pc,
    instruction_code
);

//====================================================
// Control Unit
//====================================================
control_unit cu(
    reset,
    instruction_code[31:25],   // func7
    instruction_code[14:12],   // func3
    instruction_code[6:0],     // opcode

    alu_control,
    mem_read,
    mem_write,
    branch,
    jump,
    lui_control
);

//====================================================
// Immediate Value Generator
//====================================================
imm_val_generator imm_value(
    reset,
    instruction_code,
    imm_val_top
);

//====================================================
// Datapath Unit
//====================================================
data_path_unit dpu(
    clk,
    reset,
    pc,
    instruction_code[19:15],   // rs1
    instruction_code[24:20],   // rs2
    instruction_code[11:7],    // rd

    alu_control,
    imm_val_top,
    instruction_code[24:20],   // shamt

    jump,
    branch,
    mem_read,
    mem_write,
    lui_control,

    current_pc,

    jump_addr,
    branch_control
);

endmodule
```
