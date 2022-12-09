`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/05 15:48:30
// Design Name: 
// Module Name: EXT
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


module EXT #(parameter WIDTH=16)(
    input [WIDTH-1:0] numb,
	input isSign,//1有符号、0无符号
	//input ena,//高有效
	output [31:0] res
);
    reg [31:0]tmp=32'b0;
    assign res=tmp;
    integer i;
    always@(*)
    begin
        if(isSign)
        begin
            for(i=31;i>=WIDTH;i=i-1)
                tmp[i] = numb[WIDTH-1];
            tmp[WIDTH-1:0]=numb[WIDTH-1:0];
        end
        else
        begin
            for(i=31;i>=WIDTH;i=i-1)
                tmp[i] = 0;
            tmp[WIDTH-1:0]=numb[WIDTH-1:0];
        end
    end
endmodule
