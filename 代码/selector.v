`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/05 18:47:40
// Design Name: 
// Module Name: selector
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


module mux # (parameter WIDTH=32)(
    input [WIDTH-1:0]a,
    input [WIDTH-1:0]b,
    input choose,
    output reg [WIDTH-1:0]res
    
    );
    always@(*)
    begin
        case(choose)
            1'b0: res=a;
            1'b1: res=b;
        endcase
    end
    
endmodule

module mux4 # (parameter WIDTH=32)(
    input [WIDTH-1:0]a,
    input [WIDTH-1:0]b,
    input [WIDTH-1:0]c,
    input [WIDTH-1:0]d,
    input [1:0]choose,
    output reg [WIDTH-1:0]res
    
    );
    always@(*)
    begin
        case(choose)
            2'd0: res=a;
            2'd1: res=b;
            2'd2: res=c;
            2'd3: res=d;
        endcase
    end
    
endmodule

module mux8 # (parameter WIDTH=32)(
    input [WIDTH-1:0]a,
    input [WIDTH-1:0]b,
    input [WIDTH-1:0]c,
    input [WIDTH-1:0]d,
    input [WIDTH-1:0]e,
    input [WIDTH-1:0]f,
    input [WIDTH-1:0]g,
    input [WIDTH-1:0]h,
    input [2:0]choose,
    output reg [WIDTH-1:0]res
    
    );
    always@(*)
    begin
        case(choose)
            3'd0: res=a;
            3'd1: res=b;
            3'd2: res=c;
            3'd3: res=d;
            3'd4: res=e;
            3'd5: res=f;
            3'd6: res=g;
            3'd7: res=h;
        endcase
    end
    
endmodule