module alu64bit (
    input logic [63:0] a,           // Input bits a
    input logic [63:0] b,           // Input bits b
    input logic cin,                // Carry in
    input logic [1:0] op,           // Operation
    output logic [63:0] s,          // Output bits s
    output logic cout               // Carry out
);

    // Signals
    logic [63:0] s_intermediate;    // Intermediate result for each bit
    logic [63:0] cout_intermediate; // Intermediate carry for each bit

    // Instantiate the first ALU instance with direct connections
    alu1bit alu_inst_gen_0 (
        .a(a[0]),
        .b(b[0]),
        .cin(cin),
        .op(op),
        .s(s_intermediate[0]),
        .cout(cout_intermediate[0])
    );

    // Instantiate the remaining ALU instances with carry-in connected to carry-out of the previous instance
    genvar i;
    generate
        for (i = 1; i < 64; i = i + 1) begin : alu_inst_gen
            alu1bit alu_inst (
                .a(a[i]),
                .b(b[i]),
                .cin(cout_intermediate[i-1]),  // Connect cin to the cout of the previous ALU instance
                .op(op),
                .s(s_intermediate[i]),
                .cout(cout_intermediate[i])
            );
        end
    endgenerate

    // Assign the final carry-out to the output port
    assign cout = cout_intermediate[63];

    // Assign the intermediate results to the output port
    assign s = s_intermediate;

endmodule
