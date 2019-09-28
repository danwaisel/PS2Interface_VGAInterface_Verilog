`timescale 1ns/10ps
//////////////////////////////////////////////////////////////////////////////////
// Company:         Tel Aviv University
// Engineer:        Dan Ram Dan Waisel
// 
// Create Date:     04/05/2019 08:59:38 PM
// Design Name:     EE3 lab1
// Module Name:     FA
// Project Name:    Electrical Lab 3, FPGA Experiment #1
// Target Devices:  Xilinx BASYS3 Board, FPGA model XC7A35T-lcpg236C
// Tool Versions:   Vivado 2016.4
// Description:     Well known full adder
// 
// Dependencies:    None
// 
// Revision:        3.0
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
module FA(a, b, ci, sum, co);

  input   a, b, ci;
  output  sum, co;
  
  
  assign sum = a^b^ci;
  assign co= (a&ci)|(b&a)|(b&ci); 
  

endmodule
