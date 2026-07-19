```verilog id="49mdqs"
`timescale 1ns / 1ps

module data_memory(
    input        clk,
    input        reset,
    input        mem_read,
    input        mem_write,
    input [5:0]  alu_control,
    input [31:0] data_reg_to_dm,
    input [31:0] load_store_dm_addr,

    output reg [31:0] read_data_dm_to_reg
);

    reg [31:0] dm [31:0];
integer i = 0;

//====================================================
// Memory Initialization
//====================================================
always @(posedge clk) begin
    if (reset) begin
        for (i = 0; i < 32; i = i + 1)
            dm[i] = 32'b0;
    end
end

//====================================================
// Memory Read/Write Operations
//====================================================
always @(load_store_dm_addr or mem_read or mem_write) begin

    // Load Instructions
    if (mem_read) begin
        case (alu_control)

            6'b010100:
                read_data_dm_to_reg =
                    {{24{dm[load_store_dm_addr][7]}},
                     dm[load_store_dm_addr][7:0]};      // LB

            6'b010101:
                read_data_dm_to_reg =
                    {{16{dm[load_store_dm_addr][15]}},
                     dm[load_store_dm_addr][15:0]};     // LH

            6'b010110:
                read_data_dm_to_reg =
                    dm[load_store_dm_addr];             // LW

            6'b010111:
                read_data_dm_to_reg =
                    {24'b0,
                     dm[load_store_dm_addr][7:0]};      // LBU

            6'b011000:
                read_data_dm_to_reg =
                    {16'b0,
                     dm[load_store_dm_addr][15:0]};     // LHU

        endcase
    end

    // Store Instructions
    else if (mem_write) begin
        case (alu_control)

            6'b011001:
                dm[load_store_dm_addr] =
                    {{24{data_reg_to_dm[7]}},
                     data_reg_to_dm[7:0]};              // SB

            6'b011010:
                dm[load_store_dm_addr] =
                    {{16{data_reg_to_dm[15]}},
                     data_reg_to_dm[15:0]};             // SH

            6'b011011:
                dm[load_store_dm_addr] =
                    data_reg_to_dm;                     // SW

        endcase
    end
end

endmodule
```
