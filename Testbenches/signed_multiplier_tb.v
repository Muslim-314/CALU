module signed_multiplier_tb;
  // Inputs
  reg signed [15:0] A;
  reg signed [15:0] B;

  // Outputs
  wire signed [15:0] Product;

  // Instantiate the Unit Under Test (UUT)
  singed_multiplier uut (
    .A(A), 
    .B(B), 
    .Product(Product)
  );
  initial begin
			 A = 4'hF; B = 12;
		#10 A = 4'he; B = 13;
		#10 A = 4'hd; B = 10;
		#10 A = -7;   B = -6;
		#10 A = 7;    B = 6;
		#10 A = 7;    B = -6;
		#10 A = -7;   B = 6;
			 // End the test
    $finish;
  end

endmodule
