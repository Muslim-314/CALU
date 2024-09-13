module tb_adder_subtractor_16bit_with_overflow();
    
    // Testbench signals
    reg [15:0] A;          // First 16-bit input
    reg [15:0] B;          // Second 16-bit input
    reg Sub;               // Subtract signal: 0 for addition, 1 for subtraction
    reg Cin;               // Carry-in
    wire [15:0] Result;    // Result output
    wire Cout;             // Carry-out
    wire Overflow;         // Overflow flag

    // Instantiate the design under test (DUT)
    adder_subtractor_16bit dut (
        .A(A),
        .B(B),
        .Sub(Sub),
        .Cin(Cin),
        .Result(Result),
        .Cout(Cout),
        .Overflow(Overflow)
    );

    // Stimulus for the testbench
    initial begin
        // Test Case 1: Addition without overflow
        A = 16'h4000;      // A = 16384
        B = 16'h4000;      // B = 16384
        Sub = 0;           // Addition
        Cin = 0;           // No carry-in
        #10;
        $display("A = %h, B = %h, Sub = %b, Cin = %b | Result = %h, Cout = %b, Overflow = %b", A, B, Sub, Cin, Result, Cout, Overflow);

        // Test Case 2: Subtraction without overflow
        A = 16'h8000;      // A = -32768 (signed)
        B = 16'h7FFF;      // B = 32767 (signed)
        Sub = 1;           // Subtraction
        Cin = 0;           // No carry-in
        #10;
        $display("A = %h, B = %h, Sub = %b, Cin = %b | Result = %h, Cout = %b, Overflow = %b", A, B, Sub, Cin, Result, Cout, Overflow);

        // Test Case 3: Addition with overflow
        A = 16'h7FFF;      // A = 32767 (signed)
        B = 16'h0001;      // B = 1
        Sub = 0;           // Addition
        Cin = 0;           // No carry-in
        #10;
        $display("A = %h, B = %h, Sub = %b, Cin = %b | Result = %h, Cout = %b, Overflow = %b", A, B, Sub, Cin, Result, Cout, Overflow);

        // Test Case 4: Subtraction with overflow
        A = 16'h8000;      // A = -32768 (signed)
        B = 16'h0001;      // B = 1
        Sub = 1;           // Subtraction
        Cin = 0;           // No carry-in
        #10;
        $display("A = %h, B = %h, Sub = %b, Cin = %b | Result = %h, Cout = %b, Overflow = %b", A, B, Sub, Cin, Result, Cout, Overflow);

        // Test Case 5: Subtraction without overflow
        A = 16'h7FFF;      // A = 32767 (signed)
        B = 16'h7FFF;      // B = 32767 (signed)
        Sub = 1;           // Subtraction
        Cin = 0;           // No carry-in
        #10;
        $display("A = %h, B = %h, Sub = %b, Cin = %b | Result = %h, Cout = %b, Overflow = %b", A, B, Sub, Cin, Result, Cout, Overflow);

        // Finish the simulation
        $finish;
    end

endmodule
