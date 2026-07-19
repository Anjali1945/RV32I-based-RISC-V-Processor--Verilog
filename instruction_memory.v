`timescale 1ns / 1ps

module instruction_memory(
input clk, reset,
input [31:0]pc,
output  [31:0]instruction_code
    );
reg [7:0] mem[255:0];

assign instruction_code = { mem[pc+3], mem[pc+2], mem[pc+1], mem[pc]};

always @(posedge clk)
 begin
  if(reset) begin
   // ADDI x1,x0,10
mem[3]=8'h00;
mem[2]=8'ha0;
mem[1]=8'h00;
mem[0]=8'h93;

// ADDI x2,x0,20
mem[7]=8'h01;
mem[6]=8'h40;
mem[5]=8'h01;
mem[4]=8'h13;

// ADD x3,x1,x2
mem[11]=8'h00;
mem[10]=8'h20;
mem[9]=8'h81;
mem[8]=8'hb3;

// SW x3,0(x0)
mem[15]=8'h00;
mem[14]=8'h30;
mem[13]=8'h20;
mem[12]=8'h23;

// LW x6,0(x0)
//mem[19]=8'h00;
//mem[18]=8'h00;
//mem[17]=8'h23;
//mem[16]=8'h03;

// ADD x3,x1,x2
mem[19]=8'h00;
mem[18]=8'h20;
mem[17]=8'h81;
mem[16]=8'hb3;


  end   
 end
     
endmodule
