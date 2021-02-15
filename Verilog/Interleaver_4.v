module IntretesatorBloc(clk,Data_In,enable,Secventa_Intretesuta
);

	input            clk;
	input      [7:0] Data_In;
	output reg       enable;
	output reg [7:0] Secventa_Intretesuta;

	reg       state     = 1'b0;
	reg [7:0] r_Data_In = 8'b0;

	always@(posedge clk) begin
		case(state)
			1'b0: begin
				r_Data_In <= Data_In;
				enable    <= 1'b0;
				state     <= 1'b1;
			end
			
			1'b1: begin
				Secventa_Intretesuta <= {r_Data_In[3'd7],r_Data_In[3'd3],r_Data_In[3'd6],r_Data_In[3'd2],r_Data_In[3'd5],r_Data_In[3'd1],r_Data_In[3'd4],r_Data_In[3'd0]};
				enable <= 1'b1;
				if(Data_In != r_Data_In)
					state <= 1'b0;
			end
		endcase
	end
endmodule