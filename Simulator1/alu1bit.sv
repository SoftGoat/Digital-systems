// 1-bit ALU template
module alu1bit (
    input logic a,           // Input bit a
    input logic b,           // Input bit b
    input logic cin,         // Carry in
    input logic [1:0] op,    // Operation
    output logic s,          // Output S
    output logic cout        // Carry out
);
logic  wire1, wire2, wire3, wire4, wire6;

    OR2#(
		.Tpdlh(4), 
		.Tpdhl(4)
	) g1(.A(a), .B(b), .Z(wire1));
	

    XNOR2#(
		.Tpdlh(7), 
		.Tpdhl(7)
	) g2(.A(b), .B(a), .Z(wire2));
	
    NAND2#(
		.Tpdlh(6), 
		.Tpdhl(6)
	) g3(.A(op[0]), .B(op[0]), .Z(wire3));

    NAND2#(
		.Tpdlh(6), 
		.Tpdhl(6)
	) g4(.A(wire1), .B(wire1), .Z(wire4));

    NAND2#(
		.Tpdlh(6), 
		.Tpdhl(6)
	) g5(.A(wire2), .B(wire2), .Z(wire5));


    fas uut (
        .a(a),
        .b(b),
        .cin(cin),
        .a_ns(wire3),
        .s(wire6),
        .cout(cout)
    );

    mux4 uut1 (
        .d0(wire4),
        .d1(wire5),
        .d2(wire6),
        .d3(wire6),
        .sel(op),
        .s(s)
    );

endmodule
