```verilog
`timescale 1ns / 1ps

module alu(
    input  [31:0] pc,
    input  [31:0] src1,
    input  [31:0] src2,
    input  [5:0]  alu_control,
    input  [4:0]  shamt,
    input  [31:0] imm_val_r,

    output reg [31:0] result
);

always @(*) begin
    case (alu_control)

    //====================================================
    // R-Type Instructions
    //====================================================
    6'b000001 : result = src1 + src2;                                   // ADD
    6'b000010 : result = src1 - src2;                                   // SUB
    6'b000011 : result = src1 << src2;                                  // SLL
    6'b000100 : result = ($signed(src1) < $signed(src2)) ? 1 : 0;       // SLT
    6'b000101 : result = (src1 < src2) ? 1 : 0;                         // SLTU
    6'b000110 : result = src1 ^ src2;                                   // XOR
    6'b000111 : result = src1 >> src2;                                  // SRL
    6'b001000 : result = $signed(src1) >> src2;                         // SRA
    6'b001001 : result = src1 | src2;                                   // OR
    6'b001010 : result = src1 & src2;                                   // AND

    //====================================================
    // I-Type Arithmetic Instructions
    //====================================================
    6'b001011 : result = src1 + imm_val_r;                              // ADDI
    6'b001100 : result = ($signed(src1) < $signed(imm_val_r)) ? 1 : 0;  // SLTI
    6'b001101 : result = (src1 < imm_val_r) ? 1 : 0;                    // SLTIU
    6'b001110 : result = src1 ^ imm_val_r;                              // XORI
    6'b001111 : result = src1 | imm_val_r;                              // ORI
    6'b010000 : result = src1 & imm_val_r;                              // ANDI
    6'b010001 : result = src1 << shamt;                                 // SLLI
    6'b010010 : result = src1 >> shamt;                                 // SRLI
    6'b010011 : result = $signed(src1) >> shamt;                        // SRAI

    //====================================================
    // Load Instructions
    //====================================================
    6'b010100 : result = src1 + imm_val_r;                              // LB
    6'b010101 : result = src1 + imm_val_r;                              // LH
    6'b010110 : result = src1 + imm_val_r;                              // LW
    6'b010111 : result = src1 + imm_val_r;                              // LBU
    6'b011000 : result = src1 + imm_val_r;                              // LHU

    //====================================================
    // Store Instructions
    //====================================================
    6'b011001 : result = src1 + imm_val_r;                              // SB
    6'b011010 : result = src1 + imm_val_r;                              // SH
    6'b011011 : result = src1 + imm_val_r;                              // SW

    //====================================================
    // Branch Instructions
    //====================================================
    6'b011100 : result = (src1 == src2) ? 1 : 0;                        // BEQ
    6'b011101 : result = (src1 != src2) ? 1 : 0;                        // BNE
    6'b011110 : result = ($signed(src1) < $signed(src2)) ? 1 : 0;       // BLT
    6'b011111 : result = ($signed(src1) >= $signed(src2)) ? 1 : 0;      // BGE
    6'b100000 : result = (src1 < src2) ? 1 : 0;                         // BLTU
    6'b100001 : result = (src1 >= src2) ? 1 : 0;                        // BGEU

    //====================================================
    // Jump Instructions
    //====================================================
    6'b100010 : result = pc + imm_val_r;                                // JAL
    6'b100011 : result = (src1 + imm_val_r) & ~1;                       // JALR

    //====================================================
    // U-Type Instructions
    //====================================================
    6'b100100 : result = imm_val_r;                                     // LUI
    6'b100101 : result = pc + imm_val_r;                                // AUIPC

    default  : result = 32'b0;

    endcase
end

endmodule
```
