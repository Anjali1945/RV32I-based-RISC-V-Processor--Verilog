```verilog 
`timescale 1ns / 1ps

module register_file(
    input        clk,
    input        reset,

    input [4:0]  read_reg_num1,
    input [4:0]  read_reg_num2,
    input [4:0]  write_reg_num1,

    input [31:0] write_data_rd,
    input [31:0] write_data_dm,

    input        mem_read,
    input        mem_write,
    input        lui_control,
    input        jump,

    input [31:0] return_addr,

    output [31:0] read_data_1,
    output [31:0] read_data_2,
    output reg [31:0] data_out_to_dm
);

reg [31:0] reg_mem [31:0];
integer i = 0;

//====================================================
// Register Initialization
//====================================================
always @(posedge clk) begin

    // x0 is hardwired to zero
    reg_mem[0] = 32'b0;

    if (reset) begin
        for (i = 1; i < 32; i = i + 1)
            reg_mem[i] = i;

        data_out_to_dm = 32'b0;
    end

end

//====================================================
// Register Write Logic
//====================================================
always @(write_data_rd or write_data_dm) begin

    // Load Instructions
    if (mem_read)
        reg_mem[write_reg_num1] = write_data_dm;

    // Store Instructions
    if (mem_write)
        data_out_to_dm = reg_mem[read_reg_num2];

    // LUI/AUIPC
    if (lui_control)
        reg_mem[write_reg_num1] = write_data_rd;

    // JAL/JALR
    if (jump)
        reg_mem[write_reg_num1] = return_addr;

    // Arithmetic Instructions
    else
        reg_mem[write_reg_num1] = write_data_rd;

end

//====================================================
// Register Read Logic
//====================================================
assign read_data_1 = reg_mem[read_reg_num1];
assign read_data_2 = reg_mem[read_reg_num2];

endmodule
```

