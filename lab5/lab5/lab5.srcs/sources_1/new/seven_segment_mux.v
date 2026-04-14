`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/14/2026 03:05:22 PM
// Design Name: 
// Module Name: seven_segment_mux
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


module seven_segment_mux(
    input clk,                 // 100MHz default clock
    input reset,
    input [3:0] sec_tens,      
    input [3:0] sec_ones,      
    input [3:0] ms_hundreds,   
    input [3:0] ms_tens,       
    output reg [3:0] an,       // leds for the 4 digits
    output reg [6:0] sseg,     // actual segments
    output reg dp              // Decimal point for 99.99
);


    wire [6:0] in3, in2, in1, in0;
    
    hexto7segment h3 (.x(sec_tens),    .r(in3));
    hexto7segment h2 (.x(sec_ones),    .r(in2));
    hexto7segment h1 (.x(ms_hundreds), .r(in1));
    hexto7segment h0 (.x(ms_tens),     .r(in0));

    // this needs to cycle through the digits quickly unlike the old lab
    // so that way they all seem on at once, arbitrarily picked 1kHz
    // 100MHz / 100,000 = 1 kHz refresh rate
    reg [16:0] refresh_count;
    wire refresh_tick = (refresh_count == 17'd100000);

    always @(posedge clk) begin
        if (reset)
            refresh_count <= 0;
        else if (refresh_tick)
            refresh_count <= 0;
        else
            refresh_count <= refresh_count + 1;
    end


    reg [1:0] state;
    reg [1:0] next_state;

    // Determines next state (switched digits)
    always @(*) begin
        case(state)
            2'b00: next_state = 2'b01;
            2'b01: next_state = 2'b10;
            2'b10: next_state = 2'b11;
            2'b11: next_state = 2'b00;
            default: next_state = 2'b00;
        endcase
    end

    // outputs
    always @(*) begin
        case (state)
            // 00 is 10ms
            2'b00 : begin
                sseg = in0;
                an = 4'b1110; 
                dp = 1'b1; // no decimal point
            end
            
            // 01 is 100ms
            2'b01 : begin
                sseg = in1;
                an = 4'b1101;
                dp = 1'b1; // no decimal point
            end
            
            // 10 is 1sec
            2'b10 : begin
                sseg = in2;
                an = 4'b1011;
                dp = 1'b0; // turn on decimal point
            end
            
            // 11 is 10sec
            2'b11 : begin
                sseg = in3;
                an = 4'b0111;
                dp = 1'b1; // no decimal point
            end
            
            // default is all off to be safe
            default : begin
                sseg = 7'b1111111;
                an = 4'b1111;
                dp = 1'b1;
            end
        endcase
    end

    // move states
    always @(posedge clk or posedge reset) begin
        if(reset)
            state <= 2'b00;     // go back to starting state
        else if (refresh_tick) // switch states (digits) at 1kHz
            state <= next_state;
    end

endmodule
