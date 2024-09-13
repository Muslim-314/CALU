module negate_sign(
    input  wire [15:0] in_num,  // 16-bit input number
    output wire [15:0] out_num  // 16-bit output number with negated sign
);

    assign out_num = ~in_num + 1'b1;  // 2's complement to negate the sign

endmodule
