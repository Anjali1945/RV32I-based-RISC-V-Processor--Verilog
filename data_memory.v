`timescale 1ns / 1ps 

module data_memory(
input clk, reset,
input mem_read, mem_write,
input [5:0]alu_control,
input [31:0]data_reg_to_dm,
input [31:0]load_store_dm_addr,
output reg [31:0]read_data_dm_to_reg
    );
    
reg [31:0] dm[7:0];
integer i=0;
always @(posedge clk)
 begin
  if(reset) begin
   for( i=0; i<256; i= i + 1)
    dm[i] = 0;
    end
  end
  always @( load_store_dm_addr | mem_write | mem_read )  
    begin
     if ( mem_read ) begin
       case (alu_control)
             6'b010100 : read_data_dm_to_reg = {{24{dm[load_store_dm_addr][7]}},dm[load_store_dm_addr][7:0]}; // load byte
             6'b010101 : read_data_dm_to_reg = {{16{dm[load_store_dm_addr][15]}},dm[load_store_dm_addr][15:0]}; // load half
             6'b010110 : read_data_dm_to_reg = dm[load_store_dm_addr]; // load word
             6'b010111 : read_data_dm_to_reg = {24'b0,dm[load_store_dm_addr][7:0]}; //load byte unsugned
             6'b011000 : read_data_dm_to_reg = {16'b0,dm[load_store_dm_addr][15:0]}; // loadhalf unsigned       
       endcase
      end
     else if( mem_write )
       case (alu_control )
              6'b011001: dm[load_store_dm_addr] = {{24{data_reg_to_dm[7]}},data_reg_to_dm[7:0]}; // store byte
              6'b011010: dm[load_store_dm_addr] = {{16{data_reg_to_dm[15]}},data_reg_to_dm[15:0]}; // store half
              6'b011011: dm[load_store_dm_addr] = data_reg_to_dm; // store word
           endcase 
     end
     
endmodule
