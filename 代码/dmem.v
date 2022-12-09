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
    input clk,//�洢��ʱ���źţ�������ʱ�� ram �ڲ�д������ 
    input wena,//�洢����д��Ч�źţ��ߵ�ƽΪд��Ч���͵�ƽΪ����Ч
    input rena,//�洢����д��Ч�źţ��ߵ�ƽΪд��Ч���͵�ƽΪ����Ч
//	input [9:0] addr, // �����ַ��ָ�����ݶ�д�ĵ�ַ
	input [10:0] addr, // �����ַ��ָ�����ݶ�д�ĵ�ַ
	input [31:0] data_in,
	output [31:0] data_out // �洢�����������ݣ�ram ����ʱ���������Ӧ��ַ������
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
