

module tb_negate_sign;

    // Inputs
    reg [15:0] in_num;

    // Outputs
    wire [15:0] out_num;

    // Instantiate the Unit Under Test (UUT)
    negate_sign uut (
        .in_num(in_num), 
        .out_num(out_num)
    );

    initial begin
        // Monitor the inputs and outputs
        
        // Test case 1: Input = 2
        in_num = 16'd2;
        #10;
        
        // Test case 2: Input = 4
        in_num = 16'd4;
        #10;
        
        // Test case 3: Input = 5
        in_num = 16'd5;
        #10;
        
        // Test case 4: Input = -3
        in_num = -16'd3;
        #10;
        
        // Test case 5: Input = 0
        in_num = 16'd0;
        #10;

        // Finish simulation
        $finish;
    end

endmodule
