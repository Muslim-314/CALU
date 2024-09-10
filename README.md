# Complex Arithmetic Logic Unit
ALU for Complex Arhitmetic|
---------------------------------
ISA:
1-       Add        DONE
2-       Multiply   DONE
3-       Subtract   DONE
4-       Divison    DONE
5-       Magnitude  DONE
6-       AND (real part with real & imaginary with imaginary)
7-       OR
7-       NOT
8-       XOR
9-       XNOR
10-      NAND
11-      NOR
12-      Increment complex number (R++ and I++)
13-      Decrement complex number(R-- & I--)
14-      Find the angle of the complex number
15-      Swap the real and imaginary parts of complex numbers
16-      Check if A magnitude is greater than B magnitude

Instruction format:
           Real Part       Imaginary part   Opcode
Z1  =   xxxxxxxxxxxxxxxx  xxxxxxxxxxxxxxxx   xxxx
Z2  =   xxxxxxxxxxxxxxxx  xxxxxxxxxxxxxxxx
FLAGS:
      -  ZR : Zero real part
      -  ZI : Zero imaginary part
      -  OR : Overflow in real part
      -  OI : Overflow in imaginary part
      -  NR : Negative Real Part
      -  NI : Negative imaginary part
        ZE : zero diviion error

