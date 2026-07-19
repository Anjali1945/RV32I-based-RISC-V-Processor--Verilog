`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.07.2026 10:38:12
// Design Name: 
// Module Name: instruction_fetch_unit
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


module instruction_fetch_unit(
input clk, reset,
input [31:0]imm_addr_jump, imm_addr_branch,
input branch_control,jump,
output reg [31:0]pc, current_pc
    );
    
// PC-program counter Logic   
always @ (posedge clk)
 begin
   if(reset)
    pc<= 0;
   else if( branch_control)
    pc <=  pc + imm_addr_branch;
   else if (jump)
    pc <=  imm_addr_jump;
   else 
    pc <= pc + 4;   
 end
 
 // Current pc logic to store return address
 always @ (posedge clk )
   begin
      if(reset)
       current_pc <= 0;
      else if (jump)
       current_pc <= pc + 4;
      else
       current_pc <= current_pc; 
   end
   
  
endmodule
