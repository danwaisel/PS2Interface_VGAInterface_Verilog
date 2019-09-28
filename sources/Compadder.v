`timescale 1ns/10ps
//////////////////////////////////////////////////////////////////////////////////
// Company:         Tel Aviv University
// Engineer:        Dan Ram Dan Waisel
// 
// Create Date:     04/05/2019 08:59:38 PM
// Design Name:     EE3 lab1
// Module Name:     COMPADDER
// Project Name:    Electrical Lab 3, FPGA Experiment #1
// Target Devices:  Xilinx BASYS3 Board, FPGA model XC7A35T-lcpg236C
// Tool Versions:   Vivado 2016.4
// Description:     Variable length binary adder. The parameter N determines
//                  the bit width of the operands. Implemented according to 
//                  Compound-Adder.
// 
// Dependencies:    FA
// 
// Revision:        3.0
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
module Compadder(a, b, s, t);

    parameter N=4;
    localparam K = N >> 1;
    
    input [N-1:0] a;
    input [N-1:0] b;
    output [N:0] s;
    output [N:0] t;
 
    
	
    // FILL HERE
 
    wire [K:0] s1;
    wire [K:0] t1;
    wire [N:K] s2;
    wire [N:K] t2;
    generate
        if (N==1) begin
        FA FA_s(a,b,1'b0,s[0],s[1]);
        FA FA_t(a,b,1'b1,t[0],t[1]);
        end
        else begin
         
            Compadder #(N-K) C_N_K(a[N-1:K], b[N-1:K], s2[N:K], t2[N:K]);
            Compadder #(K) C_K(a[K-1:0], b[K-1:0], s1[K:0], t1[K:0]);
            assign t [K-1:0] = t1[K-1:0];
            assign s [K-1:0] = s1[K-1:0];
          
            assign t [N:K] = (t1[K]) ? t2 : s2;
            assign s [N:K] = (s1[K]) ? t2 : s2;
           
        end
    endgenerate
           
    
endmodule
