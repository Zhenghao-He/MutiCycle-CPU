`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/07/20 19:31:53
// Design Name: 
// Module Name: clz
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


module clz(
    input [31:0] num,
    output reg [31:0] result=0
    );
    integer i=31;
    always @(*) begin
        result=0;
        for(i=31;!num[i]&&i>=0;i=i-1)begin
             result=result+1;
        end
    end
    
endmodule
