// 32X32 Multiplier arithmetic unit template
module mult32x32_arith (
    input logic clk,             // Clock
    input logic reset,           // Reset
    input logic [31:0] a,        // Input a
    input logic [31:0] b,        // Input b
    input logic [1:0] a_sel,     // Select one byte from A
    input logic b_sel,           // Select one 2-byte word from B
    input logic [2:0] shift_sel, // Select output from shifters
    input logic upd_prod,        // Update the product register
    input logic clr_prod,        // Clear the product register
    output logic [63:0] product  // Miltiplication product
);

// Your code goes here

logic [7:0] selected_a_byte;
logic [15:0] selected_b_word;
logic [15:0] multiplier_output;
logic [63:0] shifted_output;
logic [63:0] new_product;


always_comb begin
    case(a_sel)
        2'b00: selected_a_byte = a[7:0];
        2'b01: selected_a_byte = a[15:8];
        2'b10: selected_a_byte = a[23:16];
        2'b11: selected_a_byte = a[31:24];
    endcase
end

always_comb begin
    if (!b_sel) begin
        selected_b_word = b[15:0];
    end else begin
        selected_b_word = b[31:16];
    end
end

                          
always_comb begin
    multiplier_output = selected_a_byte * selected_b_word;
    case(shift_sel)
        3'b000: shifted_output  = multiplier_output;
        3'b001: shifted_output = multiplier_output << 8;
        3'b010: shifted_output = multiplier_output << 16;
        3'b011: shifted_output = multiplier_output << 24;
        3'b100: shifted_output = multiplier_output << 32;
        3'b101: shifted_output = multiplier_output << 40;
        3'b110: shifted_output = multiplier_output << 48; // dont really need this
        3'b111: shifted_output = multiplier_output << 56; // dont really need this
    endcase
end

always_ff @(posedge clk or posedge reset) begin
    if (reset) begin
        product <= 64'b0;
    end else if (upd_prod) begin
        if (clr_prod) begin
            product <= 64'b0;
        end else begin
            product <= product + shifted_output;
        end
    end
end 

endmodule

