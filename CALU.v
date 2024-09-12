/*
Opcode Instr Description 
0000   CADD   Z1 + Z2
0001   CSUB   Z1 - Z2
0010   CMUL   Z1 * Z2
0011   CDIV   Z1 / Z2 
*/

module CALU(
	input  [31:0]Z1,
	input  [31:0]Z2,
	input  [3:0]Opcode,
	output [31:0]Zout,
	//flags 
	output CR,   CI,     // Carry 
	output DVFR, DVFI,   // Division overflow error
	output ZER,  ZEI,    // Zero error
	output ZR,   ZI,     // Zero output
	output OR,   OI,     // Overflow
	output NR,   NI      // Negative
	
 );

	wire [15:0]realPart1;
	wire [15:0]imgPart1;
	wire [15:0]realPart2;
	wire [15:0]imgPart2;

	assign realPart1 = Z1[31:16];
	assign imgPart1  = Z1[15:0];
	assign realPart2 = Z2[31:16];
	assign imgPart2  = Z2[15:0];
	
	// complex addition and subtraction
	wire [15:0]realCLAdOut;
	wire [15:0]imgCLAOut;
	
	carry_look_ahead_16bit realAdd(.a(realPart1),.b(realPart2), .cin(Opcode[0]), .sum(realCLAdOut), .cout(CR));
	carry_look_ahead_16bit  imgAdd(.a(imgPart1 ),.b(imgPart2 ), .cin(Opcode[0]), .sum( imgCLAdOut), .cout(CI));
	
	//complex multiplication (a+bi)(c+di) = (ac - bd) + (ad + bc)i
	wire [15:0]mulOut1,mulOut2,mulOut3,mulOut4;
	wire [15:0]realMulOut;
	wire [15:0]imgMulOut;
	singed_multiplier ac(.A(realPart1),.B(realPart2),.Product(mulOut1)); //ac
	singed_multiplier bd(.A(imgPart1) ,.B(imgPart2), .Product(mulOut2)); //bd
	singed_multiplier ad(.A(realPart1),.B(imgPart2), .Product(mulOut3)); //ad
	singed_multiplier bc(.A(imgPart1), .B(realPart2),.Product(mulOut4)); //bc
	carry_look_ahead_16bit realPrtmul(.a(mulOut1),.b(mulOut2), .cin(1'b1), .sum(realMulOut), .cout(CR)); // (ac - bd)
	carry_look_ahead_16bit imgPrtmul(.a(mulOut3),.b(mulOut4), .cin(1'b0),  .sum(imgMulOut),  .cout(CR)); // (ad + bc)i
	
	
	//complex division (a+bi)(c+di) = (ac + bd)/(c^2 + d^2) + (bc - ad)i/(c^2 + d^2)
	wire [15:0]numReal,   numImg;    // numerator
	wire [15:0]denum; // denumerator
	wire [15:0]cSquare,dSquare;
	wire [15:0]divRealOut, divImgOut; // Quotent after division
	wire [15:0]remReal, remImg;       //remainder after division
	// using the products from the multiplier block
	carry_look_ahead_16bit realPrtdv(.a(mulOut1),  .b(mulOut2), .cin(1'b0), .sum(numReal), .cout(CR));  // ac + bd
	carry_look_ahead_16bit imgPrtmul(.a(mulOut4),  .b(mulOut3), .cin(1'b1),  .sum(numImg), .cout(CR)); // (bc - ad)i
	singed_multiplier      csquare  (.A(realPart2),.B(realPart2),.Product(denum)); //c^2
	singed_multiplier      dsquare  (.A(imgPart2), .B(imgPart2),.Product(denum));   //d^2
	Signed_Divider         divReal  (.Q(numReal),  .M(denum), .Quo(divRealOut), .Rem(remReal), .DVF(DVFR), .ZE(ZER));
	Signed_Divider         divImg   (.Q(numImg),   .M(denum), .Quo(divRImgOut), .Rem(remImg),  .DVF(DVFI), .ZE(ZEI));
	
	
	//Magnitude |Z| 
	wire [15:0]magOut;
	magnitude Zmag( .Real(realPart1), .Imaginary(imgPart1), .Mag(magOut));
	
	
	//increment Z(R++ and I++)
	wire [15:0]IncReal, IncImg;
	assign IncReal = realPart1 + 16'h0001;
	assign IncImg  =  imgPart1 + 16'h0001;
	
	//decrement Z(R-- and I--)
	wire [15:0]IncReal, IncImg;
	assign IncReal = realPart1 - 16'h0001;
	assign IncImg  =  imgPart1 - 16'h0001;
	
	
	//Swap real with complex
	wire swapReal, swapImg;
	assign swapReal = imgPart1;
	assign swapImg  = realPart1;
	
	
	
	/*--------------Logical Opeartions----------------*/
	//and operation
	wire [15:0]AndOutReal, AndOutImg ;
	assign AndOutReal = realPart1 && realPart2; 
	assign AndOutImg  =  imgPart1 && imgPart2;
	
	//or operation
	wire [15:0]OROutReal, OROutImg ;
	assign OROutReal = realPart1 || realPart2; 
	assign OROutImg  =  imgPart1 || imgPart2;
	
	//xor operation
	wire [15:0]XOROutReal, XOROutImg ;
	assign XOROutReal = realPart1 ^ realPart2; 
	assign XOROutImg  =  imgPart1 ^ imgPart2;
	
	//xnor operation
	wire [15:0]XNOROutReal, XNOROutImg ;
	assign XNOROutReal =  ~XOROutReal; 
	assign XNOROutImg  =  ~XOROutImg;
	
	//nand operation
	wire [15:0]NAndOutReal, NAndOutImg ;
	assign NAndOutReal = ~AndOutReal; 
	assign NAndOutImg  =  ~AndOutImg;
	
	//nor operation
	wire [15:0]NOROutReal, NOROutImg ;
	assign NOROutReal = ~OROutReal; 
	assign NOROutImg  = ~OROutImg;
	
	/*------------------------------------*/
	
	
	
	
endmodule 








