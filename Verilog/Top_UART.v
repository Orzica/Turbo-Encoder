module TOP(clk,reset,select_interleaver,Date_In,Date_Iesire
	);
	
	input         clk , reset;
	input  [1:0]  select_interleaver; //LINIE DE SELECTIE INTRETESATOR
	input  [7:0]  Date_In;
	output [23:0] Date_Iesire;

	wire [7:0] CodorConvolutional_Out;//Iesire Codor              --> biti de intrare
	wire [7:0] CodorConvolutional_Intretesator_Out;//Iesire Codor --> biti de intrare intretesuti
	wire [7:0] INTERLEAVER_OUT;//Iesire intretesator

	wire start_bit;//Incepe Codarea convolutionala pentru bitii intretesuti

	//Instatierea modulelor de intretesere cu cele de codoare convolutionale
	CodorConvolutional1 C1(.clk(clk),.reset(reset),.rsc_in(Date_In),.rsc_out(CodorConvolutional_Out));

	INTERLEAVER I(.clk(clk),.Date_Intrare(Date_In),.select_intretesator(select_interleaver),.Intretesator_Out(INTERLEAVER_OUT),.bit_start(start_bit));

	CodorConvolutional2 C2(.clk(clk),.reset(reset),.start(start_bit),.rsc_in(INTERLEAVER_OUT),.rsc_out(CodorConvolutional_Intretesator_Out));
	//.start(start_bit) Incepe Codarea convolutionala pentru bitii intretesuti
	
	assign Date_Iesire = {Date_In[7],CodorConvolutional_Out[7],CodorConvolutional_Intretesator_Out[7],Date_In[6],CodorConvolutional_Out[6],CodorConvolutional_Intretesator_Out[6],Date_In[5],CodorConvolutional_Out[5],CodorConvolutional_Intretesator_Out[5],Date_In[4],CodorConvolutional_Out[4],CodorConvolutional_Intretesator_Out[4],Date_In[3],CodorConvolutional_Out[3],CodorConvolutional_Intretesator_Out[3],Date_In[2],CodorConvolutional_Out[2],CodorConvolutional_Intretesator_Out[2],Date_In[1],CodorConvolutional_Out[1],CodorConvolutional_Intretesator_Out[1],Date_In[0],CodorConvolutional_Out[0],CodorConvolutional_Intretesator_Out[0]};

endmodule