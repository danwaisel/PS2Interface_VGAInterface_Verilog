`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Tel-Aviv University
// Engineer: Dan Waisel and Dan Ram
// 
// Create Date: 08/25/2019 05:41:33 PM
// Design Name: 
// Module Name: IDLE_PRESSED_Ctl
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


module IDLE_PRESSED_Ctl(
    input clk,
    input rstn,
    input recv,
    input rel,
    output pressed
    );
    localparam IDLE = 1'b0, PRESSED = 1'b1;
    reg state;
    
    //----- Transition function ------//
    always @(negedge clk)
    begin
            if(rstn==1'b0)
                    state <= IDLE;
            else
                    case(state)
                            IDLE:       if(recv==1'b1)
                                                state <= PRESSED;
                                        else
                                                state <= IDLE;
                            PRESSED:    if(rel==1'b1)
                                                state <= IDLE;
                                        else
                                                state <= PRESSED;
                        
                            default:    state <= IDLE;
                     endcase
                            
    end
    //----- Output function -----//
    assign pressed = (state == PRESSED)? 1'b1:1'b0;
    
    
    
    
    
    
    
endmodule
