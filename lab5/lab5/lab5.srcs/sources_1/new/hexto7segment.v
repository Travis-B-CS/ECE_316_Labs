`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/14/2026 02:43:57 PM
// Design Name: 
// Module Name: hexto7segment
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


module hexto7segment(
    input [3:0] x,
    output reg [6:0] r
    );
    
    always @(*) begin
        case (x)
            4'b0000 : r = 7'b1000000; // 0
            4'b0001 : r = 7'b1111001; // 1
            4'b0010 : r = 7'b0100100; // 2
            4'b0011 : r = 7'b0110000; // 3
            4'b0100 : r = 7'b0011001; // 4
            4'b0101 : r = 7'b0010010; // 5
            4'b0110 : r = 7'b0000010; // 6
            4'b0111 : r = 7'b1111000; // 7
            4'b1000 : r = 7'b0000000; // 8
            4'b1001 : r = 7'b0010000; // 9
            default : r = 7'b1111111; // all off
        endcase
    end
            
endmodule



