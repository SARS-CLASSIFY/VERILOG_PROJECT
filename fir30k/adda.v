`timescale 1ns/1ps
module adda(
	input clk,//main clock
	
	output daclk,
	output   [7:0] dadata,//DAdata
	
	output adclk,
	input [7:0] addata //ADdata

);

wire signed [8:0] filterout;
wire signed [8:0] filterin;


wire clk_div;


assign   filterin[7:0]=addata;
assign   dadata=filterout[7:0];



assign daclk=clk;
assign adclk=clk;




filter filter_inst(
	.clk(clk_div),
	.clk_enable(1'b1),
	.reset(1'b0),
	.filter_in(filterin),
	.filter_out(filterout)
);

pll (
	.inclk0(clk),
	.c0(clk_div)
	);




endmodule