`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/04/2026 04:15:18 PM
// Design Name: 
// Module Name: clkdiv
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


module clkdiv(
    input clk,
    input reset,
    output clk_out
);

reg [26:0] COUNT; //this controls the speed of the slower clock, setting to [1:0] for simulation speed so slow clk is about every 40ns
                 //for 1 Hz we have desired freq = clk freq / 2^n so 1 = 100,000,000/2^n so n = 26.57542 so I will use a 27 bit counter for about 0.74Hz

assign clk_out=COUNT[26];

always @(posedge clk) begin
    if (reset)
        COUNT = 0;
    else
        COUNT = COUNT + 1;
    end
endmodule
