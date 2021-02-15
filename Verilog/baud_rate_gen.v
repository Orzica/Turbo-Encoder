`timescale 1ns / 1ps
module baud_rate_gen(clk,reset,enable,baud_gen
    );
	 input clk , reset , enable ;
	 output baud_gen ;
	 
	 reg [13:0] count        = 14'b0;
	 reg        bg           = 1'b0;
	 reg [41:0] count_enable = 42'b0;
	 reg        trs_enable   = 1'b0;
	 reg        state        = 1'b0;
	 reg [3:0]  idx          = 4'b0;
	
	 parameter stop_counting  = 1'b0;
	 parameter start_counting = 1'b1;
	 
	 assign baud_gen = bg;
	 assign trs      = trs_enable;
	 
	 always @(posedge clk) begin
		if (reset) begin
			count_enable <= 42'b0;
			trs_enable   <= 1'b0;
			end
		if ( enable == 1'b0 )
			count_enable <= 42'b0;
		else if ( enable == 1'b1 )
			count_enable <= count_enable + 1'b1;
				if ( count_enable == 42'b000000000000000000000000000000000000000001 )//Moment de sondare
					trs_enable <= 1'b1;
				else
					trs_enable <= 1'b0;
	 end
	 
	 always @(posedge clk) begin
		if (reset) begin
			bg    <= 1'b0;
			count <= 14'b0;
			end
		case (state)
		stop_counting : begin
			count <= 14'b0;
			bg    <= 1'b0;
			if ( trs ) 
				state <= start_counting ;
			else
				state <= stop_counting ;
		end
		
		start_counting : begin
			if ( count == 14'b10100010101111 ) begin
					bg    <= 1'b1;
					count <= 14'b0;
						if ( idx == 4'b1001 ) begin
							state <= stop_counting;
							idx   <= 4'b0;
						end else
							idx   <= idx + 1'b1;
			end else begin
				count <= count + 1'b1 ;
				bg    <= 1'b0 ;
				end
		end
		
		default : state <= stop_counting ;
		endcase
		
	 end	
								
endmodule