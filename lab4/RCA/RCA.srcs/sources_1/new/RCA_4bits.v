`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/24/2026 03:30:44 PM
// Design Name: 
// Module Name: RCA_4bits
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


module RCA_4bits(
    input clk,
    input enable,
    input [3:0] A,
    input [3:0] B,
    input Cin,
    output [4:0] Q, // outputs for reg
    output enable_led 
);

    // temp variables
    wire c1, c2, c3;        
    wire [4:0] sum;

    // 4 full adders
    full_adder FA0 (.A(A[0]), .B(B[0]), .Cin(Cin), .S(sum[0]), .Cout(c1));
    full_adder FA1 (.A(A[1]), .B(B[1]), .Cin(c1),   .S(sum[1]), .Cout(c2));
    full_adder FA2 (.A(A[2]), .B(B[2]), .Cin(c2),   .S(sum[2]), .Cout(c3));
    full_adder FA3 (.A(A[3]), .B(B[3]), .Cin(c3),   .S(sum[3]), .Cout(sum[4])); 

    // for the reg logic
    register_logic REG (
        .clk(clk),
        .enable(enable),
        .Data(sum),
        .Q(Q)
    );

    // turn on led if button pressed
    assign enable_led = enable; 

endmodule
