`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/14/2026 04:14:44 PM
// Design Name: 
// Module Name: mode3
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


module mode3(
    input clk,  // 100MHz
    input RST,
    input SS, 
    input clk_10ms,     
    input [3:0] load_sec_tens, // From top 4 preset switches
    input [3:0] load_sec_ones, // From bottom 4 preset switches
    output reg [3:0] sec_tens,
    output reg [3:0] sec_ones,
    output reg [3:0] ms_hundreds,
    output reg [3:0] ms_tens
);

    // HLSM States
    localparam INIT  = 2'b00;
    localparam COUNT = 2'b01;
    localparam PAUSE = 2'b10;
    localparam DONE  = 2'b11;

    reg [1:0] state;

    always @(posedge clk) begin
        // Handle reset button to load values from switches
        if (RST) begin
            state <= INIT;
            // Load switches. If value > 9, clamp it to 9 (ignore invalid inputs)
            sec_tens <= (load_sec_tens > 9) ? 4'd9 : load_sec_tens;
            sec_ones <= (load_sec_ones > 9) ? 4'd9 : load_sec_ones;
            ms_hundreds <= 4'd0;
            ms_tens <= 4'd0;
        end else begin
            case (state)
                // Initial state continuously updates the values from the switches 
                INIT: begin
                    sec_tens <= (load_sec_tens > 9) ? 4'd9 : load_sec_tens;
                    sec_ones <= (load_sec_ones > 9) ? 4'd9 : load_sec_ones;
                    ms_hundreds <= 4'd0;
                    ms_tens <= 4'd0;
                    
                    if (SS) state <= COUNT;
                end
                
                // Count state, decrements timer's value (Like Mode 1)
                COUNT: begin
                    if (SS) begin
                        state <= PAUSE;
                    end else if (sec_tens == 0 && sec_ones == 0 && ms_hundreds == 0 && ms_tens == 0) begin
                        state <= DONE; // Stop at 00.00
                    end else if (clk_10ms) begin
                        // Decrement timer every 10ms
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
                
                // Done state - timer hit 00.00, wait for reset button
                DONE: begin
                    // Stay here until RST is pressed
                end
                
                // Default to Initial state for safety
                default: state <= INIT;
            endcase
        end
    end
endmodule