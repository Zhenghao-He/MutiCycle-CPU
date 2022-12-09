`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/05 12:06:41
// Design Name: 
// Module Name: pc
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


module pc1(
    // input clk,
    input rst,
    input we,
    input [31:0]data_in,
    output reg [31:0] data_out

    );
//    reg [31:0]data;
//    assign data_out=data;
    always @ (*) begin
        if(rst)
            data_out <= 32'h00400000;
        else if(we)
            data_out = data_in;
    end
endmodule
