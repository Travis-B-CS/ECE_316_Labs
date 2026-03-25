`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/24/2026 03:42:47 PM
// Design Name: 
// Module Name: tb_RCA_4bits
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


module tb_RCA_4bits;

    reg clk;
    reg enable;
    reg [3:0] A;
    reg [3:0] B;
    reg Cin;

    wire [4:0] Q;
    wire enable_led;

    RCA_4bits dut (.clk(clk), .enable(enable), .A(A), .B(B), .Cin(Cin),
        .Q(Q), .enable_led(enable_led));

    //make clk
    always #5 clk = ~clk;

    initial begin
        clk = 0;
        enable = 0;
        A = 0;
        B = 0;
        Cin = 0;

        // reset time/init time
        #20;
        
        //want enable always on 
        enable = 1;

        
        A = 4'b0001; B = 4'b0101; Cin = 1'b0;
        #20;
        
        A = 4'b0111; B = 4'b0111; Cin = 1'b0;
        #20;
        
        A = 4'b1000; B = 4'b0111; Cin = 1'b1;
        #20;

        A = 4'b1100; B = 4'b0100; Cin = 1'b0;
        #20;

        A = 4'b1000; B = 4'b1000; Cin = 1'b1;
        #20;

        A = 4'b1001; B = 4'b1010; Cin = 1'b1;
        #20;

        A = 4'b1111; B = 4'b1111; Cin = 1'b0;
        #20;

        $finish;
    end
endmodule