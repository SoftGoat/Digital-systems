`include "mult32x32_arith.sv"
module mult32x32_arith_test;

    // Testbench signals
    logic clk;
    logic reset;
    logic [31:0] a;
    logic [31:0] b;
    logic [1:0] a_sel;
    logic b_sel;
    logic [2:0] shift_sel;
    logic upd_prod;
    logic clr_prod;
    logic [63:0] product;

    // Instantiate the arithmetic unit
    mult32x32_arith uut (
        .clk(clk),
        .reset(reset),
        .a(a),
        .b(b),
        .a_sel(a_sel),
        .b_sel(b_sel),
        .shift_sel(shift_sel),
        .upd_prod(upd_prod),
        .clr_prod(clr_prod),
        .product(product)
    );

    // Clock generation
    always begin
        clk = 1'b0;
        #5;
        clk = 1'b1;
        #5;
    end

    // Test procedure
    initial begin
        // Initialize inputs
        reset = 1'b1;
        a_sel = 2'b00; // Selecting the lowest byte of 'a'
        b_sel = 1'b0; // Selecting the upper word of 'b'
        shift_sel = 3'b000; // No shifting
        upd_prod = 1'b0;
        clr_prod = 1'b1;
        a = 0;
        b = 0;

        // Apply reset
        #40;
        reset = 1'b0;
        clr_prod = 1'b0;
        #100
        // First test vector
        a = 32'h000000FF; // 255 in the lowest byte
        b = 32'hFFFF0000; // 65535 in the upper word
        a_sel = 2'b00;
        b_sel = 1'b1;
        shift_sel = 3'b010; // Shift by 16 bits to align the product correctly
        #20;
        upd_prod = 1'b1; // Update the product with the new values
        #10; // Wait for the product to be updated
        upd_prod = 1'b0; // Deactivate update
        #10; // Wait for the product to be updated

        // Check result for the first test vector
        if (product !== 64'hFEFF010000) begin
            $display("Test vector 1 failed: expected 64'FEFF010000, got %h", product);
        end else begin
            $display("Test vector 1 passed: got %h", product);
        end

        // Add more test vectors as needed

    end

endmodule
