`timescale 1ns / 1ps

module alu(
input [31:0]pc,
input [31:0]src1, src2,
input [5:0]alu_control,
input [4:0]shamt, //shift amount
input [31:0]imm_val_r,
output reg [31:0]result
    );
    
always @(*)
 begin
   case (alu_control)
     // R-type instructions
     6'b000001 :  result = src1 + src2;           //addition
     6'b000010 :  result = src1 - src2;         //subtraction
     6'b000011 :  result = src1 << src2;           //shift left logical
     6'b000100 :  result = ($signed(src1) < $signed(src2))? 1 : 0;   //set less than signed
     6'b000101 :  result = (src1 < src2)? 1 : 0;  // set less than unsigned
     6'b000110 :  result = src1 ^ src2;  //xor
     6'b000111 :  result = src1 >> src2; //shift right logical
     6'b001000 :  result = $signed(src1) >> src2;  //shift right arithmetic
     6'b001001 :  result = src1 | src2;  //or operation
     6'b001010 :  result = src1 & src2; //and operation
     // I- type instructions
     6'b001011 :  result = src1 + imm_val_r; // add immediate
     6'b001100 :  result = ($signed(src1) < $signed(imm_val_r) )? 1 : 0; //set less than immediate
     6'b001101 :  result = ( src1 < imm_val_r )? 1: 0; // set less than unsigned immediate
     6'b001110 :  result = src1 ^ imm_val_r; // xor immediate
     6'b001111 :  result = src1 | imm_val_r; //or immediate
     6'b010000 :  result = src1 & imm_val_r; //and immediate
     6'b010001 :  result = src1 << shamt; //shift left logical immediate
     6'b010010 :  result = src1 >> shamt; //shift right logical immediate
     6'b010011 :  result = $signed(src1) >> shamt; // shift right arithm=etic immediate
     // Load instruction I-type 
     6'b010100 :  result =  src1 + imm_val_r;//load byte
     6'b010101 :  result =  src1 + imm_val_r;//load half
     6'b010110 :  result =  src1 + imm_val_r;//load word
     6'b010111 :  result =  src1 + imm_val_r;//load byte unsigned
     6'b011000 :  result =  src1 + imm_val_r;//load half unsigned
     //store instructions
     6'b011001 :  result = src1 + imm_val_r; //store
     6'b011010 :  result = src1 + imm_val_r; //store
     6'b011011 :  result = src1 + imm_val_r; //store
     // Branch instructions
     6'b011100 :  result = (src1 == src2)? 1:0; //branch equal to 
     6'b011101 :  result = (src1 != src2)? 1:0; //branch not equal to
     6'b011110 :  result = ($signed(src1) < $signed(src2))? 1:0; //branch less than
     6'b011111 :  result = ($signed(src1) >= $signed(src2))? 1:0; //branch greater than equal to
     6'b100000 :  result = (src1 < src2)? 1:0; //branch less tha unsigned
     6'b100001 :  result = (src1 >= src2)? 1:0; //branch greater than equal to unsigned
     //Jump and link instruction
     6'b100010 :  result = pc + imm_val_r;
     //Jump and link register 
     6'b100011 :  result = (src1 + imm_val_r) & ~1;
     //U - type
     6'b100100 :  result =  imm_val_r;// load upper immediate no operation needed
     6'b100101 :  result = pc + imm_val_r; //add upper immediate to pc
   endcase
 end
     
endmodule
