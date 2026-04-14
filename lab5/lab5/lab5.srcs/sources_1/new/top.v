`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/14/2026 03:13:03 PM
// Design Name: 
// Module Name: top
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




module top(
    input clk,          
    input btn_ss,       
    input btn_rst,      
    input [9:0] sw,     // 10 switches total
    output [3:0] an,    
    output [6:0] seg,   
    output dp           
);

    // internal wires
    wire clk_10ms_en;
    wire ss_debounced;
    wire rst_debounced;
    
    // Wires for Mode outputs
    wire [3:0] m0_sec_tens, m0_sec_ones, m0_ms_hundreds, m0_ms_tens;
    wire [3:0] m1_sec_tens, m1_sec_ones, m1_ms_hundreds, m1_ms_tens;
    wire [3:0] m2_sec_tens, m2_sec_ones, m2_ms_hundreds, m2_ms_tens;
    wire [3:0] m3_sec_tens, m3_sec_ones, m3_ms_hundreds, m3_ms_tens;

    // 10ms clk pulse
    clkdiv pulse_gen (
        .clk(clk),
        .reset(1'b0),            
        .clk_10ms(clk_10ms_en)
    );

    // edge detectors
    rising_edge_detector ss_detector (
        .clk(clk), 
        .signal(btn_ss),
        .reset(1'b0),            
        .outedge(ss_debounced)
    );
    
    rising_edge_detector rst_detector (
        .clk(clk), 
        .signal(btn_rst),
        .reset(1'b0),           
        .outedge(rst_debounced)
    );

    // Mode 0: Stopwatch Up
    mode0 stopwatch_inst (
        .clk(clk), .RST(rst_debounced), .SS(ss_debounced), .clk_10ms(clk_10ms_en),
        .sec_tens(m0_sec_tens), .sec_ones(m0_sec_ones), .ms_hundreds(m0_ms_hundreds), .ms_tens(m0_ms_tens)
    );

    // Mode 1: Timer Down (99.99)
    mode1 timer_inst (
        .clk(clk), .RST(rst_debounced), .SS(ss_debounced), .clk_10ms(clk_10ms_en),
        .sec_tens(m1_sec_tens), .sec_ones(m1_sec_ones), .ms_hundreds(m1_ms_hundreds), .ms_tens(m1_ms_tens)
    );

    // Mode 2: Stopwatch Up (Custom Start)
    mode2 custom_stopwatch_inst (
        .clk(clk), .RST(rst_debounced), .SS(ss_debounced), .clk_10ms(clk_10ms_en),
        .load_sec_tens(sw[9:6]), .load_sec_ones(sw[5:2]),
        .sec_tens(m2_sec_tens), .sec_ones(m2_sec_ones), .ms_hundreds(m2_ms_hundreds), .ms_tens(m2_ms_tens)
    );

    // NEW: Mode 3: Timer Down (Custom Start)
    mode3 custom_timer_inst (
        .clk(clk), .RST(rst_debounced), .SS(ss_debounced), .clk_10ms(clk_10ms_en),
        .load_sec_tens(sw[9:6]), .load_sec_ones(sw[5:2]),
        .sec_tens(m3_sec_tens), .sec_ones(m3_sec_ones), .ms_hundreds(m3_ms_hundreds), .ms_tens(m3_ms_tens)
    );

    // Multiplexer to choose which mode goes to the display
    reg [3:0] disp_sec_tens;
    reg [3:0] disp_sec_ones;
    reg [3:0] disp_ms_hundreds;
    reg [3:0] disp_ms_tens;

    always @(*) begin
        case(sw[1:0]) 
            2'b00: begin // Mode 0
                disp_sec_tens = m0_sec_tens; disp_sec_ones = m0_sec_ones; 
                disp_ms_hundreds = m0_ms_hundreds; disp_ms_tens = m0_ms_tens;
            end
            2'b01: begin // Mode 1
                disp_sec_tens = m1_sec_tens; disp_sec_ones = m1_sec_ones; 
                disp_ms_hundreds = m1_ms_hundreds; disp_ms_tens = m1_ms_tens;
            end
            2'b10: begin // Mode 2
                disp_sec_tens = m2_sec_tens; disp_sec_ones = m2_sec_ones; 
                disp_ms_hundreds = m2_ms_hundreds; disp_ms_tens = m2_ms_tens;
            end
            2'b11: begin // NEW: Mode 3
                disp_sec_tens = m3_sec_tens; disp_sec_ones = m3_sec_ones; 
                disp_ms_hundreds = m3_ms_hundreds; disp_ms_tens = m3_ms_tens;
            end
            default: begin // Default to Mode 0
                disp_sec_tens = m0_sec_tens; disp_sec_ones = m0_sec_ones; 
                disp_ms_hundreds = m0_ms_hundreds; disp_ms_tens = m0_ms_tens;
            end
        endcase
    end

    // seven segment display 
    seven_segment_mux display_inst (
        .clk(clk),
        .reset(rst_debounced), 
        .sec_tens(disp_sec_tens),       
        .sec_ones(disp_sec_ones),       
        .ms_hundreds(disp_ms_hundreds), 
        .ms_tens(disp_ms_tens),         
        .an(an),
        .sseg(seg),
        .dp(dp)
    );

endmodule