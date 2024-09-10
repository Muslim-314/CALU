module singed_multiplier(A,B,Product);
	input  signed [15:0] A;
	input  signed [15:0] B;
	output signed [15:0] Product;
	assign Product = A*B;
endmodule 