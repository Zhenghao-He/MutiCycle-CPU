`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/11/11 19:20:44
// Design Name: 
// Module Name: alu
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


module alu(
	input [31:0]a,
	input [31:0]b,
	input [3:0]aluc,
	output reg [31:0]r,
	output reg zero,
	output reg carry,
	output reg negative,
	output reg overflow

    );
	always @(*) begin
		if(aluc==4'b0000)
		begin
			r=a+b;
			if(r==0)
			begin
				zero=1;
			end
			else
				zero=0;
				//////
			if(r<a||r<b)
				carry=1;
			else
				carry=0;
			////////
			negative=r[31];

		end
		else if(aluc==4'b0010)
		begin
			r=a+b;
			if(r==0)
			begin
				zero=1;
			end
			else
				zero=0;
				//////
	
			////////
			negative=r[31];
			if(a[31]==1'b1&&b[31]==1'b1&&r[31]==1'b0||a[31]==1'b0&&b[31]==1'b0&&r[31]==1'b1)
			begin
				overflow=1;
			end
			else
				overflow=0;
		end
		else if(aluc==4'b0001)
		begin
			r=a-b;
			if(r==0)
			begin
				zero=1;
			end
			else
				zero=0;
				//////
			if(a<b)
				carry=1;
			else
				carry=0;
			////////
			negative=r[31];

		end
		else if(aluc==4'b0011)
		begin
			r=a-b;
			if(r==0)
			begin
				zero=1;
			end
			else
				zero=0;
			negative=r[31];
			if(a[31]==1'b0&&b[31]==1'b1&&r[31]==1'b1||a[31]==1'b1&&b[31]==1'b0&&r[31]==1'b0)
			begin
				overflow=1;
			end
			else
				overflow=0;
		end
		else if(aluc==4'b0100)
		begin
			r=a&b;
			if(r==0)
				zero=1;
			else
				zero=0;
			negative=r[31];

		end
		else if(aluc==4'b0101)
		begin
			r=a|b;
			if(r==0)
				zero=1;
			else
				zero=0;
			negative=r[31];
		end
		else if(aluc==4'b0110)
		begin
			r=~a&b|~b&a;
			if(r==0)
				zero=1;
			else
				zero=0;
			negative=r[31];
		end
		else if(aluc==4'b0111)
		begin
			r=~(a|b);
			if(r==0)
				zero=1;
			else
				zero=0;
			negative=r[31];
		end
		else if(aluc==4'b1001||aluc==4'b1000)
		begin
			r={b[15:0],16'b0};
			if(r==0)
				zero=1;
			else
				zero=0;
			negative=r[31];
		end
		else if(aluc==4'b1011)
		begin
			 if(a[31] == 1'b1 && b[31] == 1'b0) begin
                   r = 32'b1; negative = 1'b1;
                 end else if (a[31] == 1'b0 && b[31] == 1'b1) begin 
                   r = 32'b0; negative = 1'b0;
                 end else begin
                   r = (a < b) ? 32'b1 : 32'b0; negative = (a < b) ? 1'b1 : 1'b0;
                 end
                 zero = (a == b) ? 1'b1 : 1'b0;
                 overflow = 1'b0; carry = 1'b0;
		end
		else if(aluc==4'b1010)
		begin
			 r = (a < b) ? 32'b1 : 32'b0;
                 zero = (a == b) ? 1'b1 : 1'b0;
                 carry = (a < b) ? 1'b1 : 1'b0;
                 negative = r[31] == 1'b1 ? 1'b1 : 1'b0;
                 overflow = 1'b0;
		end
		else if(aluc==4'b1100)
		begin
			 r = ($signed(b)) >>> a;
                 zero = (r == 32'h00000000) ? 1'b1 : 1'b0;
                 negative = r[31] == 1'b1 ? 1'b1 : 1'b0;
                 if(a == 1'b0) carry = 1'b0;
                 else carry = b[a - 1];  // no judegment
                 overflow = 1'b0;
		end
		else if(aluc==4'b1111||aluc==4'b1110)
		begin
			 {carry, r} = b << a;
                 zero = (r == 32'h00000000) ? 1'b1 : 1'b0;
                 negative = r[31] == 1'b1 ? 1'b1 : 1'b0;
                 overflow = 1'b0;
		end
		else if(aluc==4'b1101)
		begin
			    r = b >> a;
              zero = (r == 32'h00000000) ? 1'b1 : 1'b0;
              negative = r[31] == 1'b1 ? 1'b1 : 1'b0;
              if(a == 1'b0) carry = 1'b0;
              else carry = b[a - 1];  // no judegment
              overflow = 1'b0;
		end
		else
		;
	end
endmodule
