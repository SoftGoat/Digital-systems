// Full Adder/Subtractor test bench
module fas_test;

    // Parameters
    parameter SIM_TIME = 100; // Simulation time

    // Signals
    logic a, b, cin, a_ns; // Inputs
    logic s, cout;          // Outputs

    // Instantiate the fas module
    fas uut (
        .a(a),
        .b(b),
        .cin(cin),
        .a_ns(a_ns),
        .s(s),
        .cout(cout)
    );

    // Test case generator
    initial begin
        // Test case 1: Addition with carry-in
        a = 1'b1;
        b = 1'b1;
        cin = 1'b1;
        a_ns = 1'b0;  // Add
        #19;  // Delay to observe output

        // Test case 2: Subtraction without carry-in
        a = 1'b0;
        b = 1'b1;
        cin = 1'b0;
        a_ns = 1'b1;  // Subtract
        #19;  // Delay to observe output

        // Test case 3: Addition without carry-in
        a = 1'b1;
        b = 1'b0;
        cin = 1'b0;
        a_ns = 1'b0;  // Add
        #19;  // Delay to observe output

        // Additional test cases can be added here
    end

    // End simulation
    initial
        #SIM_TIME $finish;
    

endmodule
