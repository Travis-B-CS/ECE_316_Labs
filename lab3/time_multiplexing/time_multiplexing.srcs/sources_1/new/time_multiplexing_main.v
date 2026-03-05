`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/04/2026 07:28:20 PM
// Design Name: 
// Module Name: time_multiplexing_main
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


module time_multiplexing_main(
    input clk,
    input reset,
    input [15:0] sw,
    output [3:0] an,
    output [6:0] sseg,
    output slow_clk,
    output [7:0] binary_out
    );
    
wire [6:0] in0, in1, in2, in3;
assign binary_out = sw[7:0];

// Module instantiation of hexto7segment decoder
hexto7segment h0 (.x(sw[3:0]), .r(in0));
hexto7segment h1 (.x(sw[7:4]),   .r(in1));
hexto7segment h2 (.x(sw[11:8]),  .r(in2));
hexto7segment h3 (.x(sw[15:12]), .r(in3));

// Module instantiation of clock divider
clkdiv c0(.clk(clk), .reset(reset), .clk_out(slow_clk));

// Module instantiation of the multiplexer FSM
time_mux_state_machine f1_inst( .clk(slow_clk), .reset(reset),
        .in0(in0), .in1(in1), .in2(in2), .in3(in3),
        .an(an), .sseg(sseg));

endmodule