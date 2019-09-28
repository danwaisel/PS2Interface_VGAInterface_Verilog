`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Tel-Aviv University
// Engineer: Dan Waisel and Dan Ram
// 
// Create Date: 08/27/2019 04:16:59 PM
// Design Name: 
// Module Name: Ps2_top
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


module Ps2_top(
    input clk,
    input reset,
    input PS2Clk,
    input PS2Data,
    output [6:0] seg,
    output [3:0] an,
    output dp,
    output led
    );
    wire keyPressed;
    reg keyPressed_reg;
    wire [7:0] scancode;
    
    Ps2_Interface ps2i(PS2Clk,~reset,PS2Data,scancode,keyPressed);
    Seg_7_Display ps2d(clk,~reset,keyPressed_reg,scancode,seg,an,dp,led);
    
    
    always@(posedge clk)
    begin
        keyPressed_reg <= keyPressed;
    end
endmodule
