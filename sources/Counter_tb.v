`timescale 1 ns / 1 ns
//////////////////////////////////////////////////////////////////////////////////
// Company:         Tel Aviv University
// Engineer:        
// 
// Create Date:     00:00:00  AM 05/05/2019 
// Design Name:     EE3 lab1
// Module Name:     Counter_tb
// Project Name:    Electrical Lab 3, FPGA Experiment #1
// Target Devices:  Xilinx BASYS3 Board, FPGA model XC7A35T-lcpg236C
// Tool versions:   Vivado 2016.4
// Description:     test bench for Counter module
// Dependencies:    Counter
//
// Revision:        3.0
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module Counter_tb();

    reg clk, rstn, correct, loop_was_skipped;
    wire [3:0] time_reading;
    //wire [3:0] tens_seconds_wire;
    wire [3:0] ones_seconds_wire;
    integer ts,os,sync;
    
    // Instantiate the UUT (Unit Under Test)
    // TODO
    Counter uut(clk, rstn, time_reading);
    
   //assign tens_seconds_wire = time_reading[7:4];
      assign ones_seconds_wire = time_reading[3:0];
      
      initial begin 
          #1
          sync = 0;
      //   count_sample = 0;
        //  show_sample = 0;
          correct = 1;
          loop_was_skipped = 1;
          clk = 1;
          rstn = 0;
          
          #20
          rstn = 1;
                  
          // Remember that every 1000000 clocks are 10 milliseconds
          
          for( ts=0; ts<1; ts=ts+1 ) begin // not more than 1*10 seconds check
              for( os=0; os<2; os=os+1 ) begin // not more than 2*1 seconds check
                              #(99999999+sync) // FILL HERE THE "correct" signal MAINTENANCE
                              correct = correct & (time_reading[0]==~os); 
                              sync = sync | 1;
                              loop_was_skipped = 0;
  
             end
          end
          
          #5
          if (correct && ~loop_was_skipped)
              $display("Test Passed - %m");
          else
              $display("Test Failed - %m");
          $finish;
      end
      
      always #5 clk = ~clk;
  endmodule

