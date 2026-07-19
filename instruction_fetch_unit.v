```verilog 
`timescale 1ns / 1ps

module instruction_fetch_unit(
    input        clk,
    input        reset,

    input [31:0] imm_addr_jump,
    input [31:0] imm_addr_branch,

    input        branch_control,
    input        jump,

    output reg [31:0] pc,
    output reg [31:0] current_pc
);

//====================================================
// Program Counter (PC) Logic
//====================================================
always @(posedge clk) begin

    if (reset)
        pc <= 32'b0;

    else if (branch_control)
        pc <= pc + imm_addr_branch;

    else if (jump)
        pc <= imm_addr_jump;

    else
        pc <= pc + 32'd4;

end

//====================================================
// Return Address Logic
// Stores PC + 4 for JAL/JALR Instructions
//====================================================
always @(posedge clk) begin

    if (reset)
        current_pc <= 32'b0;

    else if (jump)
        current_pc <= pc + 32'd4;

    else
        current_pc <= current_pc;

end

endmodule
```

