`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Tel-Aviv University
// Engineer: Dan Waisel and Dan Ram
// 
// Create Date: 08/25/2019 12:39:59 PM
// Design Name: 
// Module Name: shift
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


module shift(
    input C,
    input SI,
    output [21:0] PO
    );
    parameter LENGTH = 22;
    reg [LENGTH-1:0] tmp;
    
    always @(negedge C)
    begin
        tmp = {tmp[LENGTH-2:0],SI};
    end
    assign PO = tmp;
endmodule
