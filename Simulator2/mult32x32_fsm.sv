// 32X32 Multiplier FSM
module mult32x32_fsm (
    input logic clk,              // Clock
    input logic reset,            // Reset
    input logic start,            // Start signal
    output logic busy,            // Multiplier busy indication
    output logic [1:0] a_sel,     // Select one byte from A
    output logic b_sel,           // Select one 2-byte word from B
    output logic [2:0] shift_sel, // Select output from shifters
    output logic upd_prod,        // Update the product register
    output logic clr_prod         // Clear the product register
);

typedef enum logic[3:0] {
    INITIAL,
    STATE_A0,
    STATE_A1,
    STATE_A2,
    STATE_A3,
    STATE_A4,
    STATE_A5,
    STATE_A6,
    STATE_A7
} fsm_state_t;



fsm_state_t state, next_state;
logic [63:0] product;
logic started_calc;

always_ff @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= INITIAL;
        product <= 64'b0;        // Clear the product register upon reset
        started_calc <= 1'b0;
    end else if (start) begin
        if (!started_calc) begin // If not already started, initialize for new calculation
            state <= next_state;
            product <= 64'b0;    // Clear the product register at the start of a new calculation
            started_calc <= 1'b1;
        end else begin
            state <= next_state; // Continue with ongoing calculation
            // Do not reset product here, as it may hold intermediate results
        end
    end
end


    always_comb begin : blockName
        case(state)
            INITIAL: begin
                a_sel = 2'bx;
                b_sel = 1'bx;
                shift_sel = 3'bx;
                upd_prod = 1'bx;
                clr_prod = 1'b1;
                busy = 1'b0;
                next_state = STATE_A0;
            end
            STATE_A0: begin
                a_sel = 2'b11;
                b_sel = 1'b1;
                shift_sel = 3'b101;
                upd_prod = 1'b1;
                clr_prod = 1'b0;
                busy = 1'b1;
                next_state = STATE_A1;
            end
             STATE_A1: begin
                a_sel = 2'b10;
                b_sel = 1'b1;
                shift_sel = 3'b100;  // Corrected apostrophe
                upd_prod = 1'b1;
                clr_prod = 1'b0;
                busy = 1'b1;
                next_state = STATE_A2;   
            end
            STATE_A2: begin
                a_sel = 2'b01;
                b_sel = 1'b1;
                shift_sel = 3'b011;  // Corrected apostrophe
                upd_prod = 1'b1;
                clr_prod = 1'b0;
                busy = 1'b1;
                next_state = STATE_A3;   
            end
            STATE_A3: begin
                a_sel = 2'b00;
                b_sel = 1'b1;
                shift_sel = 3'b000;  // Corrected apostrophe
                upd_prod = 1'b1;
                clr_prod = 1'b0;
                busy = 1'b1;
                next_state = STATE_A4;
            end
            STATE_A4: begin
                a_sel = 2'b11;
                b_sel = 1'b0;
                shift_sel = 3'b011;
                upd_prod = 1'b1;
                clr_prod = 1'b0;
                busy = 1'b1;
                next_state = STATE_A5;
            end
            STATE_A5: begin
                a_sel = 2'b10;
                b_sel = 1'b0;
                shift_sel = 3'b010;
                upd_prod = 1'b1;
                clr_prod = 1'b0;
                busy = 1'b1;
                next_state = STATE_A6;
            end
            STATE_A6: begin
                a_sel = 2'b01;
                b_sel = 1'b0;
                shift_sel = 3'b001;
                upd_prod = 1'b1;
                clr_prod = 1'b0;
                busy = 1'b1;
                next_state = STATE_A7;
            end
            STATE_A7: begin
                a_sel = 2'b00;
                b_sel = 1'b0;
                shift_sel = 3'b000;
                upd_prod = 1'b1;
                clr_prod = 1'b0;
                busy = 1'b0;
                next_state = INITIAL;
            end

        endcase
        
    end

endmodule
