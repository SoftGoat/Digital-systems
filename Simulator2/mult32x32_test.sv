`include "mult32x32.sv"

module mult32x32_test;

    // Testbench signals
    logic clk;            // Clock
    logic reset;          // Reset
    logic start;          // Start signal
    logic [31:0] a;       // Input a
    logic [31:0] b;       // Input b
    logic busy;           // Multiplier busy indication
    logic [63:0] product; // Multiplication product

    // Instantiate the multiplier unit
    mult32x32 uut (
        .clk(clk),
        .reset(reset),
        .start(start),
        .a(a),
        .b(b),
        .busy(busy),
        .product(product)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // Generate a clock with 10ns period (100MHz)
    end

    // Test procedure
    initial begin
        // Initialize inputs
        reset = 1;
        start = 0;
        a = 0;
        b = 0;

        // Reset the multiplier
        #10;
        reset = 0;
        
        // Wait for the multiplier to be ready
        wait(!busy)
        $display("Multiplier ready");
        // Test vector 1
        a = 32'h17; // First input value
        b = 32'h2D; // Second input value
        start = 1;
        #10; // Apply start for one clock cycle
        start = 0;
        
        // Wait for the multiplication to finish
        wait(!busy)
        $display("Multiplication finished");
        $display("Current simulation time: %0t", $time);

        // Check result
        if (product !== 64'h40b) begin
            $display("Test vector 1 failed: expected 64'h40B, got %h", product);
        end else begin
            $display("Test vector 1 passed: got %h", product);
        end

        // Insert additional test vectors here

        // Finish simulation
        #100; 
    end

endmodule