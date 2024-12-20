module adder_subtractor_16bit (
    input [15:0] A,         // First 16-bit input
    input [15:0] B,         // Second 16-bit input
    input Sub,              // Subtract signal: 0 for addition, 1 for subtraction
    input Cin,              // Carry-in (optional, typically 0)
    output [15:0] Result,   // Result of addition or subtraction
    output Cout,            // Carry-out
    output Overflow         // Overflow flag
);
    wire [15:0] B_xor;      // XOR-ed version of B for subtraction
    wire [16:0] FullResult; // Full result including carry-out

    // If Sub is 1, we perform subtraction by using two's complement (B XOR 1 and adding 1)
    assign B_xor = B ^ {16{Sub}};

    // Perform addition or subtraction: A + (B xor Sub) + Cin
    assign FullResult = {1'b0, A} + {1'b0, B_xor} + Sub + Cin;

    // Assign the result and carry-out
    assign Result = FullResult[15:0];   // Only the lower 16 bits are taken as the result
    assign Cout = FullResult[16];       // The 17th bit is the carry-out

    // Overflow detection: Overflow occurs when both operands have the same sign, but the result has the opposite sign.
    // For subtraction, we detect overflow by treating it as addition of A and (-B).
    assign Overflow = (A[15] == B_xor[15]) && (Result[15] != A[15]);

endmodule
