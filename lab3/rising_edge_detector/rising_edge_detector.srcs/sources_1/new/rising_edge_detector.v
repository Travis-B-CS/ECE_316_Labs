`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/04/2026 04:02:42 PM
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


module rising_edge_detector(
    input clk,
    input signal,
    input reset,
    output reg outedge
);

wire slow_clk;

reg [1:0] state;
reg [1:0] next_state;

clkdiv cl(clk, reset, slow_clk);

//Combinational part
always @(*) begin
    case (state)
        2'b00 : begin
            outedge = 1'b0;
            if (~signal)
                next_state = 2'b00; //we got a low signal
            else
                next_state = 2'b01; //we got a high signal
        end
        2'b01 : begin
            outedge = 1'b1; 
            if (~signal)
                next_state = 2'b00; //signal was high now low
            else
                next_state = 2'b10; //signal was high and is still high
        end
        2'b10 : begin
            outedge = 1'b0; 
            if (~signal)
                next_state = 2'b00; //signal has been high and went low
            else
                next_state = 2'b10; //signal has been high and is staying high
        end
        default : begin
            next_state = 2'b00;
            outedge = 1'b0;
            end
    endcase
end

//Sequential Part
always @(posedge slow_clk or posedge reset) begin
    if(reset)
        state <= 2'b00;
    else
        state <= next_state;
end

endmodule
