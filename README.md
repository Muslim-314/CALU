# Complex Arithmetic Logic Unit
This repository contains the hardware design for an Arithmetic Logic Unit (ALU) specifically tailored to perform operations on complex numbers. Complex numbers are represented in the form **Z = a + bi**, where **a** denotes the real part, **b** denotes the imaginary part, and **i** is the imaginary unit, defined as the square root of -1 (**sqrt(-1)**). The ALU design in this project enables efficient arithmetic operations on complex numbers, including addition, subtraction, and multiplication, by treating the real and imaginary components separately within the hardware. This approach allows for the precise handling of both components simultaneously, ensuring accurate results for complex arithmetic tasks. The design is well-suited for applications requiring complex number manipulation, such as digital signal processing (DSP), communication systems, and scientific computing, where operations on complex numbers are essential. The implementation is optimized for FPGA and ASIC synthesis, providing a flexible and scalable solution for high-performance computational environments. By leveraging this hardware ALU, complex arithmetic operations can be executed faster and more efficiently than with traditional software-based methods.
### Instruction Format
Instruction format is described in the following figure. Where `Z1` and `Z2` are two 32 bit complex numbers. Most significant 2 bytes represents the real part and 2 least significant bytes are imaginary part of the complex number. This is done because most of the ISAs are 32 bit so the CALU becomes compatable with them. Opcode multiplexs between instruction e.g. if user wants to add two complex number the opcode will be `0000` and for subtraction `0001`  
![Alt text](output_files/instruction_format.jpeg)

### CALU Inputs & Outputs
A Complex Arithmetic Logic Unit (CALU) processes two 32-bit numbers, which are divided into their real and imaginary components for complex arithmetic operations. Based on the results of the ALU, flags are set accordingly. R_Flags and I_Flags are the flags corresponding to the real and imaginary part of the CALU output.
![Alt text](output_files/CALU.jpeg)

### Instructions

## CALU Instructions Table

| Sr. No. | Opcode | Instruction | Description                                               |
|---------|--------|-------------|-----------------------------------------------------------|
| 1       | 0000   | CADD        | Complex addition: Adds the real and imaginary parts of Z1 and Z2. |
| 2       | 0001   | CSUB        | Complex subtraction: Subtracts the real and imaginary parts of Z2 from Z1. |
| 3       | 0010   | CMUL        | Complex multiplication: Multiplies Z1 and Z2 in complex space. |
| 4       | 0011   | CDIV        | Complex division: Divides Z1 by Z2 in complex space.       |
| 5       | 0100   | CMAG        | Complex magnitude: Computes the magnitude (modulus) of Z1. |
| 6       | 0101   | CAND        | Complex bitwise AND: Performs bitwise AND on real and imaginary parts. |
| 7       | 0110   | COR         | Complex bitwise OR: Performs bitwise OR on real and imaginary parts. |
| 8       | 0111   | CNOT        | Complex bitwise NOT: Performs bitwise NOT on the real and imaginary parts of Z1. |
| 9       | 1000   | CXOR        | Complex bitwise XOR: Performs bitwise XOR on real and imaginary parts. |
| 10      | 1001   | CXNOR       | Complex bitwise XNOR: Performs bitwise XNOR on real and imaginary parts. |
| 11      | 1010   | CNAND       | Complex bitwise NAND: Performs bitwise NAND on real and imaginary parts. |
| 12      | 1011   | CNOR        | Complex bitwise NOR: Performs bitwise NOR on real and imaginary parts. |
| 13      | 1100   | CINC        | Complex increment: Increments the real and imaginary parts of Z1 by 1. |
| 14      | 1101   | CDEC        | Complex decrement: Decrements the real and imaginary parts of Z1 by 1. |
| 15      | 1110   | Cswap       | Complex swap: Swaps the real and imaginary parts of Z1. |
| 16      | 1111   | Conjugate   | Complex conjugate: Takes the conjugate of Z1 (negates the imaginary part). |






### Flags

| **R Flags** | **I Flags** | **Description**               |
|-------------|-------------|-------------------------------|
| CR          | CI          | Carry                          |
| DVFR        | DVFI        | Division overflow error        |
| ZER         | ZEI         | Zero error                     |
| ZR          | ZI          | Zero output                    |
| OR          | OI          | Overflow                       |
| NR          | NI          | Negative                       |




### Results
![Alt text](output_files/CALU_results.png)

