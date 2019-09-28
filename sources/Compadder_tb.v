`timescale 1ns/10ps
`define WIDTH 3
//////////////////////////////////////////////////////////////////////////////////
// Company:         Tel Aviv University
// Engineer:        
// 
// Create Date:     04/05/2019 08:59:38 PM
// Design Name:     EE3 lab1
// Module Name:     CSA_tb
// Project Name:    Electrical Lab 3, FPGA Experiment #1
// Target Devices:  Xilinx BASYS3 Board, FPGA model XC7A35T-lcpg236C
// Tool Versions:   Vivado 2016.4
// Description:     Compadder(3) test bench
// 
// Dependencies:    Compadder, FA
// 
// Revision:        3.0
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
module Compadder_tb();

    reg [`WIDTH-1:0] a; 
    reg [`WIDTH-1:0] b;
    reg correct, loop_was_skipped;
    wire [`WIDTH:0] sum;
    wire [`WIDTH:0] tum;
    
    integer ai,bi;
    
    // Instantiate the UUT (Unit Under Test)
    Compadder #(`WIDTH) uut (a, b, sum, tum);
    
    initial begin
        correct = 1;
        loop_was_skipped = 1;
        #1
		
        for( ai=0; ai<2**`WIDTH; ai=ai+1 ) begin
            for( bi=0; bi<2**`WIDTH; bi=bi+1 ) begin

                    // FILL HERE :   a=...   b=....  
		               a = ai[`WIDTH-1:0];
		               
                       b = bi[`WIDTH-1:0]; 
         		    #5 
                    // FILL HERE :  correct = ....
                    
					correct = ((correct) & (a+b+1 == tum)& (a+b==sum));
					
                    loop_was_skipped = 0;
            end
        end
    
	
        if (correct && ~loop_was_skipped)
            $display("Test Passed - %m");
        else
            $display("Test Failed - %m");
        $finish;
    end
endmodule
