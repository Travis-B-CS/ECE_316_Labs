`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/04/2026 07:10:08 PM
// Design Name: 
// Module Name: tb_multiplexer
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


module tb_multiplexer;

    reg s1, s0, i0, i1, i2, i3;
    wire d;

    // dut: design under test
    multiplexer dut (.s1(s1), .s0(s0), .i0(i0), .i1(i1), .i2(i2), .i3(i3), .d(d)); 

    // test without checker
    initial begin 
        s0 = 0; s1 = 0; i0 = 0; i1 = 1; i2 = 0; i3 = 1;
        #10
        s0 = 1; s1 = 0; i0 = 0; i1 = 1; i2 = 0; i3 = 1;
        #10
        s0 = 0; s1 = 1; i0 = 0; i1 = 1; i2 = 0; i3 = 1;
        #10
        s0 = 1; s1 = 1; i0 = 0; i1 = 1; i2 = 0; i3 = 1;
        #10
        s0 = 0; s1 = 0; i0 = 1; i1 = 0; i2 = 1; i3 = 0;
        #10
        s0 = 1; s1 = 0; i0 = 1; i1 = 0; i2 = 1; i3 = 0;
        #10
        s0 = 0; s1 = 1; i0 = 1; i1 = 0; i2 = 1; i3 = 0;
        #10
        s0 = 1; s1 = 1; i0 = 1; i1 = 0; i2 = 1; i3 = 0;
        #10
        $finish;

    end

endmodule
