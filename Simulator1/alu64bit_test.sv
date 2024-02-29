module alu64bit_test;

    // Parameters
    parameter SIM_TIME = 100; // Simulation time

    // Signals
    logic [63:0] a;    // Input bits a
    logic [63:0] b;    // Input bits b
    logic cin;         // Carry in
    logic [1:0] op;    // Operation
    logic [63:0] s;    // Output bits s
    logic cout;        // Carry out

    // Instantiate the ALU
    alu64bit alu_inst (
        .a(a),
        .b(b),
        .cin(cin),
        .op(op),
        .s(s),
        .cout(cout)
    );

    // Test case generator
    initial begin
        // Initialize inputs
        a = 64'b0101010101010101010101010101010101010101010101010101010101010101;
        b = 64'b0011001100110011001100110011001100110011001100110011001100110011;
        cin = 1'b0;
        op = 2'b00;  // Example operation (addition)

        // Wait for a brief period to observe the output
        #10;

        // Additional test cases can be added here
    end

    // End simulation
    initial
        #SIM_TIME $finish; // Adjust simulation time as needed
    

endmodule
