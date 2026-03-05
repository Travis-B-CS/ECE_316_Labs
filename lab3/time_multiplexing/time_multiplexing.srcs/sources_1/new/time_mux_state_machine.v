`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/04/2026 07:33:51 PM
// Design Name: 
// Module Name: time_mux_state_machine
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


module time_mux_state_machine(
    input clk,
    input reset,
    input [6:0] in0,
    input [6:0] in1,
    input [6:0] in2,
    input [6:0] in3,
    output reg [3:0] an,
    output reg [6:0] sseg
);

reg [1:0] state;
reg [1:0] next_state;

always @ (*) begin
    case(state) //this is our states
        2'b00: next_state = 2'b01;
        2'b01: next_state = 2'b10;
        2'b10: next_state = 2'b11;
        2'b11: next_state = 2'b00;
        default: next_state = 2'b00; //fail safe default
    endcase
end

always @(*) begin
    case (state) //this is for assigning the sseg values
        2'b00 : sseg = in0;
        2'b01 : sseg = in1;
        2'b10 : sseg = in2;
        2'b11 : sseg = in3;
        default : sseg = 7'b1111111; //default all off
    endcase

    case (state) //this is to controll which anode is on
        2'b00 : an = 4'b1110; // right
        2'b01 : an = 4'b1101;
        2'b10 : an = 4'b1011;
        2'b11 : an = 4'b0111; //left
        default : an = 4'b1111; //default none
    endcase
end

//this is sequential part on clk
always @(posedge clk or posedge reset) begin
    if(reset)
        state <= 2'b00;
    else
        state <= next_state;
end

endmodule
