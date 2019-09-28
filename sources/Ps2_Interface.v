`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Tel-Aviv University
// Engineer: Dan Waisel and Dan Ram
// 
// Create Date: 08/24/2019 04:54:40 PM
// Design Name: 
// Module Name: Ps2_Interface
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


module Ps2_Interface(
    input PS2Clk,
    input rstn,
    input PS2Data,
    output [7:0] scancode,
    output keyPressed
    );
    
    reg [7:0] scancode_reg;
    wire [21:0] tmp_out;
    shift InterfaceShift(PS2Clk,PS2Data,tmp_out);
    reg recv,rel;
    wire pressed;
    IDLE_PRESSED_Ctl ctl(PS2Clk,rstn,recv,rel,pressed);
    wire [3:0] time_reading;
    Counter count11(PS2Clk,rstn,time_reading);
    
    
    always@ (negedge PS2Clk)
    begin
        if(time_reading == 4'b1010)
        begin
            // Find key released 0xF0
                    // Parity check and Start==0 check
                    if(^tmp_out[19:11] && tmp_out[20] == 0 && tmp_out[19:12]==8'h0F)
                    begin
                            rel <= 1;
                            recv <= 0;
                    end
            // Find scancode
            // Parity check and Start==0 check
            else if(^tmp_out[8:0] && tmp_out[9]==0 && tmp_out[8:1]!=8'h07 && tmp_out[8:1]!=8'h0F)
            begin
                    scancode_reg <= {tmp_out[1],tmp_out[2],tmp_out[3],tmp_out[4],tmp_out[5],tmp_out[6],tmp_out[7],tmp_out[8]};
                    recv <= 1;
                    rel <= 0;
                
            end
            else
            begin
                recv <= 0;
                rel <= 0;
                scancode_reg <= scancode_reg;
            end
            
        end
    end
    


// Edge Detector: Produce a short pulse at the moment of pressing a key
    reg r0;
    reg r1;
    always@ (negedge PS2Clk)
    begin
        r0 <= pressed;
        r1 <= r0;
    end
    assign keyPressed = r0 && ~r1;
    

    
    assign scancode = scancode_reg;
    
    
endmodule
