`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/05 10:43:47
// Design Name: 
// Module Name: dmem
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


module dmem(
    input clk,//存储器时钟信号，上升沿时向 ram 内部写入数据 
    input wena,//存储器读写有效信号，高电平为写有效，低电平为读有效
    input rena,//存储器读写有效信号，高电平为写有效，低电平为读有效
//	input [9:0] addr, // 输入地址，指定数据读写的地址
	input [10:0] addr, // 输入地址，指定数据读写的地址
	input [31:0] data_in,
	output [31:0] data_out // 存储器读出的数据，ram 工作时持续输出相应地址的数据
    );
//     reg [31:0] data[1023:0];
     reg [31:0] data[1023:0];
//     integer i=0;
//    initial
//     begin
//         for(i=0;i<1024;i=i+1)
////         for(i=0;i<2048;i=i+1)
//         begin
//            data[i]=0;
//         end
//     end
    assign data_out=data[addr%1024];
    always @(*) begin
       if(wena) 
       begin
           data[addr%1024]<=data_in;
       end

    end
endmodule
