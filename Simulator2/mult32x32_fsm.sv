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
        $display("Resetting FSM");
    end 
    else if (started_calc && state != INITIAL) begin
        state <= next_state;
        product <= product;    // Keep the product register unchanged
        started_calc <= 1'b1;
        $display("Continuing calculation");
    end
    else if (start) begin
            state <= next_state;
            product <= 64'b0;    // Clear the product register at the start of a new calculation
            started_calc <= 1'b1;
            $display("Starting new calculation");
    end
    else begin
        state <= state;        // Keep the state unchanged
        started_calc <= 1'b0;
        end
    end



        always_comb begin : blockName
            case(state)
                INITIAL: begin
                    $display("State: INITIAL");
                    if (start) begin
                        a_sel = 2'bx;
                        b_sel = 1'bx;
                        shift_sel = 3'bx;
                        upd_prod = 1'bx;
                        clr_prod = 1'b1;
                        busy = 1'b0;
                        next_state = STATE_A0;
                    end
                    else begin
                        a_sel = 2'b00;
                        b_sel = 1'b0;
                        shift_sel = 3'b000;
                        upd_prod = 1'b0;
                        clr_prod = 1'b0;
                        busy = 1'b0;
                        next_state = INITIAL;
                    end
                   
                end
                STATE_A0: begin
                    $display("State: STATE_A0");
                    a_sel = 2'b11;
                    b_sel = 1'b1;
                    shift_sel = 3'b101;
                    upd_prod = 1'b1;
                    clr_prod = 1'b0;
                    busy = 1'b1;
                    next_state = STATE_A1;
                end
                 STATE_A1: begin
                    $display("State: STATE_A1");
                    a_sel = 2'b10;
                    b_sel = 1'b1;
                    shift_sel = 3'b100;
                    upd_prod = 1'b1;
                    clr_prod = 1'b0;
                    busy = 1'b1;
                    next_state = STATE_A2;   
                end
                STATE_A2: begin
                    $display("State: STATE_A2");
                    a_sel = 2'b01;
                    b_sel = 1'b1;
                    shift_sel = 3'b011;
                    upd_prod = 1'b1;
                    clr_prod = 1'b0;
                    busy = 1'b1;
                    next_state = STATE_A3;   
                end
                STATE_A3: begin
                    $display("State: STATE_A3");
                    a_sel = 2'b00;
                    b_sel = 1'b1;
                    shift_sel = 3'b000;
                    upd_prod = 1'b1;
                    clr_prod = 1'b0;
                    busy = 1'b1;
                    next_state = STATE_A4;
                end
                STATE_A4: begin
                    $display("State: STATE_A4");
                    a_sel = 2'b11;
                    b_sel = 1'b0;
                    shift_sel = 3'b011;
                    upd_prod = 1'b1;
                    clr_prod = 1'b0;
                    busy = 1'b1;
                    next_state = STATE_A5;
                end
                STATE_A5: begin
                    $display("State: STATE_A5");
                    a_sel = 2'b10;
                    b_sel = 1'b0;
                    shift_sel = 3'b010;
                    upd_prod = 1'b1;
                    clr_prod = 1'b0;
                    busy = 1'b1;
                    next_state = STATE_A6;
                end
                STATE_A6: begin
                    $display("State: STATE_A6");
                    a_sel = 2'b01;
                    b_sel = 1'b0;
                    shift_sel = 3'b001;
                    upd_prod = 1'b1;
                    clr_prod = 1'b0;
                    busy = 1'b1;
                    next_state = STATE_A7;
                end
                STATE_A7: begin
                    $display("State: STATE_A7");
                    a_sel = 2'b00;
                    b_sel = 1'b0;
                    shift_sel = 3'b000;
                    upd_prod = 1'b1;
                    clr_prod = 1'b0;
                    busy = 1'b1;
                    next_state = INITIAL;
                end

            endcase
            
        end

    endmodule
