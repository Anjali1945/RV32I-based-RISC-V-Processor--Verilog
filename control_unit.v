```verilog 
`timescale 1ns / 1ps

module control_unit(
    input        reset,
    input [6:0]  func7,
    input [2:0]  func3,
    input [6:0]  opcode,

    output reg [5:0] alu_control,
    output reg       mem_read,
    output reg       mem_write,
    output reg       branch,
    output reg       jump,
    output reg       lui_control
);

always @(posedge reset) begin
    alu_control <= 6'b0;
end

always @(*) begin

    // Default values
    alu_control = 6'b0;
    mem_read    = 1'b0;
    mem_write   = 1'b0;
    branch      = 1'b0;
    jump        = 1'b0;
    lui_control = 1'b0;

    case (opcode)

    //====================================================
    // R-Type Instructions (0110011)
    //====================================================
    7'b011_0011: begin
        case (func3)

            3'b000:
                if (func7 == 7'd0)
                    alu_control = 6'b000001;       // ADD
                else if (func7 == 7'd64)
                    alu_control = 6'b000010;       // SUB

            3'b001:
                if (func7 == 7'd0)
                    alu_control = 6'b000011;       // SLL

            3'b010:
                if (func7 == 7'd0)
                    alu_control = 6'b000100;       // SLT

            3'b011:
                if (func7 == 7'd0)
                    alu_control = 6'b000101;       // SLTU

            3'b100:
                if (func7 == 7'd0)
                    alu_control = 6'b000110;       // XOR

            3'b101:
                if (func7 == 7'd0)
                    alu_control = 6'b000111;       // SRL
                else if (func7 == 7'd64)
                    alu_control = 6'b001000;       // SRA

            3'b110:
                if (func7 == 7'd0)
                    alu_control = 6'b001001;       // OR

            3'b111:
                if (func7 == 7'd0)
                    alu_control = 6'b001010;       // AND

        endcase
    end

    //====================================================
    // I-Type Arithmetic Instructions (0010011)
    //====================================================
    7'b001_0011: begin
        case (func3)

            3'b000: alu_control = 6'b001011;       // ADDI
            3'b010: alu_control = 6'b001100;       // SLTI
            3'b011: alu_control = 6'b001101;       // SLTIU
            3'b100: alu_control = 6'b001110;       // XORI
            3'b110: alu_control = 6'b001111;       // ORI
            3'b111: alu_control = 6'b010000;       // ANDI

            3'b001:
                if (func7 == 7'd0)
                    alu_control = 6'b010001;       // SLLI

            3'b101:
                if (func7 == 7'd0)
                    alu_control = 6'b010010;       // SRLI
                else if (func7 == 7'd64)
                    alu_control = 6'b010011;       // SRAI

        endcase
    end

    //====================================================
    // Load Instructions (0000011)
    //====================================================
    7'b000_0011: begin

        mem_read = 1'b1;

        case (func3)
            3'b000: alu_control = 6'b010100;       // LB
            3'b001: alu_control = 6'b010101;       // LH
            3'b010: alu_control = 6'b010110;       // LW
            3'b100: alu_control = 6'b010111;       // LBU
            3'b101: alu_control = 6'b011000;       // LHU
        endcase
    end

    //====================================================
    // Store Instructions (0100011)
    //====================================================
    7'b010_0011: begin

        mem_write = 1'b1;

        case (func3)
            3'b000: alu_control = 6'b011001;       // SB
            3'b001: alu_control = 6'b011010;       // SH
            3'b010: alu_control = 6'b011011;       // SW
        endcase
    end

    //====================================================
    // Branch Instructions (1100011)
    //====================================================
    7'b110_0011: begin

        branch = 1'b1;

        case (func3)
            3'b000: alu_control = 6'b011100;       // BEQ
            3'b001: alu_control = 6'b011101;       // BNE
            3'b100: alu_control = 6'b011110;       // BLT
            3'b101: alu_control = 6'b011111;       // BGE
            3'b110: alu_control = 6'b100000;       // BLTU
            3'b111: alu_control = 6'b100001;       // BGEU
        endcase
    end

    //====================================================
    // Jump Instructions
    //====================================================
    7'b110_1111: begin                           // JAL
        alu_control = 6'b100010;
        jump        = 1'b1;
    end

    7'b110_0111: begin                           // JALR
        alu_control = 6'b100011;
        jump        = 1'b1;
    end

    //====================================================
    // U-Type Instructions
    //====================================================
    7'b011_0111: begin                           // LUI
        alu_control = 6'b100100;
        lui_control = 1'b1;
    end

    7'b001_0111: begin                           // AUIPC
        alu_control = 6'b100101;
        lui_control = 1'b1;
    end

    endcase
end

endmodule
```

