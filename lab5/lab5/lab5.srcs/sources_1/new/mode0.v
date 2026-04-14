`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/14/2026 03:53:35 PM
// Design Name: 
// Module Name: mode0
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

// counts up from 0
module mode0(
    input clk,  // 100Mhz defualt
    input RST,
    input SS, 
    input clk_10ms,     
    output reg [3:0] sec_tens,
    output reg [3:0] sec_ones,
    output reg [3:0] ms_hundreds,
    output reg [3:0] ms_tens
);

    // states
    localparam INIT  = 2'b00;
    localparam COUNT = 2'b01;
    localparam PAUSE = 2'b10;
    localparam DONE  = 2'b11;

    reg [1:0] state;

    always @(posedge clk) begin
        // load all 0s on reset and initial state
        if (RST) begin
            state <= INIT;
            sec_tens <= 4'd0;
            sec_ones <= 4'd0;
            ms_hundreds <= 4'd0;
            ms_tens <= 4'd0;
        end else begin
            case (state)
                // initial state loads all 0s
                INIT: begin
                    sec_tens <= 4'd0;
                    sec_ones <= 4'd0;
                    ms_hundreds <= 4'd0;
                    ms_tens <= 4'd0;
                    if (SS) state <= COUNT;
                end
                
                // count state increments
                COUNT: begin
                    if (SS) begin
                        state <= PAUSE;
                    end else if (sec_tens == 9 && sec_ones == 9 && ms_hundreds == 9 && ms_tens == 9) begin
                        state <= DONE; // if we hit 99.99
                    end else if (clk_10ms) begin
                        // count every 10ms
                        if (ms_tens < 9) 
                            ms_tens <= ms_tens + 1;
                        else begin
                            ms_tens <= 4'd0;
                            if (ms_hundreds < 9) 
                                ms_hundreds <= ms_hundreds + 1;
                            else begin
                                ms_hundreds <= 4'd0;
                                if (sec_ones < 9) 
                                    sec_ones <= sec_ones + 1;
                                else begin
                                    sec_ones <= 4'd0;
                                    if (sec_tens < 9) 
                                        sec_tens <= sec_tens + 1;
                                end
                            end
                        end
                    end
                end
                
                // pause state - dont cnt up
                PAUSE: begin
                    if (SS) state <= COUNT;
                end
                
                // done state to stall at 99.99
                DONE: begin
                    // wait for rst
                end
                
                // default for safety
                default: state <= INIT;
            endcase
        end
    end
endmodule
