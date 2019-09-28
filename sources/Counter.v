`timescale 1ns/10ps
//////////////////////////////////////////////////////////////////////////////////
// Company:         Tel Aviv University
// Engineer:        Dan Waisel and Dan Ram
// 
// Create Date:     05/05/2019 00:19 AM
// Design Name:     EE3 lab1
// Module Name:     Counter
// Project Name:    Electrical Lab 3, FPGA Experiment #1
// Target Devices:  Xilinx BASYS3 Board, FPGA model XC7A35T-lcpg236C
// Tool versions:   Vivado 2016.4
// Description:     a counter that advances its reading as long as time_reading 
//                  signal is high and zeroes its reading upon init_regs=1 input.
//                  the time_reading output represents: 
//                  {dekaseconds,seconds}
// Dependencies:    Lim_Inc
//
// Revision         3.0
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module Counter(clk, rstn, time_reading);

  
   input clk, rstn;
   output [3:0] time_reading;

   
   // FILL HERE THE LIMITED-COUNTER INSTANCES
  
     
      parameter MAX_CYCLE = 11;   
      //clk
      reg clk_count_co;
      
      //sec
      reg [3:0] ones_seconds;
      wire [3:0] sec_count_out;
      wire sec_count_co;
      
      //10sec
      //reg [3:0] tens_seconds; 
      //wire [3:0] ten_sec_count_out;
      //wire ten_sec_count_co;
          
       
       Lim_Inc #(MAX_CYCLE) sec_counter (ones_seconds, clk_count_co, sec_count_out, sec_count_co); 
       //Lim_Inc #(10) ten_sec_counter (tens_seconds, sec_count_co, ten_sec_count_out, ten_sec_count_co); 
        
       
         
    
   //------------- Synchronous ----------------
   always @(negedge clk)
     begin
		// FILL HERE THE ADVANCING OF THE REGISTERS AS A FUNCTION OF init_regs, count_enabled
        if (rstn==1'b0) begin
              clk_count_co <= 1'b0;
              ones_seconds <= 4'b0;
              //tens_seconds <= 4'b0;
        end
           else begin
                 clk_count_co <= 1'b1;
                 ones_seconds <= sec_count_out;
                 //tens_seconds <= ten_sec_count_out;
           end
     end
            
        assign time_reading = sec_count_out; 
endmodule
