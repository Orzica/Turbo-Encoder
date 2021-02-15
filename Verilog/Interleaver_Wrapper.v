module INTERLEAVER(clk,Date_Intrare,select_intretesator,Intretesator_Out,bit_start
	);

	input        clk;
	input  [7:0] Date_Intrare;
	input  [1:0] select_intretesator; //LINIE DE SELECTIE INTRETESATOR
	output [7:0] Intretesator_Out;
	output       bit_start; //Incepe Codarea convolutionala pentru bitii intretesuti
		 
	wire [7:0] IntretesatorAleator_Out; //select_intretesator=2'b01;
	wire [7:0] IntretesatorAleatorGFn_Out; //select_intretesator=2'b00;
	wire [7:0] IntretesatorBloc_Out; //select_intretesator=2'b11;
	wire [7:0] IntretesatorRegula_Out; //select_intretesator=2'b10;

	wire enable_Aleator;
	wire enable_GFn;
	wire enable_Bloc;
	wire enable_Regula;

	//Instantierea modulelor
	IntretesatorAleator I1(.clk(clk),.Secventa_In(Date_Intrare),.enable(enable_Aleator),.Secventa_Intretesuta(IntretesatorAleator_Out));

	IntretesatorAleatorGFn I2(.clk(clk),.Secventa_Intrare(Date_Intrare),.enable(enable_GFn),.Secventa_Intretesuta(IntretesatorAleatorGFn_Out));

	IntretesatorBloc I3(.clk(clk),.Data_In(Date_Intrare),.enable(enable_Bloc),.Secventa_Intretesuta(IntretesatorBloc_Out));

	IntretesatorRegula I4(.clk(clk),.Data_In(Date_Intrare),.enable(enable_Regula),.Data_Out(IntretesatorRegula_Out));

	//MUX 4-1 pentru selectarea tipului de intretesator dorit
	assign bit_start=select_intretesator[1] ? (select_intretesator[0] ? enable_Bloc : enable_Regula) : (select_intretesator[0] ? enable_Aleator : enable_GFn);
	
	//Iesirea Top-INTERLEAVER --> Bitii intretesuti dupa medtoda dorita
	assign Intretesator_Out=select_intretesator[1] ? (select_intretesator[0] ? IntretesatorBloc_Out : IntretesatorRegula_Out) : (select_intretesator[0] ? IntretesatorAleator_Out : IntretesatorAleatorGFn_Out);

endmodule