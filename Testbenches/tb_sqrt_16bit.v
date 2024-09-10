module tb_sqrt_16bit;
    // Inputs
    reg [15:0] num;

    // Outputs
    wire [15:0] sqrt_out;

    // Instantiate the sqrt_16bit module
    sqrt uut (
        .num(num),
        .sqrt(sqrt_out)
    );

    // Test procedure
    initial begin
        // Monitor values for debugging
        $monitor("Time = %0d, num = %d, sqrt_out = %d", $time, num, sqrt_out);

        // Test cases
        num = 16'd0;      // sqrt(0) = 0
        #10;

        num = 16'd1;      // sqrt(1) = 1
        #10;

        num = 16'd4;      // sqrt(4) = 2
        #10;

        num = 16'd9;      // sqrt(9) = 3
        #10;

        num = 16'd16;     // sqrt(16) = 4
        #10;

        num = 16'd25;     // sqrt(25) = 5
        #10;

        num = 16'd36;     // sqrt(36) = 6
        #10;

        num = 16'd49;     // sqrt(49) = 7
        #10;

        num = 16'd100;    // sqrt(100) = 10
        #10;

        num = 16'd144;    // sqrt(144) = 12
        #10;

        num = 16'd1024;   // sqrt(1024) = 32
        #10;

        num = 16'd4096;   // sqrt(4096) = 64
        #10;

        num = 16'd65535;  // sqrt(65535) ≈ 255
        #10;

        // Finish simulation
        $finish;
    end

endmodule
