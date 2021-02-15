module IntretesatorAleator(clk,Secventa_In,Secventa_Intretesuta,enable
	);

	input        clk;
	input  [7:0] Secventa_In;
	output [7:0] Secventa_Intretesuta;
	output reg   enable;

	reg [3:0]  d       = 4'b1010; //SEED 'd1010
	reg [3:0]  contor   = 4'b0; //CELULE DE INTARZIERE
	reg [3:0]  state    = 4'b0;//FSM
	reg [23:0] indice   = 24'b0;
	reg [7:0]  reg_temp = 8'b0;//PENTRU REALUARE ALGORITM DATE DE INTRARE NOI

	//LFSR Interleaver based method
	assign Secventa_Intretesuta={Secventa_In[indice[23:21]],Secventa_In[indice[20:18]],Secventa_In[indice[17:15]],Secventa_In[indice[14:12]],Secventa_In[indice[11:9]],Secventa_In[indice[8:6]],Secventa_In[indice[5:3]],Secventa_In[indice[2:0]]};

	integer i;

	always @(posedge clk) begin
		d[3] <= d[0] ^ d[1];
		for (i=0; i<=2; i=i+1) begin //POLINOM PRIMITIV GENERATOR= X^4 + X + 1;
			d[i] <= d[i+1];
		end
		
		case (state)
			4'b0000: begin
			reg_temp <= Secventa_In;
				if({d[3],d[2],d[1],d[0]} <= 4'b1000) begin
					indice[23:0] <= {{d[2],d[1],d[0]}, indice[23:3]};
				end
			state  <= 4'b0001;
			contor <= contor + 1'b1;
			end
			
			4'b0001: begin
				if({d[3],d[2],d[1],d[0]} <= 4'b1000)begin
					indice[23:0] <= {{d[2],d[1],d[0]}, indice[23:3]};
				end
			state  <= 4'b0010;
			contor <= contor + 1'b1;
			end
			
			4'b0010: begin
				if({d[3],d[2],d[1],d[0]} <= 4'b1000) begin
					indice[23:0] <= {{d[2],d[1],d[0]}, indice[23:3]};
				end
			state  <= 4'b0011;
			contor <= contor + 1'b1;
			end
			
			4'b0011: begin
				if({d[3],d[2],d[1],d[0]} <= 4'b1000) begin
					indice[23:0] <= {{d[2],d[1],d[0]}, indice[23:3]};
				end
			state  <= 4'b0100;
			contor <= contor + 1'b1;
			end
			
			4'b0100: begin
				if({d[3],d[2],d[1],d[0]} <= 4'b1000) begin
					indice[23:0] <= {{d[2],d[1],d[0]}, indice[23:3]};
				end
			state  <= 4'b0101;
			contor <= contor + 1'b1;
			end
			
			4'b0101: begin
				if({d[3],d[2],d[1],d[0]} <= 4'b1000) begin
					indice[23:0] <= {{d[2],d[1],d[0]}, indice[23:3]};
				end
			state  <= 4'b0110;
			contor <= contor + 1'b1;
			end
			
			4'b0110: begin
				if({d[3],d[2],d[1],d[0]} <= 4'b1000) begin
					indice[23:0] <= {{d[2],d[1],d[0]}, indice[23:3]};
				end
			state<=4'b0111;
			contor<=contor + 1'b1;
			end
			
			4'b0111: begin
				if({d[3],d[2],d[1],d[0]} <= 4'b1000) begin
					indice[23:0] <= {{d[2],d[1],d[0]}, indice[23:3]};
				end
			state  <= 4'b1000;
			contor <= contor + 1'b1;	
			end
			
			4'b1000: begin
				if({d[3],d[2],d[1],d[0]} <= 4'b1000) begin
					indice[23:0] <= {{d[2],d[1],d[0]}, indice[23:3]};
				end
			state  <= 4'b1001;
			contor <= contor + 1'b1;
			end
			
			4'b1001: begin
				if({d[3],d[2],d[1],d[0]} <= 4'b1000) begin
					indice[23:0] <= {{d[2],d[1],d[0]}, indice[23:3]};
				end
			state  <= 4'b1010;
			contor <= contor + 1'b1;	
			end
			
			4'b1010: begin
				if({d[3],d[2],d[1],d[0]} <= 4'b1000) begin
					indice[23:0] <= {{d[2],d[1],d[0]}, indice[23:3]};
				end
			state  <= 4'b1011;
			contor <= contor + 1'b1;	
			end
			
			4'b1011: begin
				if({d[3],d[2],d[1],d[0]} <= 4'b1000) begin
					indice[23:0] <= {{d[2],d[1],d[0]}, indice[23:3]};
				end
			state  <= 4'b1100;
			contor <= contor + 1'b1;
			end
			
			4'b1100: begin
				if({d[3],d[2],d[1],d[0]} <= 4'b1000) begin
					indice[23:0] <= {{d[2],d[1],d[0]}, indice[23:3]};
				end
			state  <= 4'b1101;
			contor <= contor + 1'b1;
			end 
			
			4'b1101: begin
				if({d[3],d[2],d[1],d[0]} <= 4'b1000) begin
					indice[23:0] <= {{d[2],d[1],d[0]}, indice[23:3]};
				end
			state  <= 4'b1110;
			contor <= contor + 1'b1;
			end
			
			4'b1110: begin
				if({d[3],d[2],d[1],d[0]} <= 4'b1000) begin
					indice[23:0] <= {{d[2],d[1],d[0]}, indice[23:3]};
				end
			contor <= contor + 1'b1;
			end
			
			4'b1111: begin //FINAL STATE
				enable<=1'b1;
				contor<=4'b0;
				if(Secventa_In!=reg_temp)begin
					d      <= 4'b1010;
					state  <= 4'b0000;
					enable <= 1'b0;
					indice <= 24'b0;
				end
			end
			endcase
		if(contor == 4'b1110) begin
			state <= 4'b1111;
		end
	end
endmodule
