`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Dan Waisel and Dan Ram
// 
// Create Date: 09/01/2019 06:27:21 PM
// Design Name: 
// Module Name: Color_Constructor
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


module Color_Constructor(
clk,
rstn,
keyPressed,
scancode,
pixel_color,
led1,
led2
    );


  input  wire        clk;
  input  wire        rstn;
  input  wire        keyPressed;
  input wire [7:0]    scancode;
  
  output reg led1;
  output reg led2;
  output reg [11:0] pixel_color;
  
  
  reg [11:0] color_barrel;
  reg [3:0] color_num;
  
  reg r0;
  reg r1;
  wire keyPressedDer;
  // Edge Detector
  always @(posedge clk)begin
        r0 <= keyPressed;
        r1 <= r0;
  end
  assign keyPressedDer = r1 && ~r0;
  
//  always @(posedge clk)begin //this is working
//    if (~rstn) //we want durring reset button to reset the color barrel and display a white screen
//    begin
//        //led1=1'b1;
//        color_barrel <=12'h000; //initialize color_barrel to zeroes 
//        pixel_color <= 12'hFFF;  // create blank screen
//    end
   
//  end
   
  
    always @ (posedge clk)begin //if key is pressed, we now have a scancode, and we know which key was pressed, thus we dictate a decimal value to each scancode
         if (~rstn) //we want durring reset button to reset the color barrel and display a white screen
       begin
           //led1=1'b1;
           color_barrel <=12'h000; //initialize color_barrel to zeroes 
           pixel_color <= 12'hFFF;  // create blank screen
       end
        if (keyPressedDer == 1'b1)begin
            led2 <=1'b0;
            led1 <=1'b0;
            case(scancode) //according to keyboard mapping of background
                8'h70: color_num = 4'd0; // scaling accordingly
                8'h69: color_num = 4'd2;
                8'h72: color_num = 4'd4;
                8'h7A: color_num = 4'd6;
                8'h6B: color_num = 4'd8; 
                8'h73: color_num = 4'd10; 
                8'h74: color_num = 4'd12; 
                8'h6C: color_num = 4'd14; 
                8'h75: color_num = 4'd15;
               // 8'h5A: color_num = 4'd1;
                default: color_num = 4'd0;
            endcase
            if (scancode == 8'h5A)
                       begin // if enter was pressed
                             led1 <= 1'b1;
                             //led2 <= 1'b1;
                             pixel_color <=color_barrel; //the pixel_color output is the above concactanation
                             color_barrel <= 12'h000; // assign color_barrel to white screen
                       end
            else //if enter was not pressed concat array
                        begin
                        led2<=1'b1;
                        color_barrel <= {color_barrel[7:0], color_num}; //the following concatanation is assigned
                        end
       end
        
  end

    
//    always @(posedge clk)begin
        
//        if (scancode == 8'h5A)
//           begin // if enter was pressed
//                 pixel_color <=color_barrel; //the pixel_color output is the above concactanation
//                 color_barrel <= 12'h000; // assign color_barrel to white screen
//           end
//        else //if enter was not pressed concat array
//            color_barrel <= {color_barrel[7:0], color_num}; //the following concatanation is assigned
         
//    end
endmodule
 

  