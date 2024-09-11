# Complex Arithmetic Logic Unit
This repository contains the hardware design for an Arithmetic Logic Unit (ALU) specifically tailored to perform operations on complex numbers. Complex numbers are represented in the form **Z = a + bi**, where **a** denotes the real part, **b** denotes the imaginary part, and **i** is the imaginary unit, defined as the square root of -1 (**sqrt(-1)**). The ALU design in this project enables efficient arithmetic operations on complex numbers, including addition, subtraction, and multiplication, by treating the real and imaginary components separately within the hardware. This approach allows for the precise handling of both components simultaneously, ensuring accurate results for complex arithmetic tasks. The design is well-suited for applications requiring complex number manipulation, such as digital signal processing (DSP), communication systems, and scientific computing, where operations on complex numbers are essential. The implementation is optimized for FPGA and ASIC synthesis, providing a flexible and scalable solution for high-performance computational environments. By leveraging this hardware ALU, complex arithmetic operations can be executed faster and more efficiently than with traditional software-based methods.
### Instruction Format 
![Alt text](output_files/instruction_format.jpeg)

### CALU Inputs & Outputs
![Alt text](output_files/CALU.jpeg)


```bash
--------------------------
ALU for Complex Arhitmetic |
--------------------------
ISA: 
1	Add        
2	Multiply   
3	Subtract   
4	Divison    
5	Magnitude  
6	AND (real part with real & imaginary with imaginary)
7	OR
7	NOT
8	XOR
9	XNOR
10	NAND
11	NOR
12	Increment complex number (R++ and I++)
13      Decrement complex number(R-- & I--)
14	Find the angle of the complex number
15	Swap the real and imaginary parts of complex numbers 
16	Check if A magnitude is greater than B magnitude

Instruction format:
		    Opearand-1                                Opearand-1
	    Real Part       Imaginary part            Real Part       Imaginary part        Opcode
	   xxxxxxxxxxxxxxxx  xxxxxxxxxxxxxxxx        xxxxxxxxxxxxxxxx  xxxxxxxxxxxxxxxx       xxxx
  
FLAGS:
	ZR : Zero real part 
	ZI : Zero imaginary part
	OR : Overflow in real part 
	OI : Overflow in imaginary part
	NR : Negative Real Part
	NI : Negative imaginary part 
	ZE : zero diviion error 
       DVF : Division overflow error
	CR : carry from the real part
	CI : Carry form the imaginary part

```

