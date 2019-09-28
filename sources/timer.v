`timescale 1ns/10ps
//////////////////////////////////////////////////////////////////////////////////
// Company:         Tel Aviv University
// Engineer:        
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
module timer(clk, init_regs, count_enabled, time_reading);

   parameter CLK_FREQ = 100000000;// in Hz
    parameter N_cc = $clog2(CLK_FREQ)-1;
   input clk, init_regs, count_enabled;
   output [7:0] time_reading;

   
   // FILL HERE THE LIMITED-COUNTER INSTANCES
  
     reg [$clog2(CLK_FREQ)-1:0] clk_cnt;
          
      //clk
      reg [N_cc:0] clk_count_in;
      wire [N_cc:0] clk_count_out;
      reg clk_count_ci;
      wire clk_count_co;
      
      //sec
      reg [3:0] ones_seconds;
      wire [3:0] sec_count_out;
      wire sec_count_co;
      
      //10sec
      reg [3:0] tens_seconds; 
      wire [3:0] ten_sec_count_out;
      wire ten_sec_count_co;
          
       Lim_Inc #(CLK_FREQ) cc (clk_count_in, clk_count_ci, clk_count_out, clk_count_co);
       Lim_Inc #(10) sec_counter (ones_seconds, clk_count_co, sec_count_out, sec_count_co); 
       Lim_Inc #(10) ten_sec_counter (tens_seconds, sec_count_co, ten_sec_count_out, ten_sec_count_co); 
        
       
         
    
   //------------- Synchronous ----------------
   always @(posedge clk)
     begin
		// FILL HERE THE ADVANCING OF THE REGISTERS AS A FUNCTION OF init_regs, count_enabled
        if (init_regs) begin
              clk_count_in <= {(N_cc+1){1'b0}};
              ones_seconds <= 4'b0;
              tens_seconds <= 4'b0;
              clk_count_ci <= 1'b0;
        end
           else begin
               if (count_enabled) begin
                 clk_count_ci <= 1'b1;
                 clk_count_in <= clk_count_out;
                 ones_seconds <= sec_count_out;
                 tens_seconds <= ten_sec_count_out;
               end
               else begin
                   clk_count_ci <= 1'b0;
               end
           end
         end
            
        assign time_reading = {ten_sec_count_out, sec_count_out}; 
endmodule
