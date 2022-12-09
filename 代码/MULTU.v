`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/03/19 18:24:49
// Design Name: 
// Module Name: MULTU
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
/**/

module MULTU(
    input clk,
    input reset,//高电平有效
    input [31:0] a,
    input [31:0] b,
    output reg [63:0] z
    );
    reg [63:0] temp;
    reg [63:0]temp_a;
    reg [31:0] temp_b;
    integer cnt=0;
    always@(posedge clk or posedge reset)
    begin
        if(reset)
        begin 
            temp<=0;
            temp_a<={32'b0,a};//无符号加0
            temp_b<=b;
            cnt<=0;
        end
        else
        begin
        temp<=0;
         temp_a<={32'b0,a};//无符号加0
         temp_b<=b;
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
        end
        z=temp;
    end
   // assign z=temp;
endmodule

/*module MULTU( 
 input clk, // 乘法器时钟信号
 input reset, 
 input [31:0] a, // 输入 a(被乘数) 
 input [31:0] b, // 输入 b(乘数) 
 output [63:0] z // 乘积输出 z 
 ); 
 // 申请寄存器
 reg [63:0] temp; 
 reg [63:0] stored0; 
 reg [63:0] stored1; 
 reg [63:0] stored2; 
 reg [63:0] stored3; 
 reg [63:0] stored4; 
reg [63:0] stored5; 
 reg [63:0] stored6; 
 reg [63:0] stored7; 
reg [63:0] add0_1; 
reg [63:0] add2_3; 
reg [63:0] add4_5; 
reg [63:0] add6_7; 
reg [63:0] add0t1_2t3; 
 reg [63:0] add4t5_6t7; 
 reg [63:0] add0t3_4t7; 
 
 always @(posedge clk or negedge reset) 
 begin 
 temp <= 0; 
 stored0 <= 0; 
 stored1 <= 0; 
 stored2 <= 0; 
 stored3 <= 0; 
 stored4 <= 0; 
 stored5 <= 0; 
 stored6 <= 0; 
stored7 <= 0; 
 add0_1 <= 0; 
 add2_3 <= 0; 
 add4_5 <= 0; 
 add6_7 <= 0; 
 add0t1_2t3 <= 0; 
 add4t5_6t7 <= 0; 
 end 
 else begin 
 //通过字符拼接方式表示出中间相乘值，并相加
 stored0 <= b[0]? {8'b0, a} : 16'b0; 
 stored1 <= b[1]? {7'b0, a, 1'b0} :16'b0; 
 stored2 <= b[2]? {6'b0, a, 2'b0} :16'b0; 
 stored3 <= b[3]? {5'b0, a, 3'b0} :16'b0; 
 stored4 <= b[4]? {4'b0, a, 4'b0} :16'b0; 
 stored5 <= b[5]? {3'b0, a, 5'b0} :16'b0; 
 stored6 <= b[6]? {2'b0, a, 6'b0} :16'b0; 
 stored7 <= b[7]? {1'b0, a, 7'b0} :16'b0; 
 add0_1 <= stored1 + stored0; 
 add2_3 <= stored2 + stored3; 
 add4_5 <= stored4 + stored5; 
 add6_7 <= stored6 + stored7; 
 add0t1_2t3 <= add0_1 + add2_3; 
 add4t5_6t7 <= add4_5 + add6_7; 
 temp <= add0t1_2t3 + add4t5_6t7; 
 end 
 end 
 assign z = temp; 
endmodule*/