`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Dan Waisel and Dan Ram
// 
// Create Date: 09/01/2019 06:27:21 PM
// Design Name: 
// Module Name: VGA_Interface
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


module VGA_Interface(
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

    input  wire        clk;
    input  wire        rstn;
    input  wire [11:0] pixel_color;
    output reg        Hsync;  //Hsync is HIGH, low pulse when line scan is over
    output reg        Vsync;  ////Hsync is HIGH, low pulse when screen scan is over
    output reg  [3:0] vgaRed;
    output reg  [3:0] vgaGreen;
    output reg  [3:0] vgaBlue;
    output reg  [9:0] XCoord;
    output reg  [9:0] YCoord;
    
    
    
   
    reg clk_50; // 50MHz clk out of 100MHz clk
    reg clk_25; // 25MHz clk out of 100MHz clk
    reg [9:0] horiz_counter; // counts rows
    reg [9:0] vert_counter; // counts lines
    reg inside_screen;
    reg counter;
    wire pixel_clk;
   



   
    always @(posedge clk or negedge rstn)begin //50MHz CLK initiates accoding to clk posedge or negedge of reset button
        if (~rstn)
            clk_50 <= 1'b0;
        else
            clk_50 = ~clk_50;
    end
   
    always @(posedge clk_50 or negedge rstn)begin //25MHz CLK
        if (~rstn)
            clk_25 <= 1'b0;
        else
            clk_25 = ~clk_25;
    end
    
    assign pixel_clk = clk_25; // vga's CLK   

    //generating Hsync, Vsync
    always @(posedge pixel_clk or negedge rstn)begin
    
        if (~rstn) begin //when reset low is HIGH, we initiate. 
            horiz_counter <= 10'b0; //10 on 10 matrix
            vert_counter <= 10'b0;
        end else if (horiz_counter == 10'd799) begin // if we go over 799 in horizon
                horiz_counter <= 10'b0; //we reinitiate to zero
                if (vert_counter == 10'd524)  
                    vert_counter <= 10'b0; //same with vertical limit
                else
                    vert_counter <= vert_counter + 1'b1; //if we did not cross any limit, vertical counter +1
        end else
        begin
            horiz_counter <= horiz_counter +1'b1; // if we did not cross any limit horizontaly, horizontal counter ++
            end
         //inside_screen <= ((horiz_counter < 10'd640) && (vert_counter < 10'd480)) ? 1'b0 : 1'b1; // if we satisfy 640x480 condition, return 1.    
    end
    always@(posedge clk)
    begin
        if(((horiz_counter < 10'd640) && (vert_counter < 10'd480)))
        begin
            inside_screen <= 1;
        end
        else
        begin
            inside_screen <= 0;
        end
    end
   // inside_screen = ((horiz_counter < 10'd640) && (vert_counter < 10'd480)) ? 1 : 0; // if we satisfy 640x480 condition, return 1. 
    
    //on rising edge, we check if we are in frame and assign values accordingly
    always @(posedge clk) begin
        if (inside_screen) begin // if we are in frame registers are equal the relevant component of pixel_color array
        
            vgaRed[3:0]   <= pixel_color[3 :0];
            vgaGreen[3:0] <= pixel_color[7 :4];
            vgaBlue[3:0]  <= pixel_color[11:8];
        end else begin // if we are out of frame, assign all zeroes to vgaColor
            vgaRed[3:0]   <= 4'h0;
            vgaGreen[3:0] <= 4'h0;
            vgaBlue[3:0]  <= 4'h0;
//              vgaRed[3:0]   = ~pixel_color[3 :0];
//                      vgaGreen[3:0] = ~pixel_color[7 :4];
//                      vgaBlue[3:0]  = ~pixel_color[11:8];
        end
    end
    
    // on rising edge we assign Xcoord and Ycoord to the relevant horizontal and vertical counters
    always @(posedge clk) begin
        XCoord = horiz_counter;
        YCoord = vert_counter;
    end
    
    //on rising edge, if horizontal counter is higher than 648 and lower than 758, we shall assign 0 to Hsync ( not in sync ) otherwise we shall as 1 ( in sync) 
    always @(posedge clk) begin
        if (horiz_counter > 10'd658 & horiz_counter < 10'd756) //according to experimental data, hsync pulse is between 658 and 756
            Hsync = 1'b0;
        else
            Hsync= 1'b1;
    end
    
    // on  rising edge, if vertical counter is higher than 492, and lower than 495 we are not in vertical sync, otherwise we are ( '1' )
    always @(posedge clk) begin
        if (vert_counter > 10'd492 & vert_counter < 10'd495) //according to experimental background, vsync pulse is between 492 and 495
            Vsync = 1'b0;
        else
            Vsync = 1'b1;
    end 
endmodule

