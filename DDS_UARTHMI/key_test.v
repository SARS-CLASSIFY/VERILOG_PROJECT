`timescale 1ns / 1ps
module key_test
(
         clk,       //system clock 50Mhz on board
         key,       //input four key signal,when the keydown,the value is 0
        led        //LED display ,when the siganl high,LED lighten
);
 

     input                 clk;      //system clock 50Mhz on board
     input [3:0]           key;      //input four key signal,when the keydown,the value is 0
     output[3:0]           led; 
 


reg[3:0] led_r;           //define the first stage register , generate four D Flip-flop 
reg[3:0] led_r1;          //define the second stage register ,generate four D Flip-flop

always@(posedge clk)
begin
  led_r <= ~key;        //first stage latched data
end

always@(posedge clk)
begin
  led_r1 <= led_r;      //second stage latched data
end

assign led = led_r1;

endmodule 
