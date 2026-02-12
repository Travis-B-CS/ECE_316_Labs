`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/04/2026 06:56:06 PM
// Design Name: 
// Module Name: multiplexer
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

// Structural
module multiplexer(
    input i0, i1, i2, i3, s0, s1, 
    output d
);

    wire nots0, nots1;
    not int1(nots0, s0);
    not int2(nots1, s1);
    wire temp0, temp1, temp2, temp3;
    and out0 (temp0, nots1, nots0, i0); // 00 = i0
    and out1 (temp1, nots1, s0, i1); // 01 = i1
    and out2 (temp2, s1, nots0, i2); // 10 = i2
    and out3 (temp3, s1, s0, i3); // 11 = i3
    or outf (d, temp0, temp1, temp2, temp3);

endmodule

//// Dataflow
//module multiplexer(
//    input i0, i1, i2, i3, s0, s1, 
//    output d,
//);
//
//    assign d = ((i0 & (~s1) & (~s0)) | (i1 & (~s1) & s0) | (i2 & s1 & (~s0)) | (i3 & s1 & s0));
//    
//endmodule

//// Behavioral
//module decoder(
//    input i0, i1, i2, i3, s0, s1,
//    output reg d // Declare outputs as reg
//);

//always @(*) begin

//    // Default value for all outputs
//    d = 0;

//    // Activate outputs according to the truth table
//    case({a, b, c}) 
//       2'b00: d = i0; 
//       2'b01: d = i1; 
//       2'b10: d = i2; 
//       2'b11: d = i3; 
//       endcase
//end    

//endmodule

