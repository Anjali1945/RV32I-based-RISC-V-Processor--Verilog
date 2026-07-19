
# RISC-V RV32I Processor (Verilog HDL)

A 32-bit RISC-V processor implementing the RV32I base instruction set in Verilog HDL. The project was developed to gain hands-on experience in RTL design, processor architecture, and functional verification.

## Features

* RV32I ISA implementation
* Modular RTL design
* Single-cycle processor architecture
* Instruction Fetch Unit (IFU)
* Control Unit
* ALU
* Register File (32 × 32-bit)
* Instruction Memory
* Data Memory
* Immediate Value Generator
* Branch and Jump support
* Functional simulation in Vivado

---

## Supported Instructions

| Category        | Instructions                                         |
| --------------- | ---------------------------------------------------- |
| R-Type          | ADD, SUB, AND, OR, XOR, SLL, SRL, SRA, SLT, SLTU     |
| I-Type          | ADDI, ANDI, ORI, XORI, SLLI, SRLI, SRAI, SLTI, SLTIU |
| Load            | LB, LH, LW, LBU, LHU                                 |
| Store           | SB, SH, SW                                           |
| Branch          | BEQ, BNE, BLT, BGE, BLTU, BGEU                       |
| Jump            | JAL, JALR                                            |
| Upper Immediate | LUI, AUIPC                                           |

---

##Project Structure
```text
.
├── top.v
├── top_tb.v
├── instruction_fetch_unit.v
├── instruction_memory.v
├── control_unit.v
├── imm_val_generator.v
├── data_path_unit.v
├── register_file.v
├── alu.v
├── data_memory.v
└── README.md
```

## RTL Hierarchy

```text
top
├── instruction_fetch_unit
├── instruction_memory
├── control_unit
├── imm_val_generator
└── data_path_unit
    ├── register_file
    ├── alu
    └── data_memory
```

---

## Design Flow

```text
RV32I ISA
   ↓
RTL Module Design
   ↓
Module Integration
   ↓
Simulation (Vivado)
   ↓
Debugging
```

---

## Tools Used

* Xilinx Vivado

---

## Key Learnings

* RTL design using Verilog HDL
* RISC-V processor architecture
* Datapath and control unit design
* Branch and jump implementation
* Memory interfacing
* Functional verification using simulation

---

## Author

**Anjali Thaware**

* B.Tech (Electronics & Communication Engineering)
* Interested in RTL Design, Processor Design, and Embedded Systems
