`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/07/17 11:29:20
// Design Name: 
// Module Name: sccomp_dataflow
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


module sccomp_dataflow(
    input clk_in,
    input reset,
    output [31:0]inst,
    output [31:0]pc
    );
    reg  [31:0] tmp_data_pc;
    wire [31:0] addr;
//    wire [9:0] addr1;
    wire [10:0] addr1;
    wire [31:0]rdata;
    wire [31:0]pc_tmp;
    wire wena;
    wire rena;
    wire [31:0]wdata;
    wire [31:0]addr2;
//    assign addr1 = addr[9:0];
    assign addr2 = addr-32'h10010000;
    assign addr1=addr2[12:2];
    assign pc=tmp_data_pc;
    always @(pc_tmp) begin
            tmp_data_pc=pc_tmp;
    end
    cpu54 sccpu(clk_in,reset,inst,rdata,pc_tmp,addr,wdata,wena,rena);
    dmem dmemory(.clk(clk_in),.wena(wena),.rena(rena),.addr(addr1),.data_in(wdata),.data_out(rdata));
    imem imemory(pc_tmp,inst);
endmodule
