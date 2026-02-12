`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/12/2026 10:29:38 AM
// Design Name: 
// Module Name: tb_bcd_to_7seg
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


module tb_bcd_to_7seg;

    // inputs and outputs
    reg [3:0] switch;
    wire [6:0] seg;
    wire [3:0] an;

    bcd_to_7seg dut (.switch(switch), .seg(seg),.an(an)); 

    // test
    initial begin 

        switch = 4'b0000;
        #10;
        switch = 4'b0001;
        #10;
        switch = 4'b0010;
        #10;
        switch = 4'b0011;
        #10;
        switch = 4'b0100;
        #10;
        switch = 4'b0101;
        #10;
        switch = 4'b0110;
        #10;
        switch = 4'b0111;
        #10;
        switch = 4'b1000;
        #10;
        switch = 4'b1001;
        #10;
        switch = 4'b1010;
        #10;
        switch = 4'b1011;
        #10;
        switch = 4'b1100; 
        #10;
        switch = 4'b1101;
        #10;
        switch = 4'b1110;
        #10;
        switch = 4'b1111;
        #10;
   
        $finish;
    end

endmodule