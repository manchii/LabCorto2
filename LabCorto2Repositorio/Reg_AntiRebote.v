`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Tecnológico de Costa Rica
// Engineer: Kaled Alfaro e Irene Rivera
// 
// Create Date:    13:23:33 02/27/2015 
// Design Name: 
// Module Name:    Reg_AntiRebote 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//		Éste módulo consiste en ser el encargado de eliminar los errores producidos por el rebote de las placas metálica
//		que componen los switches. Estos rebotes crean pequeños cambios de voltaje que el módulo de leer el cambio, los i
//		interpreta como cambios reales y voluntarios, causando resultados indeseados.
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////

module Reg_AntiRebote(
	input wire clk, rst,	//Clock y reset
	input wire Switch,            //Señal de entrada asincronica
	output reg Dato_Sincronizado, Dato_listo //Señal sincronizada y  aviso a control
    );
	 
//declaracion simbolico de los estados
localparam [1:0]
	Cero = 2'b00,
	Espera_a_0 = 2'b01,
	Uno = 2'b10,
	Espera_a_1 = 2'b11;

//numero de conteo de bits (2^N*20ns = 40ms)
//Se espera a que se encuentre estable la señal de entrada a 40ms
localparam N=21;
   
   
//declaracion de señales
	reg [1:0] estado_actual, estado_siguiente;
	reg [N-1:0] Cuenta_actual;
	wire [N-1:0] Cuenta_siguiente;
	wire Fin_Cuenta; //Aviso de fin de cuenta de 40ms
	reg Dato_listo_siguiente; //señal auxiliar para dar aviso

assign Cuenta_siguiente = Cuenta_actual + 1'b1; //Comportamiento de la cuenta
assign Fin_Cuenta = (Cuenta_actual==0) ? 1'b1 : 1'b0; //Si la cuenta actual termina, es fin de cuenta

//Comportamiento ante los francos del clock y reset
always @ (posedge clk, posedge rst)
begin
	if (rst) 
	begin
		//Maquina de estado
		estado_actual <= Cero;
		//Aviso de dato
		Dato_listo  <= 0;
		//Cuenta
		Cuenta_actual <= 0;
	end
	else
	begin
		//Maquina de estado
		estado_actual <= estado_siguiente;
		//Aviso de dato
		Dato_listo  <= Dato_listo_siguiente;
		//Cuenta
		Cuenta_actual <= Cuenta_siguiente;
	end
end

//Comportamiento de la maquina de estados
always @*
begin
	//Casos por default
	estado_siguiente = estado_actual;
	Dato_Sincronizado = 1'b0;
	Dato_listo_siguiente = 1'b0;

//Empieza case
	case (estado_actual)
	
	Cero:
	//La salida es 0 logico, se espera a un cambio logico en la entrada
	begin
		if (Switch)
		begin
			estado_siguiente = Espera_a_1;
		end
	end
        
	Espera_a_1:
	//Se hace una cuenta de 40ms hasta que la señal de entrada se estabilice
	//Caso contrario, se regresa a Cero.
	begin
		if (~Switch)
			estado_siguiente = Cero;
		else
			if (Fin_Cuenta)
				estado_siguiente = Uno;
				//Se prepara el aviso
				Dato_listo_siguiente = 1'b1;
	end
        
	Uno:
	//La salida es 1 logico, se espera a un cambio logico en la entrada
	begin
		Dato_Sincronizado = 1'b1;
		if (~Switch)
		begin
			estado_siguiente = Espera_a_0;
		end
	end

	Espera_a_0:
	//Se hace una cuenta de 40ms hasta que la señal de entrada se estabilice
	//Caso contrario, se regresa a Uno.
	begin
		if (Switch)
			estado_siguiente = Uno;
		else
			if (Fin_Cuenta)
				estado_siguiente = Cero;
				//Se prepara el aviso
				Dato_listo_siguiente = 1'b1;
	end   
	endcase
end

endmodule
