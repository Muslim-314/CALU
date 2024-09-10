module tb_magnitude;
    // Inputs
    reg [15:0] Real;
    reg [15:0] Imaginary;

    // Output
    wire [15:0] Mag;

    // Instantiate the Unit Under Test (UUT)
    magnitude uut (
        .Real(Real),
        .Imaginary(Imaginary),
        .Mag(Mag)
    );

    initial begin
        // Initialize inputs
        $display("Testing magnitude calculation...");

        // Test Case 1: Real = 3, Imaginary = 4 (Expected Magnitude: 5)
        Real = 16'd3;
        Imaginary = 16'd4;
        #10; // Wait for calculation to propagate
        $display("Test Case 1: Real = %d, Imaginary = %d, Magnitude = %d", Real, Imaginary, Mag);

        // Test Case 2: Real = 5, Imaginary = 12 (Expected Magnitude: 13)
        Real = 16'd5;
        Imaginary = 16'd12;
        #10;
        $display("Test Case 2: Real = %d, Imaginary = %d, Magnitude = %d", Real, Imaginary, Mag);

        // Test Case 3: Real = 8, Imaginary = 6 (Expected Magnitude: 10)
        Real = 16'd8;
        Imaginary = 16'd6;
        #10;
        $display("Test Case 3: Real = %d, Imaginary = %d, Magnitude = %d", Real, Imaginary, Mag);

        // Test Case 4: Real = 0, Imaginary = 0 (Expected Magnitude: 0)
        Real = 16'd0;
        Imaginary = 16'd0;
        #10;
        $display("Test Case 4: Real = %d, Imaginary = %d, Magnitude = %d", Real, Imaginary, Mag);

        // Test Case 5: Real = 32767, Imaginary = 32767 (Large numbers)
        Real = 16'd32767;
        Imaginary = 16'd32767;
        #10;
        $display("Test Case 5: Real = %d, Imaginary = %d, Magnitude = %d", Real, Imaginary, Mag);

        // End simulation
        $finish;
    end
endmodule
