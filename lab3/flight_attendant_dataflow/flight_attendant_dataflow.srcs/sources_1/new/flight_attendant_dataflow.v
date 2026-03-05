`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/04/2026 03:41:24 PM
// Design Name: 
// Module Name: flight_attendant_dataflow
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


module flight_attendant_dataflow(
input wire clk,
input wire call_button,
input wire cancel_button,
output reg light_state
);
    
wire next_state;

// Combinational Part of the Code
assign next_state = (call_button) | (light_state & (~cancel_button)) ;

// Sequential part of the code
always @(posedge clk) begin
    light_state <= next_state;
end

endmodule
