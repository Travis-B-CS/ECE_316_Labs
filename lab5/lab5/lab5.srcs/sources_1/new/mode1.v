`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/14/2026 02:46:13 PM
// Design Name: 
// Module Name: mode1
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


// This is count down from 99.99sec
module mode1(
    input clk,  // 100MHz
    input RST,
    input SS, 
    input clk_10ms,     // custom 100Hz clk
    output reg [3:0] sec_tens,
    output reg [3:0] sec_ones,
    output reg [3:0] ms_hundreds,
    output reg [3:0] ms_tens
);

    // HLSM State
    localparam INIT  = 2'b00;
    localparam COUNT = 2'b01;
    localparam PAUSE = 2'b10;
    localparam DONE  = 2'b11;

    reg [1:0] state;

    always @(posedge clk) begin
        // Handle reset button to load all 9's and move to initial state
        if (RST) begin
            state <= INIT;
            sec_tens <= 4'd9;
            sec_ones <= 4'd9;
            ms_hundreds <= 4'd9;
            ms_tens <= 4'd9;
        end else begin
            case (state)
                // Initial state load all 9's, and move to counting state if start/stop is pressed
                INIT: begin
                    sec_tens <= 4'd9;
                    sec_ones <= 4'd9;
                    ms_hundreds <= 4'd9;
                    ms_tens <= 4'd9;
                    if (SS) state <= COUNT;
                end
                // Count state, decrements timer's value and moves states if reset/start/stop is hit or if timer hits 0
                COUNT: begin
                    if (SS) begin
                        state <= PAUSE;
                    end else if (sec_tens == 0 && sec_ones == 0 && ms_hundreds == 0 && ms_tens == 0) begin
                        state <= DONE;
                    end else if (clk_10ms) begin
                        // decrement timer every 10ms
                        if (ms_tens > 0) 
                            ms_tens <= ms_tens - 1;
                        else begin
                            ms_tens <= 4'd9;
                            if (ms_hundreds > 0) 
                                ms_hundreds <= ms_hundreds - 1;
                            else begin
                                ms_hundreds <= 4'd9;
                                if (sec_ones > 0) 
                                    sec_ones <= sec_ones - 1;
                                else begin
                                    sec_ones <= 4'd9;
                                    if (sec_tens > 0) 
                                        sec_tens <= sec_tens - 1;
                                end
                            end
                        end
                    end
                end
                // Pause state just waits for start/stop button
                PAUSE: begin
                    if (SS) state <= COUNT;
                end
                // Done state - timer has it zero wait for reset button
                DONE: begin
                    // Stay here until RST is pressed
                end
                // Default to Initial state for safety
                default: state <= INIT;
            endcase
        end
    end
endmodule
