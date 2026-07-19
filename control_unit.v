`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.07.2026 11:37:57
// Design Name: 
// Module Name: control_unit
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


module control_unit(
input reset, 
input [6:0]func7,
input [2:0]func3,
input [6:0]opcode,
output reg [5:0]alu_control,
output reg mem_read, mem_write, branch, jump, lui_control 
    );
    
 always @( posedge reset ) 
  begin 
   alu_control = 0;
   end
   
  always @ ( func3 or func7 or opcode )  
  begin
     // R-type instruction
     if (opcode == 7'b011_0011) begin
       branch = 0;
       jump = 0;
       mem_read = 0;
       mem_write = 0;
       lui_control = 0;
       
       case(func3)
        3'b000 : begin
               // Addition
               if (func7 == 0)
                 alu_control = 6'b000001;
               //Subtraction
               else if ( func7 == 64 )
                 alu_control = 6'b000010;   
               end
        
        3'b001 : begin
                 // Shift left logcal 
                 if(func7 == 0)
                  alu_control = 6'b000011;
                  end
                  
        3'b010 : begin 
                 // Set less than
                 if(func7 == 0)
                  alu_control = 6'b000100;
                  end
                  
        3'b011 : begin 
                 // Set less than unsigned
                 if(func7 == 0)
                  alu_control = 6'b000101;
                  end
        
        3'b100 : begin 
                 // XOR Operation
                 if(func7 == 0)
                  alu_control = 6'b000110;
                  end
        
        3'b101 : begin 
                 // Shift right logical
                 if(func7 == 0)
                  alu_control = 6'b000111;
                 //shift right arithmetic 
                 else if(func7 == 64)
                  alu_control = 6'b001000; 
                  end
        
        3'b110 : begin 
                 // OR Operation
                 if(func7 == 0)
                  alu_control = 6'b001001;
                  end
        
        3'b111: begin
                //AND Operation
                if (func7 ==0)
                 alu_control = 6'b001010;
                 end  
          endcase
          end       
        // end of R - type   
                
        // I - type Instruction    
        else if( opcode == 7'b001_0011)
          begin
          branch = 0; 
          jump = 0;  
          mem_read = 0;
          mem_write = 0;
          lui_control = 0;
           
            case(func3)
             3'b000 : begin
                     //add immediate
                      alu_control = 6'b001011;
                      end
             3'b010 : begin
                      //set less than immediate
                      alu_control = 6'b001100;
                      end
             3'b011 : begin
                     //set less than immediate unsigned
                      alu_control = 6'b001101;
                      end
             3'b100 : begin
                     //xor immediate
                      alu_control = 6'b001110;
                      end
             3'b110 : begin
                     //or immediate
                      alu_control = 6'b001111;
                      end        
             3'b111 : begin
                     //and immediate
                      alu_control = 6'b010000;
                      end
             3'b001 : begin
                     //shift left logical immediate
                     if( func7 == 0)
                       alu_control = 6'b010001;
                      end
             3'b101 : begin
                     //shift right logical immediate
                     if( func7 == 0)
                      alu_control = 6'b010010;
                      //shift right arithemtic immediate
                     else if( func7 ==64)
                      alu_control = 6'b010011; 
                     end
             endcase
          end
          // end of I-type instruction
          
          //Load instruction I- type
          else if (opcode == 7'b000_0011)
           begin
           branch = 0;
           jump = 0;
           mem_read = 1;
           mem_write = 0;
           lui_control = 0;
            
            case( func3 )
             3'b000 : alu_control = 6'b010100; // load byte
             3'b001 : alu_control = 6'b010101; // load half
             3'b010 : alu_control = 6'b010110; // load word
             3'b100 : alu_control = 6'b010111; //load byte unsugned
             3'b101 : alu_control = 6'b011000; // loadhalf unsigned
            endcase
           end
           //end of load instruction I type 
          
          //Store instruction I type
          else if ( opcode == 7'b010_0011)
           begin
           branch = 0;
           jump = 0;
           mem_read = 0;
           mem_write = 1;
           lui_control = 0;
            
            case (func3 )
              3'b000: alu_control = 6'b011001; // store byte
              3'b001: alu_control = 6'b011010; // store half
              3'b010: alu_control = 6'b011011; // store word
           endcase 
           end
           // end of Store type instruction 
          
          //branch type instruction
          else if (opcode == 7'b110_0011)
            begin
//             mem_to_reg = 0;
             branch = 1;      
             jump = 0;
             mem_read = 0;
             mem_write = 0;
             lui_control = 0;
             
             case(func3)
              3'b000 : begin
                     //branch equal to
                       alu_control = 6'b011100;
                     end
              3'b001 : begin
                      // branch not equal to 
                       alu_control = 6'b011101;
                      end
              3'b100 : begin
                      // branch less than 
                       alu_control = 6'b011110;
                      end 
              3'b101 : begin
                      // branch greater than equal to
                       alu_control = 6'b011111;
                      end  
              3'b110 : begin
                      // branch less than unsigned
                       alu_control = 6'b100000;
                      end                              
              3'b111 : begin
                      // branch greater than equal to unsigned 
                       alu_control = 6'b100001;
                      end
             endcase
            end
            // end of Branch instructions
            
           //jump and link instruction
           else if ( opcode == 7'b110_1111 )
             begin
              alu_control = 6'b100010;
              branch = 0;
              jump = 1;
              lui_control = 0;
              mem_write = 0;
              mem_read = 0;
             end
              
           //jump and link  register instruction
           else if ( opcode == 7'b110_0111 )
             begin
              alu_control = 6'b100011;
              branch = 0;
              jump = 1;
              lui_control = 0;
              mem_write = 0;
              mem_read = 0;
             end 
              
           // U- type instruction
           
           // load upper immediate
          else if ( opcode == 7'b011_0111)
           begin
              alu_control = 6'b100100;
              branch = 0;
              jump = 0;
              lui_control = 1;
              mem_write = 0;
              mem_read = 0;
           end
           
           // Add upper immediate to pc
           else if ( opcode == 7'b001_0111)
           begin
              alu_control = 6'b100101;
              branch = 0;
              jump = 0;
              lui_control = 1;
              mem_write = 0;
              mem_read = 0;
           end
           
  end
  
endmodule
