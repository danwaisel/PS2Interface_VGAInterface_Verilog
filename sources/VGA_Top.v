`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Dan Waisel and Dan Ram
// 
// Create Date: 09/01/2019 06:27:21 PM
// Design Name: 
// Module Name: VGA_Top
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


module VGA_Top(
clk,
btnC,
vgaRed,
vgaGreen,
vgaBlue,
Hsync,
Vsync,
PS2Data,
PS2Clk,
seg,
an,
dp,
led,
led1,
led2
    );
    
    input wire clk;
    input wire btnC;
    input wire PS2Data;
    input wire PS2Clk;
    output wire [3:0] vgaRed;
    output wire [3:0] vgaGreen;
    output wire [3:0] vgaBlue;
    output wire Hsync;
    output wire Vsync;
    output wire [6:0] seg;
    output wire [3:0] an;
    output wire dp;
    output wire led;
    output wire led1;
    output wire led2;
    
    wire[9:0] XCoord;
    wire[9:0] YCoord;
    wire [11:0] pixel_color;
    wire [7:0] scancode;
    wire keyPressed;
    //Call to VGA_Interface
    VGA_Interface VGA_Int(
        .clk        (clk),
        .rstn       (~btnC),
        .pixel_color (pixel_color),
        .vgaRed     (vgaRed),
        .vgaGreen   (vgaGreen),
        .vgaBlue    (vgaBlue),
        .Hsync      (Hsync),
        .Vsync      (Vsync),
        .XCoord     (XCoord),
        .YCoord     (YCoord)
        );
    //Call to Color Constructor
    
    Ps2_Interface Ps2_Inter( 
        .PS2Clk     (PS2Clk),
        .rstn       (~btnC),
        .PS2Data    (PS2Data),
        .scancode   (scancode),
        .keyPressed (keyPressed)
        );
   
    Color_Constructor Color_Const(
        .clk        (clk),
        .rstn       (~btnC),
        .keyPressed (keyPressed),
        .scancode   (scancode),
        .pixel_color (pixel_color),
        .led1        (led1),
        .led2        (led2)
        );
        
    Ps2_top(clk,btnC,PS2Clk,PS2Data, seg, an, dp, led); 
        
endmodule
