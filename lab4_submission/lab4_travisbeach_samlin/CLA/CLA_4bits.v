`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/24/2026 04:11:46 PM
// Design Name: 
// Module Name: CLA_4bits
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


module CLA_4bits(
    input clk,
    input enable,
    input [3:0] A,
    input [3:0] B,
    input Cin,
    output [4:0] Q, //load registers, should contain the 4 num bits
    output enable_led
);

    wire [3:0] G, P, S; //Generate, Propagate, Sum
    wire [4:0] C; //Carry
    wire [3:0] Sum;
    wire Cout;
    assign C[0] = Cin;
    
    assign P = A ^ B; // propagate
    assign G = A & B; // generate
    
    //carry bits
    assign C[1] = G[0] | (P[0] & C[0]);
    assign C[2] = G[1] | (P[1] & G[0]) | (P[1] & P[0] & C[0]);
    assign C[3] = G[2] | (P[2] & G[1]) | (P[2] & P[1] & G[0]) | (P[2] & P[1] & P[0] & C[0]);
    assign C[4] = G[3] | (P[3] & G[2]) | (P[3] & P[2] & G[1]) | (P[3] & P[2] & P[1] & G[0]) | (P[3] & P[2] & P[1] & P[0] & C[0]);

    //sum is propagate xor with carry
    assign Sum = P ^ C[3:0]; 
    assign Cout = C[4];

    //reg logic
    register_logic reg_inst (
        .clk(clk),
        .enable(enable),
        .Data({Cout, Sum}), // combine cout and sum
        .Q(Q)
    );

    //turn led on when switch for enable is pressed
    assign enable_led = enable;
    
endmodule
