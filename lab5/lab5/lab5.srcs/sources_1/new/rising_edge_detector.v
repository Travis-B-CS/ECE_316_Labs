`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/14/2026 03:01:49 PM
// Design Name: 
// Module Name: rising_edge_detector
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


`timescale 1ns / 1ps

module rising_edge_detector(
    input clk,
    input signal,
    input reset,
    output reg outedge
);

    // slow timer for debounce
    reg [19:0] count = 0;
    wire tick_10ms = (count == 1000000 - 1);
    
    always @(posedge clk) begin
        if (tick_10ms) count <= 0;
        else count <= count + 1;
    end

    // fsm states
    localparam IDLE      = 2'b00;
    localparam PULSE     = 2'b01;
    localparam WAIT_HIGH = 2'b10;

    reg [1:0] state = WAIT_HIGH; // default to initial state
    reg [1:0] next_state;

    // combinational states
    always @(*) begin
        case (state)
            IDLE : begin
                if (~signal) next_state = IDLE;
                else         next_state = PULSE;
            end
            
            PULSE : begin
                if (~signal) next_state = IDLE;
                else         next_state = WAIT_HIGH;
            end
            
            WAIT_HIGH : begin
                if (~signal) next_state = IDLE;
                else         next_state = WAIT_HIGH;
            end
            
            default : next_state = WAIT_HIGH;
        endcase
    end

    // move states every 10ms (slow clk)
    always @(posedge clk) begin
        if(reset)
            state <= WAIT_HIGH;
        else if (tick_10ms)
            state <= next_state;
    end

    // output high to external for only 10ns
    always @(posedge clk) begin
        if (tick_10ms && state == IDLE && next_state == PULSE)
            outedge <= 1'b1;
        else
            outedge <= 1'b0;
    end

endmodule
