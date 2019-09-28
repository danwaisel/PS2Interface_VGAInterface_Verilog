`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Dan Ram and Dan Waisel
// 
// Create Date: 09/02/2019 01:08:52 PM
// Design Name: 
// Module Name: VGA_Interface_tb
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


module VGA_Interface_tb(

);

    reg clk;
    reg rstn;
    reg [11:0] pixel_color;
    wire [3:0] vgaRed;
    wire [3:0] vgaGreen;
    wire [3:0] vgaBlue;
    wire Hsync;
    wire Vsync;
    wire [9:0] XCoord;
    wire [9:0] YCoord;
    integer i=0;
    VGA_Interface uut(
        clk,
        rstn,
        pixel_color,
        vgaRed,
        vgaGreen,
        vgaBlue,
        Hsync,
        Vsync,
        XCoord,
        YCoord
        );
        
        initial begin
       
            clk<= 1'b0 ; // first initailize registers to zero
            rstn <= 1'b0;
            pixel_color <= 12'b0;
            #10
            rstn <= 1'b1; // turn reset button HIGH
            #10
            for(i=0; i<3360000;i=i+1) begin //we want to count 2 screen frames
                #10
                pixel_color = pixel_color+1'b1;
                end
        end
    always #5 clk <= ~clk; //create clock
 endmodule
