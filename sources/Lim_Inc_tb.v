`timescale 1ns/10ps
//////////////////////////////////////////////////////////////////////////////////
// Company:         Tel Aviv University
// Engineer:        
// 
// Create Date:     05/05/2019 00:16 AM
// Design Name:     EE3 lab1
// Module Name:     Lim_Inc_tb
// Project Name:    Electrical Lab 3, FPGA Experiment #1
// Target Devices:  Xilinx BASYS3 Board, FPGA model XC7A35T-lcpg236C
// Tool Versions:   Vivado 2016.4
// Description:     Limited incrementor test bench
// 
// Dependencies:    Lim_Inc
// 
// Revision:        3.0
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module Lim_Inc_tb();

    reg [3:0] a; 
    reg ci, correct, loop_was_skipped;
    wire [3:0] sum;
    wire co;
    
    integer ai,cii;
    
    // Instantiate the UUT (Unit Under Test)
    
	//FILL HERE
    Lim_Inc uut (a,ci,sum,co);
    initial begin
        correct = 1;
        loop_was_skipped = 1;
        #1
        //FILL HERE
         for (ai=0;ai<2**4;ai=ai+1) begin
                   for (cii=0;cii<=1;cii=cii+1) begin
                       a[3:0] = ai;
                       ci = cii;
                       #5
                       if(a+ci>=10) begin
                           correct = correct &&(sum==0)&&(co==1);
                           end
                       else begin
                           correct = correct &&(sum==ai+cii)&&(co==0);
                           end
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
