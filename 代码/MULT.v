`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/03/21 11:51:41
// Design Name: 
// Module Name: MULT
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


module MULT(
    input clk, //乘法器时钟信号
    input reset, //复位信号，高电平有效
    input [31:0] a, //输入数 a(被乘数)
    input [31:0] b, //输入数 b（乘数）
    output reg [63:0] z //乘积输出 z
    );
       reg [63:0] temp;
       reg [63:0]temp_a;
       reg [31:0] tempax;
       reg [31:0] temp_b;
       integer cnt=0;
       always@(posedge clk or posedge reset)
       begin
           if(reset)
           begin 
               temp<=0;
                
               cnt<=0;
           end
           else
           begin
               temp<=0;
        
               if(a[31]==0&&b[31]==1)
                   begin
                   temp_a<={32'b11111111111111111111111111111111,b};
                   temp_b<=a;
                   end
               else if(a[31]==0&&b[31]==0)
                   begin
                   temp_a<={32'b0,a};
                    temp_b<=b;
                   end
              else if(a[31]==1&&b[31]==1)
                  begin
                  tempax=~(a-1);
                  temp_b=~(b-1);
                  temp_a<={32'b0,tempax};
                  end
              else
                  begin
                  temp_a<={32'b11111111111111111111111111111111,a};
                  temp_b<=b;
                  end
             
          
            cnt<=0;
              for(cnt=0;cnt<32;cnt=cnt+1)
               begin
                  
                   if(temp_b[0])
                   begin
                       temp=temp+temp_a;
                   end
                   else
                   begin
                   end
                   temp_b=temp_b>>1;
                   temp_a=temp_a << 1;
               end
           z=temp;
           end
       end
      // assign z=temp;
   endmodule