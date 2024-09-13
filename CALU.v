
/* 	Author: M314   */


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
	output reg [31:0]Zout,
	//flags 
	output reg CR,   CI,     // Carry     							done
	output reg DVFR, DVFI,   // Division overflow error       done
	output reg ZER,  ZEI,    // Zero error                    done
	output reg ZR,   ZI,     // Zero output                    -
	output reg OR,   OI,     // Overflow                      done
	output reg NR,   NI      // Negative                       -
	
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
	wire [15:0]realCLAOut;
	wire [15:0]imgCLAOut;
	wire CR_,CI_,OR_,OI_;
	adder_subtractor_16bit ADD_SUB0(.A(realPart1), .B(realPart2), .Sub(Opcode[0]), .Cin(1'b0), .Result(realCLAOut), .Cout(CR_) ,.Overflow(OR_)); //real part
	adder_subtractor_16bit ADD_SUB1(.A(imgPart1), .B(imgPart2), .Sub(Opcode[0]), .Cin(1'b0), .Result(imgCLAOut), .Cout(CI_) ,.Overflow(OI_)); // imaginary part
	

	//complex multiplication (a+bi)(c+di) = (ac - bd) + (ad + bc)i
	wire [15:0]mulOut1,mulOut2,mulOut3,mulOut4;
	wire [15:0]realMulOut;
	wire [15:0]imgMulOut;
	singed_multiplier ac(.A(realPart1),.B(realPart2),.Product(mulOut1)); //ac
	singed_multiplier bd(.A(imgPart1) ,.B(imgPart2), .Product(mulOut2)); //bd
	singed_multiplier ad(.A(realPart1),.B(imgPart2), .Product(mulOut3)); //ad
	singed_multiplier bc(.A(imgPart1), .B(realPart2),.Product(mulOut4)); //bc
	carry_look_ahead_16bit realPrtmul(.a(mulOut1),.b(mulOut2), .cin(1'b1), .sum(realMulOut)); // (ac - bd)
	carry_look_ahead_16bit imgPrtmul(.a(mulOut3),.b(mulOut4),  .cin(1'b0),  .sum(imgMulOut)); // (ad + bc)i
	
	
	//complex division (a+bi)(c+di) = (ac + bd)/(c^2 + d^2) + (bc - ad)i/(c^2 + d^2)
	wire [15:0]numReal,   numImg;    // numerator
	wire [15:0]denum; // denumerator
	wire [15:0]cSquare,dSquare;
	wire [15:0]divRealOut, divImgOut; // Quotent after division
	wire [15:0]remReal, remImg;       //remainder after division
	wire DVFR_,DVFI_,ZER_,ZEI_;
	// using the products from the multiplier block
	carry_look_ahead_16bit realPrtdv(.a(mulOut1),  .b(mulOut2), .cin(1'b0), .sum(numReal));  // ac + bd
	carry_look_ahead_16bit imgPrtmul0(.a(mulOut4),  .b(mulOut3), .cin(1'b1),  .sum(numImg)); // (bc - ad)i
	singed_multiplier      csquare  (.A(realPart2),.B(realPart2),.Product(cSquare));         //c^2
	singed_multiplier      dsquare  (.A(imgPart2), .B(imgPart2),.Product(dSquare));          //d^2
	carry_look_ahead_16bit realPrtdv1(.a(cSquare),  .b(dSquare), .cin(1'b0), .sum(denum));    //c^2 + d^2
	Signed_Divider         divReal  (.Q(numReal),  .M(denum), .Quo(divRealOut), .Rem(remReal), .DVF(DVFR_), .ZE(ZER_));
	Signed_Divider         divImg   (.Q(numImg),   .M(denum), .Quo(divImgOut), .Rem(remImg),  .DVF(DVFI_), .ZE(ZEI_));
	
	
	//Magnitude |Z| 
	wire [15:0]magOut;
	magnitude Zmag( .Real(realPart1), .Imaginary(imgPart1), .Mag(magOut));
	
	
	//increment Z(R++ and I++)
	wire [15:0]IncReal, IncImg;
	assign IncReal = realPart1 + 16'h0001;
	assign IncImg  =  imgPart1 + 16'h0001;
	
	//decrement Z(R-- and I--)
	wire [15:0]DecReal, DecImg;
	assign DecReal = realPart1 - 16'h0001;
	assign DecImg  =  imgPart1 - 16'h0001;
	
	
	//Swap real with complex
	wire [15:0]swapReal, swapImg;
	assign swapReal = imgPart1;
	assign swapImg  = realPart1;
	
	//conjugate
	
	wire [15:0]conjReal, conjImg;
	assign conjReal = realPart1;
	negate_sign ns(.in_num(imgPart1), .out_num(conjImg));
	
	
	/*--------------Logical Opeartions----------------*/
	//and operation
	wire [15:0]AndOutReal, AndOutImg ;
	assign AndOutReal = realPart1 & realPart2; 
	assign AndOutImg  =  imgPart1 & imgPart2;
	
	//or operation
	wire [15:0]OROutReal, OROutImg ;
	assign OROutReal = realPart1 | realPart2; 
	assign OROutImg  =  imgPart1 | imgPart2;
	
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
	
	//NOT operation
	wire[15:0] NotReal; 
	wire[15:0] NotImg; 
	assign NotReal = ~realPart1;
	assign NotImg = ~imgPart1;
	
	/*------------------------------------*/

	// multiplixing the output based on the Opode
	always@(*)begin
		if(Opcode == 4'b0000)begin //CADD
			Zout = {realCLAOut, imgCLAOut};
				CR   = CR_;   
				CI   = CI_;     
				DVFR = 0;     
				DVFI = 0;   
				ZER  = 0;     
				ZEI  = 0;  
				ZR   = (realCLAOut == 0)? 1: 0;   
				ZI   = (imgCLAOut == 0)? 1 : 0; 
				OR   = OR_;    
				OI   = OI_; 
				NR   = (realCLAOut[15] == 1'b1) ? 1'b1: 1'b0;
				NI   = ( imgCLAOut[15] == 1'b1) ? 1'b1: 1'b0;                           
		end
		else if(Opcode == 4'b0001)begin //CSUB
				Zout = {realCLAOut, imgCLAOut};
				CR   = CR_;   
				CI   = CI_;     
				DVFR = 0;     
				DVFI = 0;   
				ZER  = 0;     
				ZEI  = 0;  
				ZR   = (realCLAOut == 0)? 1: 0;   
				ZI   = (imgCLAOut == 0)? 1 : 0; 
				OR   = OR_;    
				OI   = OI_;  
				NR   = (realCLAOut[15] == 1'b1) ? 1'b1: 1'b0;
				NI   = ( imgCLAOut[15] == 1'b1) ? 1'b1: 1'b0; 
		end
		
		else if(Opcode == 4'b0010)begin //CMUL
				Zout = {realMulOut, imgMulOut};
				CR   = 0;   
				CI   = 0;     
				DVFR = 0;     
				DVFI = 0;   
				ZER  = 0;     
				ZEI  = 0;  
				ZR   = (realMulOut == 0)? 1: 0;   
				ZI   = (imgMulOut == 0)? 1 : 0; 
				OR   = 0;    
				OI   = 0;
				NR   = (realMulOut[15] == 1'b1) ? 1'b1: 1'b0;
				NI   = ( imgMulOut[15] == 1'b1) ? 1'b1: 1'b0; 
		end
		else if(Opcode == 4'b0011)begin //CDIV
				Zout = {divRealOut, divImgOut};
				CR   = 0;   
				CI   = 0;     
				DVFR = DVFR_;     
				DVFI = DVFI_;   
				ZER  = ZER_;     
				ZEI  = ZEI_;  
				ZR   = (divRealOut == 0)? 1: 0;   
				ZI   = (divImgOut == 0)? 1 : 0; 
				OR   = 0;    
				OI   = 0;
				NR   = (divRealOut[15] == 1'b1) ? 1'b1: 1'b0;
				NI   = ( divImgOut[15] == 1'b1) ? 1'b1: 1'b0; 
		end

		else if(Opcode == 4'b0100)begin //CMAG
				Zout = {16'b0, magOut};
				CR   = 0;   
				CI   = 0;     
				DVFR = 0;     
				DVFI = 0;   
				ZER  = 0;     
				ZEI  = 0;  
				ZR   = (divRealOut == 0)? 1: 0;   
				ZI   = (divImgOut == 0)? 1 : 0; 
				OR   = 0;    
				OI   = 0;
				NR   = 0;
				NI   = 0; 
		end
		else if(Opcode == 4'b0101)begin //CAND
				Zout = {AndOutReal, AndOutImg};
				CR   = 0;   
				CI   = 0;     
				DVFR = 0;     
				DVFI = 0;   
				ZER  = 0;     
				ZEI  = 0;  
				ZR   = (AndOutReal == 0)? 1: 0;   
				ZI   = (AndOutImg == 0)? 1 : 0; 
				OR   = 0;    
				OI   = 0;
				NR   = (AndOutReal[15] == 1'b1) ? 1'b1: 1'b0;
				NI   = ( AndOutImg[15] == 1'b1) ? 1'b1: 1'b0;  
		end
		else if(Opcode == 4'b0110)begin //COR
				Zout = {OROutReal, OROutImg};
				CR   = 0;   
				CI   = 0;     
				DVFR = 0;     
				DVFI = 0;   
				ZER  = 0;     
				ZEI  = 0;  
				ZR   = (OROutReal == 0)? 1: 0;   
				ZI   = (OROutImg == 0)? 1 : 0; 
				OR   = 0;    
				OI   = 0;
				NR   = (OROutReal[15] == 1'b1) ? 1'b1: 1'b0;
				NI   = ( OROutImg[15] == 1'b1) ? 1'b1: 1'b0;  
		end
		
		else if(Opcode == 4'b0111)begin //CNOT
				Zout = {NotReal, NotImg};
				CR   = 0;   
				CI   = 0;     
				DVFR = 0;     
				DVFI = 0;   
				ZER  = 0;     
				ZEI  = 0;  
				ZR   = (NotReal == 0)? 1: 0;   
				ZI   = (NotImg == 0)? 1 : 0; 
				OR   = 0;    
				OI   = 0;
				NR   = (NotReal[15] == 1'b1) ? 1'b1: 1'b0;
				NI   = ( NotImg[15] == 1'b1) ? 1'b1: 1'b0;  
		end
		
		else if(Opcode == 4'b0111)begin //CNOT
				Zout = {NotReal, NotImg};
				CR   = 0;   
				CI   = 0;     
				DVFR = 0;     
				DVFI = 0;   
				ZER  = 0;     
				ZEI  = 0;  
				ZR   = (NotReal == 0)? 1: 0;   
				ZI   = (NotImg == 0)? 1 : 0; 
				OR   = 0;    
				OI   = 0;
				NR   = (NotReal[15] == 1'b1) ? 1'b1: 1'b0;
				NI   = ( NotImg[15] == 1'b1) ? 1'b1: 1'b0;  
		end
		else if(Opcode == 4'b1000)begin //CXOR
				Zout = {XOROutReal, XOROutImg};
				CR   = 0;   
				CI   = 0;     
				DVFR = 0;     
				DVFI = 0;   
				ZER  = 0;     
				ZEI  = 0;  
				ZR   = (XOROutReal == 0)? 1: 0;   
				ZI   = (XOROutImg == 0)? 1 : 0; 
				OR   = 0;    
				OI   = 0;
				NR   = (XOROutReal[15] == 1'b1) ? 1'b1: 1'b0;
				NI   = ( XOROutImg[15] == 1'b1) ? 1'b1: 1'b0;  
		end		
		else if(Opcode == 4'b1001)begin //CXNOR
				Zout = {XNOROutReal, XNOROutImg};
				CR   = 0;   
				CI   = 0;     
				DVFR = 0;     
				DVFI = 0;   
				ZER  = 0;     
				ZEI  = 0;  
				ZR   = (XNOROutReal == 0)? 1: 0;   
				ZI   = (XNOROutImg == 0)? 1 : 0; 
				OR   = 0;    
				OI   = 0;
				NR   = (XNOROutReal[15] == 1'b1) ? 1'b1: 1'b0;
				NI   = ( XNOROutImg[15] == 1'b1) ? 1'b1: 1'b0;  
		end

		else if(Opcode == 4'b1010)begin //CNAND
				Zout = {NAndOutReal, NAndOutImg};
				CR   = 0;   
				CI   = 0;     
				DVFR = 0;     
				DVFI = 0;   
				ZER  = 0;     
				ZEI  = 0;  
				ZR   = (NAndOutReal == 0)? 1: 0;   
				ZI   = (NAndOutImg == 0)? 1 : 0; 
				OR   = 0;    
				OI   = 0;
				NR   = (NAndOutReal[15] == 1'b1) ? 1'b1: 1'b0;
				NI   = ( NAndOutImg[15] == 1'b1) ? 1'b1: 1'b0;  
		end		
	
		else if(Opcode == 4'b1011)begin //CNOR
				Zout = {NOROutReal, NOROutImg};
				CR   = 0;   
				CI   = 0;     
				DVFR = 0;     
				DVFI = 0;   
				ZER  = 0;     
				ZEI  = 0;  
				ZR   = (NOROutReal == 0)? 1: 0;   
				ZI   = (NOROutImg == 0)? 1 : 0; 
				OR   = 0;    
				OI   = 0;
				NR   = (NOROutReal[15] == 1'b1) ? 1'b1: 1'b0;
				NI   = ( NOROutImg[15] == 1'b1) ? 1'b1: 1'b0;  
		end	
		
		
		
		else if(Opcode == 4'b1100)begin //CINC
				Zout = {IncReal, IncImg};
				CR   = 0;   
				CI   = 0;     
				DVFR = 0;     
				DVFI = 0;   
				ZER  = 0;     
				ZEI  = 0;  
				ZR   = (IncReal == 0)? 1: 0;   
				ZI   = (IncImg == 0)? 1 : 0; 
				OR   = 0;    
				OI   = 0;
				NR   = (IncReal[15] == 1'b1) ? 1'b1: 1'b0;
				NI   = ( IncImg[15] == 1'b1) ? 1'b1: 1'b0;  
		end	

		else if(Opcode == 4'b1101)begin //CDEC
				Zout = {DecReal, DecImg};
				CR   = 0;   
				CI   = 0;     
				DVFR = 0;     
				DVFI = 0;   
				ZER  = 0;     
				ZEI  = 0;  
				ZR   = (DecReal == 0)? 1: 0;   
				ZI   = (DecImg == 0)? 1 : 0; 
				OR   = 0;    
				OI   = 0;
				NR   = (DecReal[15] == 1'b1) ? 1'b1: 1'b0;
				NI   = ( DecImg[15] == 1'b1) ? 1'b1: 1'b0;  
		end

		else if(Opcode == 4'b1110)begin //Cswap
				Zout = {swapReal, swapImg};
				CR   = 0;   
				CI   = 0;     
				DVFR = 0;     
				DVFI = 0;   
				ZER  = 0;     
				ZEI  = 0;  
				ZR   = (swapReal == 0)? 1: 0;   
				ZI   = (swapImg == 0)? 1 : 0; 
				OR   = 0;    
				OI   = 0;
				NR   = (swapReal[15] == 1'b1) ? 1'b1: 1'b0;
				NI   = (swapImg[15] == 1'b1) ? 1'b1: 1'b0;  
		end


		else if(Opcode == 4'b1111)begin //Conjugate
				Zout = {conjReal, conjImg};
				CR   = 0;   
				CI   = 0;     
				DVFR = 0;     
				DVFI = 0;   
				ZER  = 0;     
				ZEI  = 0;  
				ZR   = (conjReal == 0)? 1: 0;   
				ZI   = (conjImg == 0)? 1 : 0; 
				OR   = 0;    
				OI   = 0;
				NR   = (conjReal[15] == 1'b1) ? 1'b1: 1'b0;
				NI   = (conjImg[15] == 1'b1) ? 1'b1: 1'b0;  
		end

		
	end
	
	
endmodule 








