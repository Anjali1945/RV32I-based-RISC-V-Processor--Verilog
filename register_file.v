`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.07.2026 12:44:00
// Design Name: 
// Module Name: register_file
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module register_file(
input clk, reset,
input [4:0]read_reg_num1, read_reg_num2,
input [4:0]write_reg_num1,
input [31:0]write_data_rd,
input [31:0]write_data_dm,
input mem_read, mem_write, lui_control, jump,
input [31:0]return_addr,
output [31:0]read_data_1, read_data_2,
output reg [31:0]data_out_to_dm
    );
    
 reg [31:0]reg_mem[31:0];  
 integer i= 0; 

 always @(posedge clk)
  begin
  reg_mem[0]= 0;
   if(reset) begin 
     for( i=1; i< 32; i= i +1)  
      reg_mem[i] = i;
     data_out_to_dm =0;
     end
  end
  
  always @(write_data_rd | write_data_dm ) 
     begin
       if(mem_read)
        begin
          reg_mem[write_reg_num1] = write_data_dm;
         end 
        if(mem_write)
         begin
          data_out_to_dm = reg_mem[read_reg_num2];
         end 
       if( lui_control)
        reg_mem[write_reg_num1] = write_data_rd;
       if(jump)
       reg_mem[write_reg_num1] = return_addr; 
       else 
        reg_mem[write_reg_num1] = write_data_rd;
      end 
   
   assign read_data_1 = reg_mem[read_reg_num1];
   assign read_data_2 = reg_mem[read_reg_num2];
   
 
     
endmodule
