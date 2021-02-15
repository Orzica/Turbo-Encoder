module IntretesatorRegula(Data_In,clk,enable,Data_Out
);

	input  [7:0] Data_In;
	input        clk;
	output reg   enable;
	output [7:0] Data_Out;

	reg [7:0] delay                = 8'b10101010;//CELULE DE INTARZIERE
	reg [3:0] contor               = 4'b0;
	reg [7:0] registru_intretesere = 8'b0;
	reg [3:0] state                = 4'b0001;//FSM
	reg [7:0] r_Data_In;//REGISTRU PRELUCRARE DATE DE INTRARE
	reg [7:0] reg_temp             = 8'b0;//PENTRU REALUARE ALGORITM DATE DE INTRARE NOI

	localparam initial_state       = 4'b0001;
	localparam final_state         = 4'b1010;

	assign Data_Out = r_Data_In;

	always @(posedge clk) begin
		delay[7] <= delay[4]^delay[3]^delay[2]^delay[0]; //POLINOM PRIMITIV GENERATOR= X^8 + X^4 + X^3 + X^2 + 1;
		delay[6] <= delay[7];
		delay[5] <= delay[6];
		delay[4] <= delay[5];
		delay[3] <= delay[4];
		delay[2] <= delay[3];
		delay[1] <= delay[2];
		delay[0] <= delay[1];
	end

	always @(posedge clk)begin
		case(state)	
			initial_state: begin
			enable   <= 1'b0;
			reg_temp <= Data_In;
				if(contor == 4'b1001) begin //MOMENT DE TIMP ALES 8'b00001001
					registru_intretesere <= {delay[7],delay[6],delay[5],delay[4],delay[3],delay[2],delay[1],delay[0]};
					r_Data_In <= Data_In;
					state <= 4'b0010;
				end else begin
					contor <= contor + 1'b1;
					state  <= initial_state;
				end
			end
			
			4'b0010: begin
				if(registru_intretesere[7] == 1'b1) begin
					r_Data_In[7] <= r_Data_In[6];
					r_Data_In[6] <= r_Data_In[7];
				end
				state <= 4'b0011;
			end
			
			4'b0011: begin
				if(registru_intretesere[6] == 1'b1) begin
					r_Data_In[6] <= r_Data_In[5];
					r_Data_In[5] <= r_Data_In[6];
				end
				state <= 4'b0100;	
			end
			
			4'b0100: begin
				if(registru_intretesere[5] == 1'b1) begin
					r_Data_In[5] <= r_Data_In[4];
					r_Data_In[4] <= r_Data_In[5];
				end
				state <= 4'b0101;
			end
			
			4'b0101: begin
				if(registru_intretesere[4] == 1'b1) begin
					r_Data_In[4] <= r_Data_In[3];
					r_Data_In[3] <= r_Data_In[4];
				end
				state <= 4'b0110;
			end
			
			4'b0110: begin
				if(registru_intretesere[3] == 1'b1) begin
					r_Data_In[3] <= r_Data_In[2];
					r_Data_In[2] <= r_Data_In[3];
				end
				state <= 4'b0111;
			end
			
			4'b0111: begin
				if(registru_intretesere[2] == 1'b1) begin
					r_Data_In[2] <=r_Data_In[1];
					r_Data_In[1] <=r_Data_In[2];
				end
				state <= 4'b1000;
			end
			
			4'b1000: begin
				if(registru_intretesere[1] == 1'b1) begin
					r_Data_In[1] <= r_Data_In[0];
					r_Data_In[0] <= r_Data_In[1];
				end
				state <= 4'b1001;
			end
			
			4'b1001: begin
				if(registru_intretesere[0] == 1'b1) begin
					r_Data_In[0] <= r_Data_In[7];
					r_Data_In[7] <= r_Data_In[0];
				end
				state <= final_state;
			end
			
			final_state: begin
				contor <= 4'b0;
				enable <= 1'b1;
				if(Data_In != reg_temp)begin
					state <= initial_state;
				end
			end
		endcase
	end
endmodule