`timescale 1ns / 1ps

module data_path_unit(
input clk, reset,
input [31:0]pc,
input [4:0]read_reg_num1, read_reg_num2,
input [4:0]write_reg_num1,
input [5:0]alu_control,
input [31:0]imm_val,
inout [4:0]shamt,
input jump, branch, mem_read, mem_write, lui_control,
input [31:0]return_addr,//current_pc
output [31:0]jump_addr,
output branch_control
    );

wire [31:0]read_data_1, read_data_2;
wire [31:0]alu_out;

// ALU - Arithmetic and logical unit
alu alu_unit( //input
              pc,
              read_data_1, 
              read_data_2,
              alu_control,
              shamt, //shift amount
              imm_val,
              //output
              alu_out ); 
 
wire [31:0]data_out_to_dm;         
wire [31:0]write_data_dm; 
// Register unit - 32 registers, 32 bit addressable, each locaion 32 bit            
register_file rfu( //input
               clk, 
               reset,
               read_reg_num1, 
               read_reg_num2,
               write_reg_num1,
               alu_out,
               write_data_dm,//write data from dm to reg
               mem_read, 
               mem_write,
               lui_control, 
               jump,
               return_addr,
               //output
               read_data_1, 
               read_data_2,
               data_out_to_dm );

wire [31:0]ld_st_dm_addr = (mem_read | mem_write)? alu_out : 0;   
            
data_memory d_mem( //input 
                  clk, 
                  reset,
                  mem_read, 
                  mem_write,
                  func3,
                  data_out_to_dm, //data_reg_to_dm
                  ld_st_dm_addr, //addr of mem location to access dm
                  //output
                  write_data_dm //read_data_dm_to_reg
                   );               
               
assign branch_control = (alu_out == 1 && branch )? 1 :0; 
assign jump_addr = (jump) ? alu_out : 0;               
        
endmodule
