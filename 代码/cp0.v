`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/07/19 17:41:35
// Design Name: 
// Module Name: cp0
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


module cp0(
    input clk,  
    input rst,  
    input ena,
    input mfc0, //读
    input mtc0, //写
    input [31:0]pc,
    input [4:0] cp0_addr,// cp0中的寄存器地址 读写需要 rd
    input [31:0] wdata, 
    input exception,//异常发生信号
    input eret,         
    input [4:0]cause,   
    output [31:0] rdata, 
    output [31:0] status,
    output reg [31:0]exc_addr //异常发生地址
    );
    
    reg [31:0]cp0_reg[31:0];//CP0寄存器
    parameter [4:0]STATUS=12, CAUSE=13, EPC=14;
    parameter Syscall=5'b01000,Break=5'b01001,Teq=5'b01101;
    assign status = cp0_reg[STATUS];             //状态
    assign rdata = mfc0 ? cp0_reg[cp0_addr] : 32'bz;   //读
    always@(posedge ena or posedge rst)begin
    // always@(*)begin
        if(rst)begin
            cp0_reg[STATUS]<=32'h1f;
            cp0_reg[CAUSE]<=32'd0;
            cp0_reg[EPC]<=32'd0;
            exc_addr<=32'd0;
        end
        else if (ena)begin
            if(eret)begin//eret退出中断，status右移5位恢复，
                cp0_reg[STATUS]=cp0_reg[STATUS]>>5;
                // cp0_reg[STATUS]={5'b00000,cp0_reg[STATUS][31:5]};
                exc_addr<=cp0_reg[EPC];
            end
            else if(mtc0)begin//写
                cp0_reg[cp0_addr] = wdata[31:0];
            end
            else if(exception && cp0_reg[STATUS][0])begin//异常信号且没有被屏蔽
                case(cause)
                Syscall:begin
                    if(cp0_reg[STATUS][1]==1'b1)begin
                    exc_addr<=32'h00400004;//异常处理程序开始地址
                    // exc_addr<=32'h4;//异常处理程序开始地址
                    cp0_reg[STATUS]=cp0_reg[STATUS]<<5;
                    cp0_reg[EPC]<=pc;
                    cp0_reg[CAUSE][6:2]<=Syscall;
                    end
                    else
                    exc_addr<=pc+4;
                    
                    end
                Break:begin
                    if(cp0_reg[STATUS][2]==1'b1)begin
                    exc_addr<=32'h00400004;//异常处理程序开始地址
                    // exc_addr<=32'h4;//异常处理程序开始地址
                    cp0_reg[STATUS]=cp0_reg[STATUS]<<5;
                    cp0_reg[EPC]<=pc;
                    cp0_reg[CAUSE][6:2]<=Break;
                    end
                    else
                    exc_addr<=pc+4;
                    
                    end
                Teq:begin
                    if(cp0_reg[STATUS][3]==1'b1)begin
                    exc_addr<=32'h00400004;//异常处理程序开始地址
                    // exc_addr<=32'h4;//异常处理程序开始地址
                    cp0_reg[STATUS]=cp0_reg[STATUS]<<5;
                    cp0_reg[EPC]<=pc;
                    cp0_reg[CAUSE][6:2]<=Teq;
                    end
                    else
                    exc_addr<=pc+4;
                    
                    end
                default:begin
                    // exc_addr<=pc+4;
                end
                endcase
            
            end
            // else
            //      exc_addr<=0;
        end
    end
endmodule
