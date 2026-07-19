```verilog
`timescale 1ns / 1ps

module imm_val_generator(
    inout        reset,
    input [31:0] instruction_code,

    output reg [31:0] imm_val
);

wire [6:0] opcode = instruction_code[6:0];

always @(*) begin

    if (reset)
        imm_val = 32'b0;

    else begin
        case (opcode)

            // I-Type Instructions
            7'b0010011 :
                imm_val = {{20{instruction_code[31]}},
                            instruction_code[31:20]};

            // Load Instructions
            7'b0000011 :
                imm_val = {{20{instruction_code[31]}},
                            instruction_code[31:20]};

            // Store Instructions
            7'b0100011 :
                imm_val = {{20{instruction_code[31]}},
                            instruction_code[31:25],
                            instruction_code[11:7]};

            // Branch Instructions
            7'b1100011 :
                imm_val = {{20{instruction_code[31]}},
                            instruction_code[31],
                            instruction_code[7],
                            instruction_code[30:25],
                            instruction_code[11:8],
                            1'b0};

            // JAL
            7'b1101111 :
                imm_val = {{12{instruction_code[31]}},
                            instruction_code[31],
                            instruction_code[19:12],
                            instruction_code[20],
                            instruction_code[30:21],
                            1'b0};

            // JALR
            7'b1100111 :
                imm_val = {{20{instruction_code[31]}},
                            instruction_code[31:20]};

            // LUI
            7'b0110111 :
                imm_val = {instruction_code[31:12], 12'b0};

            // AUIPC
            7'b0010111 :
                imm_val = {instruction_code[31:12], 12'b0};

            default :
                imm_val = 32'b0;

        endcase
    end
end

endmodule
```

