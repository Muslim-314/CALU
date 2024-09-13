module tb_CALU;

  // Testbench signals
  reg [31:0] Z1;
  reg [31:0] Z2;
  reg [3:0] Opcode;
  wire [31:0] Zout;
  wire CR, CI, DVFR, DVFI, ZER, ZEI, ZR, ZI, OR, OI, NR, NI;
  
  // Additional wires for real and imaginary parts
  wire [15:0] RealPart;
  wire [15:0] ImagPart;
  
  // Instantiate the CALU module
  CALU uut (
    .Z1(Z1),
    .Z2(Z2),
    .Opcode(Opcode),
    .Zout(Zout),
    .CR(CR),
    .CI(CI),
    .DVFR(DVFR),
    .DVFI(DVFI),
    .ZER(ZER),
    .ZEI(ZEI),
    .ZR(ZR),
    .ZI(ZI),
    .OR(OR),
    .OI(OI),
    .NR(NR),
    .NI(NI)
  );
  
  // Assign Real and Imaginary parts
  assign RealPart = Zout[31:16];
  assign ImagPart = Zout[15:0];
  
  // Test procedure
  initial begin
    // Monitor signals
    $monitor("Time: %0t | Opcode: %b | Z1: %h | Z2: %h | Zout: %h | RealPart: %h | ImagPart: %h | CR: %b | CI: %b | DVFR: %b | DVFI: %b | ZER: %b | ZEI: %b | ZR: %b | ZI: %b | OR: %b | OI: %b | NR: %b | NI: %b", 
             $time, Opcode, Z1, Z2, Zout, RealPart, ImagPart, CR, CI, DVFR, DVFI, ZER, ZEI, ZR, ZI, OR, OI, NR, NI);
             
    // Initialize inputs
    Z1 = 32'b0;
    Z2 = 32'b0;
    Opcode = 4'b0000;
    
    // Test CADD
    Z1 = 32'h0001_0001; // (1 + 1i)
    Z2 = 32'h0002_0002; // (2 + 2i)
    Opcode = 4'b0000; // CADD
    #10;
    
    // Test CSUB
    Opcode = 4'b0001; // CSUB
    #10;
    
    // Test CMUL
    Opcode = 4'b0010; // CMUL
    #10;
    
    // Test CDIV
    Opcode = 4'b0011; // CDIV
    #10;
    
    // Test CMAG
    Opcode = 4'b0100; // CMAG
    #10;
    
    // Test CAND
    Opcode = 4'b0101; // CAND
    #10;
    
    // Test COR
    Opcode = 4'b0110; // COR
    #10;
    
    // Test CNOT
    Opcode = 4'b0111; // CNOT
    #10;
    
    // Test CXOR
    Opcode = 4'b1000; // CXOR
    #10;
    
    // Test CXNOR
    Opcode = 4'b1001; // CXNOR
    #10;
    
    // Test CNAND
    Opcode = 4'b1010; // CNAND
    #10;
    
    // Test CNOR
    Opcode = 4'b1011; // CNOR
    #10;
    
    // Test CINC
    Opcode = 4'b1100; // CINC
    #10;
    
    // Test CDEC
    Opcode = 4'b1101; // CDEC
    #10;
    
    // Test Cswap
    Opcode = 4'b1110; // Cswap
    #10;
    
    // Test Conjugate
    Opcode = 4'b1111; // Conjugate
    #10;
    
    // Finish simulation
    $finish;
  end

endmodule
