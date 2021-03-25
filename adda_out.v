/* ------------------------------------------------------------------ 
* brief	: DDS GENERATE HIGE PRECISION WAVE
* data 	: 2021.3.25
* author : SARS_CLASSIFY
* ------------------------------------------------------------------- */ 

`timescale 1ns/1ps
module adda_out(
    input clk,
    output wire [7:0] dacdata,
    output dac_clk,


    input    [3:0] key_in,									//KEY IN PORT


    input                         uart_rx,			//USART
    output                        uart_tx

);


    wire rst_n=key_in[0];									//RESET PORT
    wire [7:0] rom_address;			
    assign dac_clk=clk;										//DAC_CLK OUT PORT

/* ------------------------------------------------------------------ 
* ORIGINAL WAVE
* ------------------------------------------------------------------- */ 

initial
begin

    truefre=60'd85899;										//1000HZ

end

		

/* ------------------------------------------------------------------ 
* KEY STATE SAVE
* ------------------------------------------------------------------- */ 

reg [3:0]   key;					//USE AS REG FOR SAVING THE KEY STATE
wire[3:0]   flag;	
always@(posedge clk or negedge rst_n )
begin
	 if(!rst_n)
	 begin
		 key<=4'b1000;
	 end
    else if(flag==4'b1000)
    begin
		key<=4'b1000;
    end
    else if (flag==4'b0100)
    begin
		key<=4'b0100;
    end
    else if (flag==4'b0010)
    begin
		key<=4'b0010;
    end
end
/* ------------------------------------------------------------------ 
* WAVE RELATED
* ------------------------------------------------------------------- */ 
wire [7:0] rom_data;
wire [7:0] rom_datarec;			//save rec
wire [7:0] rom_datatri;			//save tri
reg [7:0] save_data;				//choose the generated wave
assign dacdata =  save_data;	//get rom data


always @(posedge clk)
begin


    if(key==4'b1000 )
    begin
        save_data<=rom_data;
    end
    else if(key==4'b0100 )
    begin
        save_data<=rom_datarec;
    end
        else if(key==4'b0010 )
    begin
        save_data<=rom_datatri;
    end
end
/* ------------------------------------------------------------------ 
* FREQUENCE CTRL MODULE:USING USATR PART
* COMPUTING FORMULA: fre=2^32*F(the fre you hope to get)*TCLK(T of clk source :20ns)
* ------------------------------------------------------------------- */ 


wire    [7:0]     receive_data;    					//save data received
reg [59:0] truefre;
wire rxflag;												//judge whether the receive process is end



always@(posedge clk or negedge rst_n)
begin
	 if(!rst_n)
	 begin
	    truefre<=60'd85899;								//100HZ
	 end
    else if(rxflag==1'b1)
    begin
        if( receive_data>=8'd48 && receive_data<=8'd57)
        begin
            truefre<=truefre*10+receive_data-8'd48;
        end
        else if(receive_data==8'd115)

        begin
            truefre<=truefre*8589934/100000;		//pay attention to the data overflow
        end

        else

        begin
            truefre<=60'd0;
        end

    end


end
/* ------------------------------------------------------------------ 
* INSTANTIATION PROCESS
* ------------------------------------------------------------------- */ 

addr_ctrl addr_ctrl_inst(
    .clk_50M(clk),
    .rst_n(rst_n),
    .addr(rom_address),
    .freqctrl(truefre[31:0])

);

sin sin_inst(
    .clock(clk),
    .address(rom_address),
    .q(rom_data)

);



rec rec_inst(
    .clock(clk),
    .address(rom_address),
    .q(rom_datarec)


);

tri_x tri_x_inst(
    .clock(clk),
    .address(rom_address),
    .q(rom_datatri)
);

key_test key_test_inst(        //key module instantiation
    .clk(clk),
    .key(key_in),
    .led(flag)
);

uart_test uart_test_inst(
    .clk(clk),
    .rst_n(key_in[0]),
    .uart_rx(uart_rx),
    .uart_tx(uart_tx),
    .receive_data(receive_data),
    .rxflag(rxflag)
);


endmodule