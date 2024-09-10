// Date: 7-Sep-2024
// Original code:  https://vlsigyan.com/16-bit-carry-look-ahead-adder-verilog/
// modified by: Syed Muhammad Muslim
module carry_look_ahead_16bit(a,b, cin, sum,cout);
	input [15:0] a,b;
	input cin; //mode select between add subtract
	output [15:0] sum;
	output cout;
	
	wire [15:0] b_xor;
	
	generate 
		genvar i;
		for (i=0; i<16; i = i+1) begin: SUB_MUX
			assign b_xor[i] = b[i] ^ cin;
		end
	endgenerate
	wire c1,c2,c3;
	carry_look_ahead_4bit cla1 (.a(a[3:0]),   .b(b_xor[3:0]),  .cin(cin), .sum(sum[3:0]),  .cout(c1));
	carry_look_ahead_4bit cla2 (.a(a[7:4]),   .b(b_xor[7:4]),  .cin(c1),  .sum(sum[7:4]),  .cout(c2));
	carry_look_ahead_4bit cla3 (.a(a[11:8]),  .b(b_xor[11:8]), .cin(c2),  .sum(sum[11:8]), .cout(c3));
	carry_look_ahead_4bit cla4 (.a(a[15:12]), .b(b_xor[15:12]),.cin(c3),  .sum(sum[15:12]), .cout(cout));
endmodule
