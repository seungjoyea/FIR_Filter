`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module TOP_FIR(clk, rst, data_in, data_out);
input clk, rst;
input [15:0] data_in;
output [15:0] data_out;

reg [15:0] data_out;

reg [15:0] xn [31:0]; // 앞의 15:0크기 배열이 16개있음
wire [15:0] yn;
reg [30:0] prod [15:0];
reg [30:0] mac [15:0];                                                                                                                                                                          

parameter FIR_tap = 16;

parameter [15:0] b0 = 16'd0001;
parameter [15:0] b1 = 16'd0002;
parameter [15:0] b2 = 16'd0003;
parameter [15:0] b3 = 16'd0004;
parameter [15:0] b4 = 16'd0005;
parameter [15:0] b5 = 16'd0006;
parameter [15:0] b6 = 16'd0007;
parameter [15:0] b7 = 16'd0008;
parameter [15:0] b8 = 16'd0009;
parameter [15:0] b9 = 16'd0010;
parameter [15:0] b10 = 16'd0011;
parameter [15:0] b11 = 16'd0012;
parameter [15:0] b12 = 16'd0013;
parameter [15:0] b13 = 16'd0014;
parameter [15:0] b14 = 16'd0015;
parameter [15:0] b15 = 16'd0016;

integer i;

always @ (posedge clk)
begin
	if(rst == 1)
		begin
			xn[0] = 0;
			xn[1] = 0;
			xn[2] = 0;
			xn[3] = 0;
			xn[4] = 0;
			xn[5] = 0;
			xn[6] = 0;
			xn[7] = 0;
			xn[8] = 0;
			xn[9] = 0;
			xn[10] = 0;
			xn[11] = 0;
			xn[12] = 0;
			xn[13] = 0;
			xn[14] = 0;
			xn[15] = 0;
			xn[16] = 0;
			xn[17] = 0;
			xn[18] = 0;
			xn[19] = 0;
			xn[20] = 0;
			xn[21] = 0;
			xn[22] = 0;
			xn[23] = 0;
			xn[24] = 0;
			xn[25] = 0;
			xn[26] = 0;
			xn[27] = 0;
			xn[28] = 0;
			xn[29] = 0;
			xn[30] = 0;
			xn[31] = 0;
		end
	else
		begin
			xn[0] <= data_in;
			for(i=0; i<=31; i= i+1)
				begin
					xn[i+1] = xn[i];
				end
		end
end

always @ (posedge clk)
begin
	if(rst == 1)
		begin
			prod[0] = 0;
			prod[1] = 0;
			prod[2] = 0;
			prod[3] = 0;
			prod[4] = 0;
			prod[5] = 0;
			prod[6] = 0;
			prod[7] = 0;
			prod[8] = 0;
			prod[9] = 0;
			prod[10] = 0;
			prod[11] = 0;
			prod[12] = 0;
			prod[13] = 0;
			prod[14] = 0;
			prod[15] = 0;

		end
	else
		begin
			prod[0] <= xn[1] * b15;
			prod[1] <= xn[3] * b14;
			prod[2] <= xn[5] * b13;
			prod[3] <= xn[7] * b12;
			prod[4] <= xn[9] * b11;
			prod[5] <= xn[11] * b10;
			prod[6] <= xn[13] * b9;
			prod[7] <= xn[15] * b8;
			prod[8] <= xn[17] * b7;
			prod[9] <= xn[19] * b6;
			prod[10] <= xn[21] * b5;
			prod[11] <= xn[23] * b4;
			prod[12] <= xn[25] * b3;
			prod[13] <= xn[27] * b2;
			prod[14] <= xn[29] * b1;
			prod[15] <= xn[31] * b0;
		end
end

always @ (posedge clk)
begin
	if(rst==1)
		begin
			mac[0] = 0;
			mac[1] = 0;
			mac[2] = 0;
			mac[3] = 0;
			mac[4] = 0;
			mac[5] = 0;
			mac[6] = 0;
			mac[7] = 0;
			mac[8] = 0;
			mac[9] = 0;
			mac[10] = 0;
			mac[11] = 0;
			mac[12] = 0;
			mac[13] = 0;
			mac[14] = 0;
			mac[15] = 0;
		end
	else
		begin
			mac[0] <= prod[0];
			mac[1] <= mac[0] + prod[1];
			mac[2] <= mac[1] + prod[2];
			mac[3] <= mac[2] + prod[3];
			mac[4] <= mac[3] + prod[4];
			mac[5] <= mac[4] + prod[5];
			mac[6] <= mac[5] + prod[6];
			mac[7] <= mac[6] + prod[7];
			mac[8] <= mac[7] + prod[8];
			mac[9] <= mac[8] + prod[9];
			mac[10] <= mac[9] + prod[10];
			mac[11] <= mac[10] + prod[11];
			mac[12] <= mac[11] + prod[12];
			mac[13] <= mac[12] + prod[13];
			mac[14] <= mac[13] + prod[14];
			mac[15] <= mac[14] + prod[15];
		end
end

assign yn = mac[15];

always @ (posedge clk)
begin
	if(rst == 1)
		begin
			data_out[15:0] = 0;
		end
	else
		begin
			data_out <= yn[15:0];
		end
end

endmodule
