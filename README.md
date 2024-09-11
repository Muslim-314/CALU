# Complex Arithmetic Logic Unit
![Alt text](output_files/instruction_format.jpeg)

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

