// Full Adder/Subtractor test bench template
module fas_test;

    // Signal declarations
    logic a;           // Input bit a
    logic b;           // Input bit b
    logic cin;         // Carry in
    logic a_ns;        // A_nS (add/not subtract) control
    logic s;           // Output S
    logic cout;        // Carry out

    // Instance of the unit under test (fas)
    fas uut(
        .a(a),
        .b(b),
        .cin(cin),
        .a_ns(a_ns),
        .s(s),
        .cout(cout)
    );

    // Stimulus generation
    initial begin
        // Test case 1: Addition without carry-in
        a = 1'b0;
        b = 1'b0;
        cin = 1'b0;
        a_ns = 1'b0;  // Add
        #19;  // Delay to observe output

        // Test case 2: Subtraction without carry-in
        a = 1'b0;
        b = 1'b0;
        cin = 1'b0;
        a_ns = 1'b1;  // Subtract
        #19;  // Delay to observe output

        // Additional test cases as needed
    end

endmodule
