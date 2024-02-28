// Full Adder/Subtractor test bench template
module fas_test;


// Signal declarations
logic d0;          // Data input 0
logic d1;          // Data input 1
logic d2;          // Data input 2
logic d3;          // Data input 3
logic [1:0] sel;   // Select input
logic z;           // Output

// Instance of the unit under test (mux4)
mux4 uut(
    .d0(d0),
    .d1(d1),
    .d2(d2),
    .d3(d3),
    .sel(sel),
    .z(z)
);

// Stimulus generation
initial begin
    // Initialize inputs
    d0 = 1'b0;
    d1 = 1'b0;
    d2 = 1'b1;
    d3 = 1'b1;
    sel = 2'b00;

    // Apply inputs for 32 time units
    #32;

    // Change select input and maintain inputs
    sel = 2'b10;

    // Apply inputs for 16 time units
    #16;

    // Change select input back to 00 and maintain inputs
    sel = 2'b00;

    // Apply inputs for additional simulation time if needed
    // #additional_time;

    // End simulation
    $finish;
end

endmodule
