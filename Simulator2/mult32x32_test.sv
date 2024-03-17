// 32X32 Multiplier test template
`include "mult32x32.sv"
module mult32x32_test;

    logic clk;            // Clock
    logic reset;          // Reset
    logic start;          // Start signal
    logic [31:0] a;       // Input a
    logic [31:0] b;       // Input b
    logic busy;           // Multiplier busy indication
    logic [63:0] product; // Miltiplication product

// Instantiate the unit under test (UUT)
    mult32x32 uut (
        .clk(clk),
        .reset(reset),
        .start(start),
        .a(a),
        .b(b),
        .busy(busy),
        .product(product)
    );

    // Test sequence
    initial begin
        // Initialize inputs
        reset = 1;
        start = 0;
        a = 0;
        b = 0;

        // Assert reset for 4 clock cycles
        #40; 
        reset = 0;
        @(negedge clk);

        // Test case 1: Simple multiplication
        a = 32'b10111; // 23 in binary
        b = 32'b101101; // 45 in binary
        #10; // Wait for a one clock cycle before starting the multiplication
        start = 1'b1;
        @(posedge clk);
         start <= 1'b0;  // Non-blocking assignment ensures 'start' goes low after 1 cycle
        // Wait for multiplication to finish
        wait (!busy); // wait for busy to go low
        @(posedge clk); // wait one more clock cycle after busy is deasserted

        // Check result of multiplication
        if (product !== 64'b10000001011) begin
            $display("Test case 1 failed: product = %b", product);
        end else begin
            $display("Test case 1 passed.");
        end

        // Add additional test cases dere with different values of a and b

    
    end

endmodule