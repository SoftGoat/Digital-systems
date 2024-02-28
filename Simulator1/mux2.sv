module mux2 (
    input logic d0,          // Data input 0
    input logic d1,          // Data input 1
    input logic sel,         // Select input
    output logic z           // Output
);

// Put your code here
// ------------------
	logic  wire1, wire2, wire3, wire4;

	OR2#(
		.Tpdlh(4), 
		.Tpdhl(4)
	) g1(.A(d0), .B(sel), .Z(wire1));
	

	NAND2#(
		.Tpdlh(6), 
		.Tpdhl(6)
	) g2(.A(sel), .B(sel), .Z(wire2));
	
	
	OR2#(
		.Tpdlh(4), 
		.Tpdhl(4)
	) g3(.A(d1), .B(wire2), .Z(wire3));
	
	NAND2#(
		.Tpdlh(6), 
		.Tpdhl(6)
	) g4(.A(wire1), .B(wire3), .Z(wire4));
	
	
	
	NAND2#(
		.Tpdlh(6), 
		.Tpdhl(6)
	) result(.A(wire4), .B(wire4), .Z(z));
	
	
 

// End of your code

endmodule
