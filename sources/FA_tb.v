`timescale 1ns/10ps
//////////////////////////////////////////////////////////////////////////////////
// Company:         Tel Aviv University
// Engineer:        Dan Ram Dan Waisel
// 
// Create Date:     04/05/2019 08:59:38 PM
// Design Name:     EE3 lab1
// Module Name:     FA_tb
// Project Name:    Electrical Lab 3, FPGA Experiment #1
// Target Devices:  Xilinx BASYS3 Board, FPGA model XC7A35T-lcpg236C
// Tool Versions:   Vivado 2016.4
// Description:     test bench for FA module - no changes required
// 
// Dependencies:    None
// 
// Revision:        3.0
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
module FA_tb();

    reg a, b, ci, correct, loop_was_skipped;
    wire sum, co;
    integer ai,bi,cii;
    
    // Instantiate the UUT (Unit Under Test)
    FA uut (a, b, ci, sum, co);
    
    initial begin
        correct = 1;
        loop_was_skipped = 1;
        #1
        for( ai=0; ai<=1; ai=ai+1 ) begin
            for( bi=0; bi<=1; bi=bi+1 ) begin
                for( cii=0; cii<=1; cii=cii+1 ) begin
                    a = ai[0]; b = bi[0]; ci = cii[0];
                    #5 correct = correct & (a + b + ci == {co,sum});
                    loop_was_skipped = 0;
                end
            end
        end
    
        if (correct && ~loop_was_skipped)
            $display("Test Passed - %m");
        else
            $display("Test Failed - %m");
        $finish;
    end
endmodule
