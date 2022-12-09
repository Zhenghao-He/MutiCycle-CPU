`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/07/19 19:58:06
// Design Name: 
// Module Name: HILO
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


module HILO(
    input wena,
    input rst,
    input[31:0] wdata,
    output[31:0]rdata
    );
    reg [31:0]data;
    always@(*)
        if(rst)
            data<=32'b0;
        else if(wena)
            data<=wdata;
    assign rdata=data;
endmodule
