// 1-bit ALU template
module alu1bit (
    input logic a,           // Input bit a
    input logic b,           // Input bit b
    input logic cin,         // Carry in
    input logic [1:0] op,    // Operation
    output logic s,          // Output S
    output logic cout        // Carry out
);

// Put your code here
// ------------------
	logic wire1, wire2, wire3, wire4, wire5, sum2;
	
	NAND2#(
		.Tpdlh(6), 
		.Tpdhl(6)
	) g1(.A(op[0]), .B(op[0]), .Z(wire1));
	
	OR2#(
		.Tpdlh(4), 
		.Tpdhl(4)
	) g2(.A(a), .B(b), .Z(wire2));
	
	NAND2#(
		.Tpdlh(6), 
		.Tpdhl(6)
	) g3(.A(wire2), .B(wire2), .Z(wire3));
	
	
	XNOR2#(
		.Tpdlh(7), 
		.Tpdhl(7)
	) g4(.A(a), .B(cin), .Z(wire4));
	
	NAND2#(
		.Tpdlh(6), 
		.Tpdhl(6)
	) g5(.A(wire4), .B(wire4), .Z(wire5));
	
	
	fas FAS(.a(a), .b(b), .cin(cin), .a_ns(wire1), .s(sum2), .cout(cout));
	
	
	mux4 uut(
        .d0(wire3),
        .d1(wire5),
        .d2(sum2),
        .d3(sum2),
		.sel(op),
		.z(s)
    );
	

// End of your code

endmodule
