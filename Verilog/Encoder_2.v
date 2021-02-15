module CodorConvolutional2(clk,start,reset,rsc_in,rsc_out
);

	input      clk , start , reset;
	input      [Width-1 : 0] rsc_in;
	output reg [Width-1 : 0] rsc_out;

	parameter Width = 8; //LATIMEA VECTORULUI
	
	//States generica name 
	localparam initial_state = 3'b000;
	localparam state0        = 3'b001;
	localparam state1        = 3'b010;
	localparam state2        = 3'b011;
	localparam state3        = 3'b100;
	localparam final_state   = 3'b101;

	reg [Width-1:0] reg_temp = 8'b0;//REGISTRU AJUTOR
	reg [Width-1:0] r_rsc_in = 8'b0;//REGISTRU AJUTOR FSM
	reg [2:0]       contor   = 3'b0;//CONTOR pentru a opri FSM-ul
	reg [2:0]       state    = 3'b000;//FSM no. of states


	always@(posedge clk) begin
		if(reset) begin
			state    <=initial_state;
			contor   <= 4'b0;
			r_rsc_in <= 8'b0;
			reg_temp <= 8'b0;
			rsc_out  <= 8'b0;
		end 
		if(start==1) begin
			case(state)
				initial_state: begin //STARE INITIALA->INCARCARE REGISTRII
						r_rsc_in <= rsc_in;
						reg_temp <= rsc_in;
						state    <= state0;
						contor   <= 4'b0;
				end
					
				state0: begin
						if(r_rsc_in[Width - 1] == 1'b0) begin
							rsc_out    <= rsc_out << 1;
							rsc_out[0] <= 1'b0;
							state      <= state0;
						end else
							if(r_rsc_in[Width - 1] == 1'b1) begin
								rsc_out    <= rsc_out << 1;
								rsc_out[0] <=1'b1;
								state      <= state1;
							end
					r_rsc_in <= r_rsc_in << 1;
					contor   <= contor + 1'b1;
				end
					
				state1: begin
						if(r_rsc_in[Width - 1] == 1'b0) begin
							rsc_out    <= rsc_out << 1;
							rsc_out[0] <= 1'b1;
							state      <= state3;
						end else
							if(r_rsc_in[Width - 1] == 1'b1) begin
								rsc_out    <= rsc_out << 1;
								rsc_out[0] <= 1'b0;
								state      <= state2;
							end
					r_rsc_in <= r_rsc_in << 1;
					contor   <= contor + 1'b1;
				end
					
				state2: begin
						if(r_rsc_in[Width - 1] == 1'b0) begin
							rsc_out    <= rsc_out << 1;
							rsc_out[0] <= 1'b0;
							state      <= state1;
						end else
							if(r_rsc_in[Width - 1] == 1'b1) begin
								rsc_out    <= rsc_out << 1;
								rsc_out[0] <= 1'b1;
								state      <= state0;
							end
					r_rsc_in <= r_rsc_in << 1;
					contor   <= contor + 1'b1;
				end
					
				state3: begin
						if(r_rsc_in[Width - 1] == 1'b0) begin
							rsc_out    <= rsc_out << 1;
							rsc_out[0] <= 1'b1;
							state      <= state2;
						end else
							if(r_rsc_in[Width - 1] == 1'b1) begin
								rsc_out    <= rsc_out << 1;
								rsc_out[0] <= 1'b0;
								state      <= state3;
							end
					r_rsc_in <= r_rsc_in << 1;
					contor   <= contor + 1'b1;
				end
					
				final_state: begin //STAREA FINALA
					contor <= 3'b0;
						if(rsc_in != reg_temp) begin
							state <= initial_state;
						end
				end
			endcase
			
				if(contor == Width - 1) begin
					state<=final_state;
				end
		end
		if(start == 0)begin
			state <= initial_state;
		end
	end//END ALWAYS
endmodule