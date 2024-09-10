module magnitude(
	input [15:0]Real,
	input [15:0]Imaginary,
	output [15:0]Mag
);

	wire [15:0]square1,square2;
	wire [15:0]AddOut;
	
	singed_multiplier      mul1  (.A(Real),     .B(Real),     .Product(square1));           //square real
	singed_multiplier      mul2  (.A(Imaginary),.B(Imaginary),.Product(square2));           //square imaginary
	carry_look_ahead_16bit add16 (.a(square1),  .b(square2), .cin(1'b0), .sum(AddOut));  // adding the square of real and imaginary
	sqrt                     sq1 (.num(AddOut), .sqrt(Mag));
endmodule 