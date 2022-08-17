`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module TOP_FIR(clk, rst, data_in, data_out);
input clk, rst;
input [15:0] data_in;
output [15:0] data_out;

reg [15:0] data_out;

reg [15:0] xn [6:0]; // 앞의 15:0크기 배열이 16개있음
wire [15:0] yn;
reg [30:0] prod [2:0];
reg [30:0] mac [2:0];

parameter [15:0] b0 = 16'h0001;
parameter [15:0] b1 = 16'h0002;
parameter [15:0] b2 = 16'h0003;

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
		end
	else
		begin
			xn[0] <= data_in;
			for(i=0; i<=5; i= i+1)
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

		end
	else
		begin
			prod[0] <= xn[0] * b2;
			prod[1] <= xn[2] * b1;
			prod[2] <= xn[4] * b0;
		end
end

always @ (posedge clk)
begin
	if(rst==1)
		begin
			mac[0] = 0;
			mac[1] = 0;
			mac[2] = 0;

		end
	else
		begin
			mac[0] <= prod[0];
			mac[1] <= mac[0] + prod[1];
			mac[2] <= mac[1] + prod[2];
		end
end

assign yn = mac[2];

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
