`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/14/2026 02:38:45 PM
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
    output reg clk_10ms     // For 10ms = 100 Hz need to tick high 100E6/100 = 1,000,000
);
    reg [19:0] count; // 2^20 = 1,048,576 so this is enough for 1,000,000

    always @(posedge clk) begin
        if (reset) 
            begin
                count <= 0;
                clk_10ms <= 0;
            end 
        else if (count == 1000000 - 1) 
            begin
                count <= 0;
                clk_10ms <= 1; // Set high for 1 cycle every 100Hz
            end 
        else 
            begin
                count <= count + 1;
                clk_10ms <= 0;  // Keep low until we hit 1,000,000 cycles elapsed
            end
    end
endmodule
