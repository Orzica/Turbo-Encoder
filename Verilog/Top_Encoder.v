`timescale 1ns / 1ps

module TopSerial(ok,clk,enable,reset,Rx,Tx,interleaver,led,show_me
    );
	 
	input        clk , reset , Rx , ok , enable;
	input  [1:0] interleaver;
	output       Tx , show_me;
	output [7:0] led ;

	wire [7:0]  w_Date_transmisie;
	wire [23:0] w_Date_emisie;

	//Instantierea modulelor
	TOP T(.clk(clk),.reset(reset),.select_interleaver(interleaver),.Date_In(w_Date_transmisie),.Date_Iesire(w_Date_emisie));

	//UART receptie
	xfda_reciv receptie(.clk(clk),.reset(reset),.data_in_rx(Rx),.text_caracter(w_Date_transmisie),.led(led),.show_me(show_me));

	//UART emisie
	xfda_trans emisie(.ok(ok),.clk(clk),.enable(enable),.reset(reset),.data_in(w_Date_emisie),.Tx(Tx));

endmodule

