`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/06/21 13:20:28
// Design Name: 
// Module Name: topmodule
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

module time_divider #(parameter N=1234)(
    input clk,
    output reg oclk=0
    );
    integer cnt=0;
    always@(posedge clk)
    begin
        if(cnt==N)
//        if(cnt==(N-1)/2)
        begin
            cnt<=0;
            oclk<=~oclk;
        end
        else
            cnt<=cnt+1;
    end
endmodule


module topmodule(
    input clk_in,
    input reset,
    output [7:0] o_seg,
    output [7:0] o_sel
    );

    wire clk_data;
    wire clk_seg;
    wire [31:0]pc;
    wire [31:0]inst;
    time_divider #(10000000) u1(.clk(clk_in),.oclk(clk_data));
//    time_divider #(1) u2(.clk(clk_in),.oclk(clk_seg));
    sccomp_dataflow dataflow(clk_data,reset,inst,pc);
//    sccomp_dataflow dataflow(clk_in,reset,inst,pc);
    seg7x16 seg(clk_in,reset,1'b1,pc,o_seg,o_sel);
//    seg7x16 seg(clk_in,reset,1'b1,inst,o_seg,o_sel);
endmodule

