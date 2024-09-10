module Signed_Divider_tb;

    // Inputs
    reg [15:0] Q;  // Dividend
    reg [15:0] M;  // Divisor

    // Outputs
    wire [15:0] Quo;  // Quotient
    wire [15:0] Rem;  // Remainder
	 wire        DVF;
	 wire        ZE;
    // Instantiate the DUT (Device Under Test)
    Signed_Divider dut (
        .Q(Q),
        .M(M),
        .Quo(Quo),
        .Rem(Rem),
		  .DVF(DVF),
		  .ZE(ZE)
    );

    // Testbench procedure
    initial begin
        // Monitor the signals
        $monitor("Time: %0t | Dividend: %d | Divisor: %d | Quotient: %d | Remainder: %d", 
                 $time, Q, M, Quo, Rem);

        // Test case 1: Positive Dividend, Positive Divisor
        Q = 16'd100;
        M = 16'd0;
        #10;  // Wait 10 time units

        // Test case 2: Negative Dividend, Positive Divisor
        Q = -16'd100;
        M = 16'd20;
        #10;

        // Test case 3: Positive Dividend, Negative Divisor
        Q = 16'd100;
        M = -16'd20;
        #10;

        // Test case 4: Negative Dividend, Negative Divisor
        Q = -16'd100;
        M = -16'd20;
        #10;

        // Test case 5: Zero Dividend
        Q = 16'd0;
        M = 16'd20;
        #10;

        // Test case 6: Dividend smaller than Divisor
        Q = 16'd10;
        M = 16'd20;
        #10;

        // Test case 7: Divisor is 1
        Q = 16'd12345;
        M = 16'd1;
        #10;

        // Test case 8: Divisor is -1
        Q = 16'd12345;
        M = -16'd1;
        #10;

        // Test case 9: Dividend = Divisor
        Q = 16'd50;
        M = 16'd50;
        #10;

        // Test case 10: Dividing by zero (undefined behavior)
        Q = 16'd50;
        M = 16'd0;
        #10;

        // Finish simulation
        $finish;
    end
endmodule
