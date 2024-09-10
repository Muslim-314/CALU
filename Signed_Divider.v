module Signed_Divider (
    input [15:0] Q,          // Dividend
    input [15:0] M,          // Divisor
    output reg [15:0] Quo,   // Quotient
    output reg [15:0] Rem,   // Remainder
	 output reg        DVF,   // Division Overflow
	 output reg			 ZE     // Zero error
);

    // Internal variables
    reg [15:0] A;
    reg [15:0] B;
    reg [15:0] P;
	 reg [15:0] Mc; //divisior's complement 
    integer i;

    always @(Q or M) begin
        // Initialize variables
        A = Q;
        B = M;
        P = 16'b0;   // Initialize P to 0
        // Check if Q (dividend) is negative
        if (A[15] == 1'b1)
            A = 0 - A;   // Make Q positive
        // Check if M (divisor) is negative
        if (B[15] == 1'b1)
            B = 0 - B;   // Make M positive
        // Booth's algorithm main loop
        for (i = 0; i < 16; i = i + 1) begin
            P = {P[14:0], A[15]};   // Shift left A into P
            A = {A[14:0], 1'b0};   // Shift left A
            P = P - B;   // Subtract B from P
            
            // Check if P < 0 (MSB of P is 1)
            if (P[15] == 1'b1) begin
                A[0] = 1'b0;   // Set A[0] to 0
                P = P + B;     // Add B back to P
            end else begin
                A[0] = 1'b1;   // Set A[0] to 1
            end
        end
        // Determine Quotient and Remainder
        if (Q[15] == 1'b1 && M[15] == 1'b0) begin
            Quo = 0 - A;
            Rem = 0 - P;
        end else if (Q[15] == 1'b0 && M[15] == 1'b1) begin
            Quo = 0 - A;
            Rem = P;
        end else if (Q[15] == 1'b1 && M[15] == 1'b1) begin
            Quo = A;
            Rem = 0 - P;
        end else begin
            Quo = A;
            Rem = P;
        end
    end
	 
	 //flag logic
	 always@(*)begin 
		//handling the DVF Flag
		if(M[15]) Mc = ~M + 1'b1; else Mc = M;
		if(Mc > Q)  DVF = 1'b1; else DVF = 1'b0;  // Divisor greater then Dividend: Divion overflow error
		if(M == 0) ZE  = 1'b1; else ZE  = 1'b0;  // Divisor is zero: zero divison error
	 end
endmodule
