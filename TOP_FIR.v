`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module TOP_FIR(clk, rst, data_in, data_out);
input clk, rst;
input [15:0] data_in;
output [15:0] data_out;

reg [15:0] data_out;

reg [15:0] xn [(2*FIR_tap-1):0]; // 앞의 15:0크기 배열이 16개있음
wire [15:0] yn;
reg [30:0] prod [(FIR_tap-1):0];
reg [30:0] mac [(FIR_tap-1):0];
reg [15:0] b[(FIR_tap-1):0];

reg [15:0] coef_count;

reg [15:0] coefficient_addr_in;                                                                                                                                      
wire [15:0] coefficient_out;

parameter FIR_tap = 16;

always @ (posedge clk)
begin
	if(rst == 1)
		begin
		for(i=0; i<=FIR_tap; i=i+1)
			b[i] = 0;
		end
	else
		begin
			b[0] = 16'd0001;
			b[1] = 16'd0002;
			b[2] = 16'd0003;
			b[3] = 16'd0004;
			b[4] = 16'd0005;
			b[5] = 16'd0006;
			b[6] = 16'd0007;
			b[7] = 16'd0008;
			b[8] = 16'd0009;
			b[9] = 16'd0010;
			b[10] = 16'd0011;
			b[11] = 16'd0012;
			b[12] = 16'd0013;
			b[13] = 16'd0014;
			b[14] = 16'd0015;
			b[15] = 16'd0016;
		end
end
		
integer i;

always @ (posedge clk)
begin
	if(rst == 1)
		begin
			for(i=0; i<=(2*FIR_tap-1); i=i+1)
				xn[i] = 0;
		end
	else
		begin
			xn[0] <= data_in;
			for(i=0; i<=(2*FIR_tap-1); i= i+1)
				begin
					xn[i+1] = xn[i];
				end
		end
end

always @ (posedge clk)
begin
	if(rst == 1)
		begin
			for(i=0; i<=(FIR_tap-1); i=i+1)
				prod[i] = 0;
		end
	else
		begin
			prod[0] <= xn[1] * b[15];
			prod[1] <= xn[3] * b[14];
			prod[2] <= xn[5] * b[13];
			prod[3] <= xn[7] * b[12];
			prod[4] <= xn[9] * b[11];
			prod[5] <= xn[11] * b[10];
			prod[6] <= xn[13] * b[9];
			prod[7] <= xn[15] * b[8];
			prod[8] <= xn[17] * b[7];
			prod[9] <= xn[19] * b[6];
			prod[10] <= xn[21] * b[5];
			prod[11] <= xn[23] * b[4];
			prod[12] <= xn[25] * b[3];
			prod[13] <= xn[27] * b[2];
			prod[14] <= xn[29] * b[1];
			prod[15] <= xn[31] * b[0];
		end
end

always @ (posedge clk)
begin
	if(rst==1)
		begin
			for(i=0; i<=(FIR_tap-1); i=i+1)
				mac[i] = 0;
		end
	else
		begin
			mac[0] <= prod[0];
			
			for(i=1; i<=(FIR_tap-1); i=i+1)
				mac[i] <= mac[i-1] + prod[i];
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
