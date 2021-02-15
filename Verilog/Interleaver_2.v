module IntretesatorAleatorGFn(clk,Secventa_Intrare,enable,Secventa_Intretesuta
	);
	
	input clk;
	input [7:0] Secventa_Intrare;
	output reg enable;
	output [7:0] Secventa_Intretesuta;

	//SEED

	reg [3:0] delay0=4'b0000;
	reg [3:0] delay1=4'b0111;
	reg [3:0] delay2=4'b1010;

	//MODULO P

	localparam p=11;

	//COEFCINETII POLINOMULUI PRIMITIV IN GF(P)

	localparam c1=1; //COEF x^3
	localparam c2=1; //COEF x^2
	localparam c3=1; //COEF x^1
	localparam c4=3; //COEF x^0

	assign Secventa_Intretesuta = {Secventa_Intrare[reg_temp[23:21]], Secventa_Intrare[reg_temp[20:18]], Secventa_Intrare[reg_temp[17:15]], Secventa_Intrare[reg_temp[14:12]], Secventa_Intrare[reg_temp[11:9]], Secventa_Intrare[reg_temp[8:6]], Secventa_Intrare[reg_temp[5:3]], Secventa_Intrare[reg_temp[2:0]]};

	reg [23:0] reg_temp           = 24'b0;//Indici intretesere
	reg [2:0]  contor             = 3'b0;
	reg [7:0]  r_Secventa_Intrare = 8'b0;//PENTRU REALUARE ALGORITM DATE DE INTRARE NOI
	reg        state              = 1'b0;
	 
	always @(posedge clk)begin
		case(state)
		1'b0: begin
			enable             <= 1'b0;
			r_Secventa_Intrare <= Secventa_Intrare;

			delay2             <= ((((delay0*c1)%p+(delay1*c2))%p+(delay2*c3))%p*c4)%p;
			delay1             <= delay2;
			delay0             <= delay1;

			if(delay0[2:0] <= 7) begin
				if(delay0[2:0]!=reg_temp[23:21] && delay0[2:0]!=reg_temp[20:18] && delay0[2:0]!=reg_temp[17:15] && delay0[2:0]!=reg_temp[14:12] && delay0[2:0]!=reg_temp[11:9] && delay0[2:0]!=reg_temp[8:6] && delay0[2:0]!=reg_temp[5:3] && delay0[2:0]!=reg_temp[2:0]) begin
						reg_temp[23:0] <= {delay0[2:0], reg_temp[23:3]};
						contor <= contor + 1'b1;
				end
			end
			
			if(contor == 7)begin
				state <= 1'b1;
			end
		end
		
		1'b1: begin
			enable <= 1'b1;
			contor <= 4'b0;
		end
		endcase	

		if(Secventa_Intrare != r_Secventa_Intrare) begin
			contor   <= 4'b0;
			delay0   <= 4'b0000;
			delay1   <= 4'b0111;
			delay2   <= 4'b1010;
			reg_temp <= 24'b0;
			state    <= 1'b0;
		end
	end
endmodule