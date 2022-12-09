`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/03/28 08:39:53
// Design Name: 
// Module Name: DIVU
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
module DIVU(
    input [31:0] dividend,
    input [31:0] divisor,
    input start,
    input clock,
    input reset,
    output  reg [31:0]q,
    output  reg [31:0]r,
    output reg busy
);
    reg [63:0] temp;
    integer cnt=0;
       always @ (posedge clock or posedge reset)begin
           if (reset == 1) begin                     //ÖØÖÃ
            cnt=0;
            busy <= 0;
            temp=0;
            temp[31:0]=dividend;
            
           end 
           else begin
           if(start)
                busy=1;
            if(busy)begin
                temp=0;
                    temp[31:0]=dividend;
                  for(cnt=0;cnt<32;cnt=cnt+1)begin
                        temp=temp<<1;
                        if(temp[63:32]>=divisor)begin
                            temp[63:32]=temp[63:32]-divisor;
                            temp=temp+1;
                        end
                        
                  end
                  q=temp[31:0];
                  r=temp[63:32];
               end   
             
           end
       end
endmodule


