`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/03/28 15:42:58
// Design Name: 
// Module Name: DIV
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

module DIV(
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
    reg [31:0] temp_b;
    integer cnt=0;
       always @ (posedge clock or posedge reset)begin
           if (reset == 1) begin                     //????
            cnt=0;
            busy <= 0;
            
           end 
           else begin
           if(start)
                busy=1;
            if(busy)begin

                temp=0;
                if(divisor[31]==1)
                    temp_b=~(divisor-1);
                else
                    temp_b=divisor;
                if(dividend[31]==1)
                    temp[31:0]=~(dividend-1);
                else
                    temp[31:0]=dividend;
                
                
                  for(cnt=0;cnt<32;cnt=cnt+1)begin
                        temp=temp<<1;
                        if(temp[63:32]>=temp_b)begin
                            temp[63:32]=temp[63:32]-temp_b;
                            temp=temp+1;
                        end
                        
                  end
                  if((dividend[31]==0&&divisor[31]==1))
                  begin
                    q=~temp[31:0]+1;
                    r=temp[63:32];

                  end
                  else if((dividend[31]==1&&divisor[31]==0))
                  begin
                        q=~temp[31:0]+1;
                        r=~temp[63:32]+1;
                  end
                  else if((dividend[31]==1&&divisor[31]==1))
                  begin
                        q=temp[31:0];
                        r=~temp[63:32]+1;
                  end
                  else 
                  begin
                        q=temp[31:0];
                        r=temp[63:32];
                  end
                  
               end   
             
           end
       end
endmodule
