`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/04/2026 05:30:02 PM
// Design Name: 
// Module Name: tb_rising_edge_detector
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


module tb_rising_edge_detector();
    reg clk;
    reg signal;
    reg reset;
    wire outedge;

    rising_edge_detector dut (.clk(clk), .signal(signal), .reset(reset),
        .outedge(outedge));

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        signal = 0;
        reset = 1;
        
        #100; //This is delay to reset everything
        
        reset = 0; //Set reset back to low
        #50;

        signal = 1; //Signal high -> should go to high state then wait for low state
        #100; 

        signal = 0; //Signal low -> should go from wait for low to initial state
        #100;

        signal = 1; //Signal high -> should go to high state then wait for low state
        #100;
        
        signal = 0; //Signal low -> should go from wait for low to initial state
        #100;

    end

endmodule
