`timescale 1ns / 1ps

module top(
input clk, reset
    );
 
 
 wire jump;  
 wire lui_control;
 wire [31:0]imm_val_top;  
 
 
 wire [31:0]pc, current_pc; 
 wire branch_control;
 wire [31:0]jump_addr; 
 // instruction fetch stage    
 instruction_fetch_unit ifu ( //input
                              clk,
                              reset,
                              jump_addr,//imm_val_jump
                              imm_val_top,//imm_val_branch
                              branch_control, 
                              jump,
                              //output
                              pc, 
                              current_pc );   
 
 wire [31:0]instruction_code; 
 
 //instruction memory which stores instructions in binary format
 instruction_memory imu ( //input
                          clk, 
                          reset,
                          pc,
                          //output
                          instruction_code );
 
 wire [5:0]alu_control;
 wire mem_read, mem_write;
 wire branch;
 
 //control unit 
 control_unit  cu( //input
                   reset, 
                   instruction_code[31:25], //func7
                   instruction_code[14:12], //func3
                   instruction_code[6:0],   //opcode
                   //output
                   alu_control,
                   mem_read, 
                   mem_write,
                   branch,
                   jump,  
                   lui_control );
               
 //Data Path Unit
 data_path_unit  dpu( //input
                      clk, 
                      reset,
                      pc,
                      instruction_code[19:15],//read_reg_num1 
                      instruction_code[24:20],//read_reg_num2
                      instruction_code[11:7], //write_reg_num1
                      alu_control,
                      imm_val_top,
                      instruction_code[24:20],//shamt - shift amount
                      jump, 
                      branch,
                      mem_read, 
                      mem_write, 
                      lui_control,
                      current_pc,
                      //output
                      jump_addr,
                      branch_control );              
    
    //Immediate value generator
    imm_val_generator imm_value(// input 
                                reset,
                                instruction_code,
                                //output
                                imm_val_top
    );
    
    endmodule
