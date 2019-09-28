`timescale 1ms / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/26/2019 11:55:04 AM
// Design Name: 
// Module Name: Ps2_Interface_tb
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


module Ps2_Interface_tb();
reg PS2Clk,rstn,PS2Data;
wire [7:0] scancode;
wire keyPressed;
Ps2_Interface uut(PS2Clk,rstn,PS2Data,scancode,keyPressed);

initial begin
    PS2Clk = 1;
    PS2Data = 0;
    rstn = 0;#1;
    #20 rstn = 1; PS2Data = 0; // Start
    #10;
    PS2Data = 1;
    #10;
    PS2Data = 1;
    #10;
    PS2Data = 1;
    #10;
    PS2Data = 0;
    #10;
    PS2Data = 1;
    #10;
    PS2Data = 0;
    #10;
    PS2Data = 0;
    #10;
    PS2Data = 0;
    #10;
    PS2Data = 1; // Parity
    #10;
    PS2Data = 1; // Stop
    #10;
    // Long press, resend packets
    PS2Data = 0; // Start
                #10;
                    PS2Data = 1;
                    #10;
                    PS2Data = 1;
                    #10;
                    PS2Data = 1;
                    #10;
                    PS2Data = 0;
                    #10;
                    PS2Data = 1;
                    #10;
                    PS2Data = 0;
                    #10;
                    PS2Data = 0;
                    #10;
                    PS2Data = 0;
                    #10;
                    PS2Data = 1; // Parity
                    #10;
                    PS2Data = 1; // Stop
                    #10;
   PS2Data = 0; // Start
                                    #10;
                                        PS2Data = 1;
                                        #10;
                                        PS2Data = 1;
                                        #10;
                                        PS2Data = 1;
                                        #10;
                                        PS2Data = 0;
                                        #10;
                                        PS2Data = 1;
                                        #10;
                                        PS2Data = 0;
                                        #10;
                                        PS2Data = 0;
                                        #10;
                                        PS2Data = 0;
                                        #10;
                                        PS2Data = 1; // Parity
                                        #10;
                                        PS2Data = 1; // Stop
                                        #10;
    
    
    
    
    // Realeas:
    PS2Data = 0; // Start
    #10;
        PS2Data = 0;
        #10;
        PS2Data = 0;
        #10;
        PS2Data = 0;
        #10;
        PS2Data = 0;
        #10;
        PS2Data = 1;
        #10;
        PS2Data = 1;
        #10;
        PS2Data = 1;
        #10;
        PS2Data = 1;
        #10;
        PS2Data = 1; // Parity
        #10;
        PS2Data = 1; // Stop
        #10;
    
    PS2Data = 0; // Start
            #10;
                PS2Data = 1;
                #10;
                PS2Data = 1;
                #10;
                PS2Data = 1;
                #10;
                PS2Data = 0;
                #10;
                PS2Data = 1;
                #10;
                PS2Data = 0;
                #10;
                PS2Data = 0;
                #10;
                PS2Data = 0;
                #10;
                PS2Data = 1; // Parity
                #10;
                PS2Data = 1; // Stop
                #10;
    // Another key
    PS2Data = 0; // Start
                    #10;
                        PS2Data = 0;
                        #10;
                        PS2Data = 1;
                        #10;
                        PS2Data = 1;
                        #10;
                        PS2Data = 0;
                        #10;
                        PS2Data = 1;
                        #10;
                        PS2Data = 0;
                        #10;
                        PS2Data = 0;
                        #10;
                        PS2Data = 0;
                        #10;
                        PS2Data = 0; // Parity
                        #10;
                        PS2Data = 1; // Stop
                        #10; 
    // Realeas:
                            PS2Data = 0; // Start
                            #10;
                                PS2Data = 0;
                                #10;
                                PS2Data = 0;
                                #10;
                                PS2Data = 0;
                                #10;
                                PS2Data = 0;
                                #10;
                                PS2Data = 1;
                                #10;
                                PS2Data = 1;
                                #10;
                                PS2Data = 1;
                                #10;
                                PS2Data = 1;
                                #10;
                                PS2Data = 1; // Parity
                                #10;
                                PS2Data = 1; // Stop
                                #10;
        PS2Data = 0; // Start
                                                    #10;
                                                        PS2Data = 0;
                                                        #10;
                                                        PS2Data = 1;
                                                        #10;
                                                        PS2Data = 1;
                                                        #10;
                                                        PS2Data = 0;
                                                        #10;
                                                        PS2Data = 1;
                                                        #10;
                                                        PS2Data = 0;
                                                        #10;
                                                        PS2Data = 0;
                                                        #10;
                                                        PS2Data = 0;
                                                        #10;
                                                        PS2Data = 0; // Parity
                                                        #10;
                                                        PS2Data = 1; // Stop
                                                        #10;
end

always #5 PS2Clk = ~PS2Clk;

endmodule
