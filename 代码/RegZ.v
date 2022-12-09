`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/07/19 20:09:14
// Design Name: 
// Module Name: RegZ
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


module RegZ(
    input rst,
    input zin,
    input zout,
    input[31:0] wdata,
    output[31:0]rdata
    );
    reg [31:0]data;
    always@(*)
        if(rst)
            data=32'b0;
        else if(zin)
            data=wdata;
    assign rdata=zout?data:32'bz;
endmodule
