`timescale 1ns / 1ps

module xfda_reciv(clk,reset,data_in_rx,led,show_me,text_caracter
    );
	input        clk , reset , data_in_rx;
	output       show_me;
	output [7:0] led;
	output [7:0] text_caracter;
	
	parameter [1:0] idle      = 2'b00;
	parameter [1:0] start     = 2'b01;
	parameter [1:0] d_receive = 2'b10;
	parameter [1:0] stop      = 2'b11 ;
	
	reg [1:0] state        = 2'b0;
	reg [9:0] count        = 10'b0;
	reg [3:0] b_gen        = 4'b0;
	reg [7:0] reg_data_rcv = 8'b0;
	reg [2:0] idx          = 3'b0;
	reg [7:0] led_rcvd     = 8'b0;
	reg [7:0] plain_t      = 24'b0; 
	reg [7:0] p_text       = 24'b0;
	reg       show         = 1'b0;
	
	assign led     = led_rcvd;
	assign show_me = show;
	
	assign text_caracter[7:0] = p_text[7:0]; 
	
	always @(posedge clk) begin
		if ( reset ) begin
			state        <= idle;
			count        <= 10'b0;
			b_gen        <= 4'b0;
			reg_data_rcv <= 8'b0;
			led_rcvd     <= 8'b0;
		end else	
			case ( state ) 
			idle : begin
				 count  <= 10'b0;
				 idx    <= 1'b0;
				 if ( ~data_in_rx ) 
					state <= start;
				 else
					state <= idle;
			end
					
			start : begin
					if ( count == 10'b1010001010 ) begin
						count <= 10'b0;
							if ( b_gen == 4'b0111 ) begin
								state <= d_receive;
								b_gen <= 4'b0 ;
							end else begin
								b_gen <= b_gen + 1'b1;	
								state <= start;
									end 
					end else begin 
						count <= count + 1'b1;
						state <= start;
						 end
			end
			
			d_receive : begin
				if ( count == 10'b1010001010 ) begin
					count <= 10'b0;
					if ( b_gen == 4'b1111 ) begin
						b_gen        <= 4'b0;
						reg_data_rcv <= { data_in_rx , reg_data_rcv[7:1] };
						//state <= d_receive ;
						if ( idx == 3'b111 ) begin
							state <= stop;
							count <= 10'b0;
							idx   <= 3'b0;
						end else begin
							idx   <= idx + 1'b1;
							state <= d_receive;end
					end else
						b_gen <= b_gen + 1'b1;
				end else begin
					count <= count + 1'b1;
					state <= d_receive;
						end
			end
			
			stop : begin
				if ( count == 10'b1010001010 ) begin
					count <= 10'b0;
					if ( b_gen == 4'b1111 ) begin
						state        <= idle;
						led_rcvd     <= reg_data_rcv;
						plain_t[7:0] <= reg_data_rcv[7:0];
					end else
						b_gen <= b_gen + 1'b1;
				end else
					count <= count + 1'b1;
			end
			
			default : state <= idle;
		endcase
		
			if ( plain_t[7:0] == 8'b0 )
				show <= 1'b0;
			else begin 
				show        <= 1'b1;
				p_text[7:0] <= plain_t[7:0]; end
	 end

endmodule
