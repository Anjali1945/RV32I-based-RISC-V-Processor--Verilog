```verilog 

`timescale 1ns / 1ps


module instruction_memory(
input clk, reset,
input [31:0]pc,
output  [31:0]instruction_code
    );
reg [7:0] mem[255:0];
integer i;

assign instruction_code = { mem[pc+3], mem[pc+2], mem[pc+1], mem[pc]};

always @(posedge clk) begin
    if (reset) begin

        // Initialize instruction memory
        for (i = 0; i < 256; i = i + 1)
            mem[i] = 8'h00;

        // -----------------------------------------
        // BASIC ARITHMETIC
        // -----------------------------------------

        // PC 0: ADDI x1, x0, 10
        // x1 = 10
        mem[0]=8'h93; mem[1]=8'h00;
        mem[2]=8'hA0; mem[3]=8'h00;

        // PC 4: ADDI x2, x0, 20
        // x2 = 20
        mem[4]=8'h13; mem[5]=8'h01;
        mem[6]=8'h40; mem[7]=8'h01;

        // PC 8: ADDI x4, x0, 1
        // x4 = 1 (shift amount)
        mem[8]=8'h13; mem[9]=8'h02;
        mem[10]=8'h10; mem[11]=8'h00;

        // PC 12: ADD x3, x1, x2
        // x3 = 30
        mem[12]=8'hB3; mem[13]=8'h81;
        mem[14]=8'h20; mem[15]=8'h00;

        // PC 16: SUB x5, x2, x1
        // Expected x5 = 10
        mem[16]=8'hB3; mem[17]=8'h02;
        mem[18]=8'h11; mem[19]=8'h40;

        // PC 20: AND x7, x1, x2
        mem[20]=8'hB3; mem[21]=8'hF3;
        mem[22]=8'h20; mem[23]=8'h00;

        // PC 24: OR x8, x1, x2
        mem[24]=8'h33; mem[25]=8'hE4;
        mem[26]=8'h20; mem[27]=8'h00;

        // PC 28: XOR x9, x1, x2
        mem[28]=8'hB3; mem[29]=8'hC4;
        mem[30]=8'h20; mem[31]=8'h00;

        // PC 32: SLL x10, x1, x4
        // Expected x10 = 20
        mem[32]=8'h33; mem[33]=8'h95;
        mem[34]=8'h40; mem[35]=8'h00;

        // PC 36: SRL x11, x2, x4
        // Expected x11 = 10
        mem[36]=8'hB3; mem[37]=8'h55;
        mem[38]=8'h41; mem[39]=8'h00;

        // PC 40: SRA x12, x2, x4
        mem[40]=8'h33; mem[41]=8'h56;
        mem[42]=8'h41; mem[43]=8'h40;

        // PC 44: SLT x13, x1, x2
        // Expected x13 = 1
        mem[44]=8'hB3; mem[45]=8'hA6;
        mem[46]=8'h20; mem[47]=8'h00;

        // PC 48: SLTU x14, x1, x2
        // Expected x14 = 1
        mem[48]=8'h33; mem[49]=8'hB7;
        mem[50]=8'h20; mem[51]=8'h00;

        // -----------------------------------------
        // IMMEDIATE INSTRUCTIONS
        // -----------------------------------------

        // PC 52: ADDI x15, x1, -5
        // Expected x15 = 5
        mem[52]=8'h93; mem[53]=8'h87;
        mem[54]=8'hB0; mem[55]=8'hFF;

        // PC 56: SLTI x16, x1, 15
        // Expected x16 = 1
        mem[56]=8'h13; mem[57]=8'hA8;
        mem[58]=8'hF0; mem[59]=8'h00;

        // PC 60: SLTIU x17, x1, 15
        // Expected x17 = 1
        mem[60]=8'h93; mem[61]=8'hB8;
        mem[62]=8'hF0; mem[63]=8'h00;

        // PC 64: XORI x18, x1, 3
        mem[64]=8'h13; mem[65]=8'hC9;
        mem[66]=8'h30; mem[67]=8'h00;

        // PC 68: ORI x19, x1, 4
        mem[68]=8'h93; mem[69]=8'hE9;
        mem[70]=8'h40; mem[71]=8'h00;

        // PC 72: ANDI x20, x1, 7
        mem[72]=8'h13; mem[73]=8'hFA;
        mem[74]=8'h70; mem[75]=8'h00;

        // PC 76: SLLI x21, x1, 2
        // Expected x21 = 40
        mem[76]=8'h93; mem[77]=8'h9A;
        mem[78]=8'h20; mem[79]=8'h00;

        // PC 80: SRLI x22, x2, 2
        // Expected x22 = 5
        mem[80]=8'h13; mem[81]=8'h5B;
        mem[82]=8'h21; mem[83]=8'h00;

        // PC 84: SRAI x23, x2, 2
        mem[84]=8'h93; mem[85]=8'h5B;
        mem[86]=8'h21; mem[87]=8'h40;

        // -----------------------------------------
        // U-TYPE INSTRUCTIONS
        // -----------------------------------------

        // PC 88: LUI x24, 0x12345
        // Expected x24 = 0x12345000
        mem[88]=8'h37; mem[89]=8'h5C;
        mem[90]=8'h34; mem[91]=8'h12;

        // PC 92: AUIPC x25, 0x00001
        // Expected x25 = PC + 0x1000
        mem[92]=8'h97; mem[93]=8'h1C;
        mem[94]=8'h00; mem[95]=8'h00;

        // -----------------------------------------
        // STORE AND LOAD INSTRUCTIONS
        // -----------------------------------------

        // PC 96: SW x3, 0(x0)
        // Store 30 at data memory address 0
        mem[96]=8'h23; mem[97]=8'h20;
        mem[98]=8'h30; mem[99]=8'h00;

        // PC 100: LW x26, 0(x0)
        mem[100]=8'h03; mem[101]=8'h2D;
        mem[102]=8'h00; mem[103]=8'h00;

        // PC 104: LB x27, 0(x0)
        mem[104]=8'h83; mem[105]=8'h0D;
        mem[106]=8'h00; mem[107]=8'h00;

        // PC 108: LBU x28, 0(x0)
        mem[108]=8'h03; mem[109]=8'h4E;
        mem[110]=8'h00; mem[111]=8'h00;

        // PC 112: SH x2, 4(x0)
        mem[112]=8'h23; mem[113]=8'h12;
        mem[114]=8'h20; mem[115]=8'h00;

        // PC 116: LH x29, 4(x0)
        mem[116]=8'h83; mem[117]=8'h1E;
        mem[118]=8'h40; mem[119]=8'h00;

        // PC 120: LHU x30, 4(x0)
        mem[120]=8'h03; mem[121]=8'h5F;
        mem[122]=8'h40; mem[123]=8'h00;

        // PC 124: SB x1, 8(x0)
        mem[124]=8'h23; mem[125]=8'h04;
        mem[126]=8'h10; mem[127]=8'h00;

        // PC 128: LB x31, 8(x0)
        mem[128]=8'h83; mem[129]=8'h0F;
        mem[130]=8'h80; mem[131]=8'h00;

        // -----------------------------------------
        // BRANCH INSTRUCTIONS
        // -----------------------------------------

        // PC 132: BEQ x1, x1, +8
        // Taken: skips PC 136, goes to PC 140
        mem[132]=8'h63; mem[133]=8'h84;
        mem[134]=8'h10; mem[135]=8'h00;

        // PC 136: ADDI x5, x0, 99
        // Should be skipped by BEQ
        mem[136]=8'h93; mem[137]=8'h02;
        mem[138]=8'h30; mem[139]=8'h06;

        // PC 140: ADDI x5, x0, 77
        // Expected x5 = 77
        mem[140]=8'h93; mem[141]=8'h02;
        mem[142]=8'hD0; mem[143]=8'h04;

        // PC 144: BNE x1, x2, +8
        // Taken: skips PC 148, goes to PC 152
        mem[144]=8'h63; mem[145]=8'h94;
        mem[146]=8'h20; mem[147]=8'h00;

        // PC 148: ADDI x6, x0, 88
        // Should be skipped by BNE
        mem[148]=8'h13; mem[149]=8'h03;
        mem[150]=8'h80; mem[151]=8'h05;

        // -----------------------------------------
        // JALR AND JAL
        // -----------------------------------------

        // PC 152: ADDI x30, x0, 160
        // Set jump target address
        mem[152]=8'h13; mem[153]=8'h0F;
        mem[154]=8'h00; mem[155]=8'h0A;

        // PC 156: JALR x0, 0(x30)
        // Jump to PC 160
        mem[156]=8'h67; mem[157]=8'h00;
        mem[158]=8'h0F; mem[159]=8'h00;

        // PC 160: JAL x0, 0
        // Stay here to prevent fetching uninitialized instructions
        mem[160]=8'h6F; mem[161]=8'h00;
        mem[162]=8'h00; mem[163]=8'h00;
  end   
 end
     
endmodule

```
