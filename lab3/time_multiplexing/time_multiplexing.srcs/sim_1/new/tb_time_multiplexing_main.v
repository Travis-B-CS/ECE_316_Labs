`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/04/2026 07:42:51 PM
// Design Name: 
// Module Name: tb_time_multiplexing_main
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

module tb_time_multiplexing_main();
    reg clk;
    reg reset;
    reg [15:0] sw;
    
    wire [3:0] an;
    wire [6:0] sseg;
    wire slow_clk;
    wire [7:0] binary_out;

    time_multiplexing_main dut (.clk(clk), .reset(reset), .sw(sw), .an(an), .sseg(sseg),
        .slow_clk(slow_clk), .binary_out(binary_out));

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        reset = 1;
        sw = 16'h0000;
        #100; //forcing reset
        
        reset = 0; //reset reset val
        
        sw = 16'h4321; //test 4321
        #400; // need long delay to cycle through all since clk is now 40ns

        sw = 16'hABCD; //test ABCD
        #400;

        sw = 16'h9876; //test 9876
        #400;

        sw = 16'hE5F0; //test something random I felt like
        #400;

        sw = 16'hFFFF; //test straight Fs
        #400;
        
        sw = 16'h0000; //test straight 0s
        #400;

        $finish;
    end

endmodule