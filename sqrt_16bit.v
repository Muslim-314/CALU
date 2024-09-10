/*
The module generates the square root of the 16 bit input 
integer. Output width is 16 bits. 
Original code: https://verilogcodes.blogspot.com/2017/11/a-verilog-function-for-finding-square-root.html  
modified by: Syed Muhamamd Muslim
Date: 9-Sep-2024
*/
module sqrt(
    input [15:0] num,   // input signal
    output reg [15:0] sqrt  // output signal
);
    // Intermediate signals
    reg [31:0] a;
    reg [15:0] q;
    reg [17:0] left, right, r;    
    integer i;

    always @(*) begin
        // Initialize all the variables
        a = {16'b0,num};
        q = 0;
        left = 0;   // input to adder/subtractor
        right = 0;  // input to adder/subtractor
        r = 0;      // remainder

        // Run the calculations for 16 iterations
        for(i = 0; i < 16; i = i + 1) begin
            right = {q, r[17], 1'b1};
            left = {r[15:0], a[31:30]};
            a = {a[29:0], 2'b00}; // Left shift by 2 bits
            if (r[17] == 1)  // Add if r is negative
                r = left + right;
            else             // Subtract if r is positive
                r = left - right;
            q = {q[14:0], !r[17]};  // Shift and assign new bit
        end
        sqrt = q;  // Final assignment of output
    end
endmodule
