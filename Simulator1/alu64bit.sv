// 64-bit ALU template
module alu64bit (
    input logic [63:0] a,    // Input bit a
    input logic [63:0] b,    // Input bit b
    input logic cin,         // Carry in
    input logic [1:0] op,    // Operation
    output logic [63:0] s,   // Output S
    output logic cout        // Carry out
);

// Put your code here
// ------------------

logic [63:0] s_wires;
logic [63:0] cout_wires;

alu1bit alu_instance0 (
            .a(a[0]),
            .b(b[0]),
            .op(op),
            .cin(cin),
            .s(s_wires[0]),
            .cout(cout_wires[0])
        );
		
genvar i;
generate
    for (i = 1; i < 64; i = i + 1) begin : alu_instances
        alu1bit alu_instance (
            .a(a[i]),
            .b(b[i]),
            .op(op),
            .cin(cout_wires[i-1]),
            .s(s[i]),
            .cout(cout_wires[i])
        );
    end
endgenerate


assign s = s_wires;
assign cout = cout_wires[63];
// End of your code

endmodule
