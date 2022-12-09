`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/05 11:32:16
// Design Name: 
// Module Name: RF
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


module RF(
//    input clk,
   input rst,
   input we,//写有效信号write_enable
   input [4:0] raddr1,
   input [4:0] raddr2,
   input [4:0] waddr,
   input [31:0] wdata,
   output[31:0] rdata1,
   output[31:0] rdata2
    );
    reg [31:0] array_reg[31:0]; 
    integer i;
    assign rdata1= (raddr1==0)?0:array_reg[raddr1];
    assign rdata2= (raddr2==0)?0:array_reg[raddr2];
    always @(*) begin
        if (rst)
        begin
            for(i=0;i<32;i=i+1)
                array_reg[i] = 0;
        end
        else
        begin
            if(we && waddr!=0)begin
                array_reg[waddr]=wdata;
            end    
        end
    end
endmodule
