`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/05 21:08:54
// Design Name: 
// Module Name: control_unit
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


module control_unit(
    input clk,
    input rst,
    input z,
    input rsPos,//rs是否非-
    input [53:0]instr,//译码之后的指令
    output reg [1:0]mux1,//0-- || ,1--cp0,2--Z,3--Rs
    output reg [1:0]mux2,//01--ext5,1--rs,2--pc,3--xx
    output reg mux3,//0--ir[10:6],1--rs
    output reg [1:0]mux4,//0--rt,1--ext18,2--ext16,3--4
    output reg [2:0]mux5,//0--Z,1--dmem,2--hi,3--lo,4--cp0
    output reg [1:0]mux6,//0--rd,1--rt,2--31
    output reg mux7,//0--alu,1--clz
    output reg [2:0]mux8,//0--Z,1--cp0,2--div,3--divu,4--mul,5--multu,6--rs//hi
    output reg [2:0]mux9,//0--Z,1--cp0,2--div,3--divu,4--mul,5--multu,6--rs//lo
    output reg [1:0]mux10,//0--lw,1--lh,2--lb
    output reg [1:0]mux11,//0--sw,1--sh,2--sb
    output reg div_start,
    output reg zin,
    output reg zout,
    output reg ir_in,
    output reg [3:0]aluc,
    output reg rf_w,
    output reg dm_we,
    output reg dm_re,
    output reg hi_ena,
    output reg lo_ena,
    output reg decoder_ena,
    output sext,
    output [4:0]cause,
    output reg pc_ena,
    output reg pc_ena2,
    output reg cp0_ena
    );
    reg [2:0]state;
    parameter [4:0]C_SYS = 5'b01000, C_BREAK = 5'b01001, C_TEQ = 5'b01101, C_ERET = 5'b00000;
    assign cause=instr[51]? C_SYS : (instr[53] ? C_BREAK :(instr[52] ? C_TEQ : (instr[50] ?  C_ERET :5'bz)));
    assign sext = instr[17] | instr[18]  | instr[28] | instr[27] | instr[22] | instr[23] | instr[24] | instr[25] | instr[26] | instr[38] | instr[39];
    parameter sif = 3'b000,sid = 3'b001,sexe = 3'b010,smem = 3'b011,swb = 3'b100;
    // assign decoder_ena = (state==sif && !rst)?1:0;
    always@(posedge clk or posedge rst)begin
        if(rst)begin
            state =sif;
            rf_w=0;
            zin=0;
            zout=0;
            div_start=0;
            ir_in=1;
            dm_we=0;
            dm_re=0;
            hi_ena=0;
            lo_ena=0;
            pc_ena=0;
            pc_ena2=1;
            cp0_ena=0;
        end
        else if(state==sif)begin
            //pc取址译码,pc+4
            pc_ena=0;
            pc_ena2=1;
            rf_w=0;
            zout=0;
            div_start=0;
            dm_we=0;
            dm_re=0;//读指令
            hi_ena=0;
            lo_ena=0;
            aluc=4'b0010;
            mux2=2'd2;
            mux4=2'd3;
            zin=1;
            ir_in=1;
            mux7=0;//alu->z
            // mux5=3'bx;
            // zout=1;
            decoder_ena=1;
            cp0_ena=0;
            // if(instr[29]||instr[16])begin
            //     state=swb;
            // end
            // else begin
            //     state=sid;//状态转移
            // end
            state=sid;//状态转移
        end
        else if(state==sid)begin
            //pc+4写回pc,取寄存器地址
            decoder_ena=0;
            rf_w=0;//锁存
            ir_in=0;
            
            pc_ena2=0;
            pc_ena=1;
            
            // zout=1;
            //-----寄存器取址------
            if (instr[30])begin
                mux6=2'd2;
            end
            else if (instr[28:17] || instr[45:37] || instr[50])
                mux6=2'd1;  // I rt[20:16]
            else
                mux6=2'd0;//R rd[15:11]
            //--------------------

            
            
            //-----z->pc------
            zout=1;
            zin=0;
            mux1=2'd2;
            
            //----------------
            
            if(instr[15:0] || instr[28:17] || instr[43:31] || instr[52]||instr[30])begin//4+5
                state=sexe;
            end
            else begin//eret,syscall,break,clz,mf*,mt*//3
                cp0_ena=0;  
                state=swb;//异常地址去写回pc
            end
            
        end
        else if(state==sexe)begin
            //执行指令
            if (!instr[30]&&!instr[36])begin
                zin=1;
                zout=0;     
            end
            
            pc_ena=0;
            //------状态转移------
            if(instr[22] || instr[23] || instr[43:38]||instr[25:24])begin//l*,s*+bne,beq
                state=smem;
            end
            else begin
                state=swb;
            end
            //-------------------
            if(instr[9:0]||instr[25:24]||instr[52])begin//alu运算指令+bne,beq
                mux2=2'd1;//rs
                mux4=2'd0;//rt
                // if(!instr[25:24])//bne,beq不要写进暂存器，只需要看zero
                mux7=0;//alu-->z
            end
            else if(instr[15:10])begin//sll,sra,srl
                if (instr[15:13])begin
                    mux3=1;
                end
                else
                    mux3=0;//sa
                mux2=0;//ext5
                mux4=2'd0;//rt
                mux7=0;//alu-->z
            end
            else if(instr[28:26]||instr[23:17]||instr[43:38])begin//立即数计算指令+l*+s*,
                mux2=2'd1;//rs
                mux4=2'd2;//ext16
                mux7=0;//alu-->z
            end
            else if(instr[30]||instr[36])begin//jal,jalr
                // mux2=2'd2;//pc
                // mux4=2'd3;//4
                // mux7=0;//alu-->z
                zin=0;
                zout=1;
                rf_w=1;
                mux5=0;
            end
            else if(instr[37])begin
                zin=1;
                zout=0;
                mux7=0;//alu-->z
                mux2=2'd2;//pc
                mux4=2'd1;//ext18
            end
            else if(instr[33:32])begin//divu,div
                div_start=1;
            end
            else if(instr[31])begin
                zin=1;
                zout=0;
                mux7=1;//clz-->z
            end
            aluc[3] = instr[8] || instr[9] || instr[10] || instr[11] || instr[12] || instr[13] || instr[14] || instr[15] || instr[26] || instr[27] || instr[28];
            aluc[2] = instr[4] || instr[5] || instr[6] || instr[7] || instr[10] || instr[11] || instr[12] || instr[13] || instr[14] || instr[15] || instr[19] || instr[20] || instr[21];
            aluc[1] = instr[0] || instr[2] || instr[6] || instr[7] || instr[8] || instr[9] || instr[10] || instr[13] || instr[17] || instr[21] || instr[24] || instr[25] || instr[26] || instr[27] || instr[52] ;
            aluc[0] = instr[2] || instr[3] || instr[5] || instr[7] || instr[8] || instr[11] || instr[14] || instr[20] || instr[24] || instr[25] || instr[26] || instr[52];
        end
        else if(state==smem)begin
            //访问存储器+bne,beq
            if(!instr[25:24])begin
                zout=1;//z存储的是访问存储器的地址
                zin=0;
            end
            if(instr[42] || instr[43] || instr[23])begin//s*
                state=sif;
                dm_we=1;//可写
            end
            else if(!instr[25:24])begin//l*
                state=swb;
                mux5=1;
                dm_re=1;//可读
            end
            //--------X->dmem----------
            if(instr[23])begin//sw
                mux11=0;
            end
            else if(instr[43])begin//sh
                mux11=1;
            end
            else if(instr[42])begin//sb
                mux11=2;
            end
            else if(instr[22])begin//lw
                mux10=0;
            end
            else if(instr[38]||instr[41])begin//lh
                mux10=1;
            end
            else if(instr[39]||instr[40])begin//lb
                mux10=2;
            end
            //-----------------------
            //----------------
            if((instr[25] && !z) || (instr[24] && z))begin
                aluc=4'b0010;
                mux2=2'd2;//pc
                mux4=2'd1;//ext18
                zin=1;
                zout=0;
                mux7=0;//alu-->z
                state=swb;
            end
            else if(instr[25:24])begin

                state=sif;
            end

        end
        else if(state==swb)begin
            //结果写回regfiles
            state=sif;
            zout=1;
            zin=0;
            pc_ena2=0;
            // decoder_ena=1;
            // ir_in=1;
            // pc_ena2=1;
            //--------X->pc----------
            if (instr[29] || instr[30])begin//j或jal指令
                //|| ->pc
                mux1=2'd0;
                pc_ena=1;
            end
            else if(instr[16]||instr[36])begin//jr指令
                mux1=2'd3;//rs->pc
                pc_ena=1;
            end
            else if(instr[53:50])begin//eret等异常处理指令
                cp0_ena=1;  
                mux1=2'd1;//cp0->pc
                pc_ena=1;
            end
            else if(instr[25:24]||(instr[37] && rsPos))begin//beq,bne,begz
                mux1=2'd2;//Z->pc
                pc_ena=1;
            end
            //-----------------------

            //--------X->rf----------//0--Z,1--dmem,2--hi,3--lo,4--cp0
            if(instr[15:0]||instr[28:26]||instr[21:17]||instr[31])begin//计算指令+jal+jalr+clz
                //z->rd
                rf_w=1;
                mux5=0;//z->rd
            end
            else if(instr[41:38]||instr[22])begin//l*
                //dmem->rd
                rf_w=1;
                mux5=1;//dmem->rd
                if(instr[22])begin
                    mux10=0;
                end
                else if(instr[41]||instr[38])begin//lh,lhu
                    mux10=1;
                end
                else if(instr[40:39])begin//lb,lbu
                    mux10=2;
                end
            end
            else if(instr[46])begin//mfhi
                rf_w=1;
                mux5=2;//hi->rd
            end
            else if(instr[48])begin//mflo
                rf_w=1;
                mux5=3;//lo->rd
            end
            else if(instr[44])begin//mfc0
                rf_w=1;
                mux5=4;//cp0->rf
            end
            else if(instr[34])begin
                rf_w=1;
                mux5=5;
            end
            //-----------------------

       

            //--------X->hilo----------//0--Z,1--cp0,2--div,3--divu,4--mul,5--multu,6--rs-->hi,6--rs->lo
            if(instr[32])begin//divu
                mux8=3;
                mux9=3;
                hi_ena=1;
                lo_ena=1;
            end
            else if(instr[33])begin//div
                mux8=2;
                mux9=2;
                hi_ena=1;
                lo_ena=1;
            end
            // else if(instr[34])begin//mul
            //     mux8=4;
            //     mux9=4;
            //     hi_ena=1;
            //     lo_ena=1;
            // end
            else if(instr[35])begin//multu
                mux8=5;
                mux9=5;
                hi_ena=1;
                lo_ena=1;
            end
            else if(instr[47])begin//mthi
                mux8=6;
                hi_ena=1;
            end
            else if(instr[49])begin//mtlo
                mux9=6;
                lo_ena=1;
            end
            //div,divu,mul,multu
            //-----------------------

            //--------X->cp0----------
            if(instr[45])begin//mtc0
                
            end
        end
    end
    

endmodule
