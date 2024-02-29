// Full Adder/Subtractor template
module fas (
    input logic a,           // Input bit a
    input logic b,           // Input bit b
    input logic cin,         // Carry in
    input logic a_ns,        // A_nS (add/not subtract) control
    output logic s,          // Output S
    output logic cout        // Carry out
);

	logic  wire1, wire2, wire3, wire4, wire5;

	OR2#(
		.Tpdlh(4), 
		.Tpdhl(4)
	) g1(.A(a), .B(b), .Z(wire1));

    NAND2#(
		.Tpdlh(6), 
		.Tpdhl(6)
	) g2(.A(cin), .B(b), .Z(wire2));
	
    OR2#(
		.Tpdlh(4), 
		.Tpdhl(4)
	) g3(.A(cin), .B(b), .Z(wire3));
	
    XNOR2#(
		.Tpdlh(7), 
		.Tpdhl(7)
	) g4(.A(a), .B(a_ns), .Z(wire4));
	
    XNOR2#(
		.Tpdlh(7), 
		.Tpdhl(7)
	) g5(.A(wire1), .B(cin), .Z(s));

    NAND2#(
		.Tpdlh(6), 
		.Tpdhl(6)
	) g6(.A(wire3), .B(wire4), .Z(wire5));
	
    NAND2#(
		.Tpdlh(6), 
		.Tpdhl(6)
	) g7(.A(wire2), .B(wire5), .Z(cout));
	


endmodule