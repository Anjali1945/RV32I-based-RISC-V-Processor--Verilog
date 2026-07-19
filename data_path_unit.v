```verilog 
`timescale 1ns / 1ps

module data_path_unit(
    input        clk,
    input        reset,

    input [31:0] pc,

    input [4:0]  read_reg_num1,
    input [4:0]  read_reg_num2,
    input [4:0]  write_reg_num1,

    input [5:0]  alu_control,
    input [31:0] imm_val,
    input [4:0]  shamt,

    input        jump,
    input        branch,
    input        mem_read,
    input        mem_write,
    input        lui_control,

    input [31:0] return_addr,

    output [31:0] jump_addr,
    output        branch_control
);

//====================================================
// Internal Signals
//====================================================
wire [31:0] read_data_1;
wire [31:0] read_data_2;
wire [31:0] alu_out;

wire [31:0] data_out_to_dm;
wire [31:0] write_data_dm;

wire [31:0] ld_st_dm_addr =
                (mem_read || mem_write) ? alu_out : 32'b0;

//====================================================
// Arithmetic Logic Unit (ALU)
//====================================================
alu alu_unit(
    pc,
    read_data_1,
    read_data_2,
    alu_control,
    shamt,
    imm_val,
    alu_out
);

//====================================================
// Register File
//====================================================
register_file rfu(
    clk,
    reset,
    read_reg_num1,
    read_reg_num2,
    write_reg_num1,
    alu_out,
    write_data_dm,
    mem_read,
    mem_write,
    lui_control,
    jump,
    return_addr,

    read_data_1,
    read_data_2,
    data_out_to_dm
);

//====================================================
// Data Memory
//====================================================
data_memory d_mem(
    clk,
    reset,
    mem_read,
    mem_write,
    alu_control,
    data_out_to_dm,
    ld_st_dm_addr,
    write_data_dm
);

//====================================================
// Branch and Jump Logic
//====================================================
assign branch_control = (branch && (alu_out == 32'd1)) ? 1'b1 : 1'b0;

assign jump_addr = (jump) ? alu_out : 32'b0;

endmodule
```

