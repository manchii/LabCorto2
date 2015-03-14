`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Tecnológico de Costa Rica
// Engineer: Kaled Alfaro e Irene Rivera
// 
// Create Date:    21:58:44 02/21/2015 
// Design Name: 
// Module Name:    LogicaDeActivacion 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
/*
	Este módulo consiste en una lógica combinacional del cual se describe a partir de
	la siguente tabla de verdad:
	Ignicion		Presencia		AlertaFuerte		AlertaDebil	|| Alarma		Ventilacion
	0			0			X			X		|| 0			0
	0			1			0			0		|| 0			0
	0			1			0			1		|| 1			0
	0			1			1			X		|| 1			1
	1			X			X			X		|| 0			0
*/
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////


module LogicaDeActivacion(
	input wire [1:0] Alerta, //Señal obtenida de la generacion de bandera de alerta 
	input wire rst,clk,	//Clock y reset
	input wire Presencia,	//Presencia sincronizada
	input wire Ignicion,	//Ignicion sincronizada
	input wire Activar_Decidir,	//Permite el registro de los valores logicos de las salidas
	output reg Alarma,		//Activa la alarma
	output reg Ventilacion,		//Activa el sistema de ventilación
	output wire Peligro    		//Señal de control
);
//Señales auxiliares para cambiar de estado
wire alarma_siguiente,ventilacion_siguiente;

//Declaración simbólica de las salidas de activación

localparam
	Encendido = 1'b1,
	Apagado = 1'b0;



//Descripción del Proceso:
assign alarma_siguiente  = 	Ignicion 	? Apagado : //Apagar en caso de haber ignición /
				~Presencia 	? Apagado : //Apagar si no hay presencia /	
				Alerta[1]	? Encendido : Apagado; //Encender si hay alerta debil /
	
assign ventilacion_siguiente = Ignicion	? Apagado : //Apagar en caso de haber ignición /
				~Presencia	? Apagado : //Apagar si no hay presencia /
				Alerta[0]	? Encendido : Apagado; //Encender si hay alerta fuerte /

//Comportamiento
always@(posedge clk, posedge rst)
begin
	if(rst)
	begin
		Alarma <= Apagado;
		Ventilacion <= Apagado;
	end		
	else
	begin
		if(Activar_Decidir)
		begin 
			Alarma <= alarma_siguiente;
			Ventilacion <= ventilacion_siguiente;
		end
	end
end

//Asignación de las Aviso de Peligro

assign Peligro = alarma_siguiente | ventilacion_siguiente; //Señal de Control

endmodule
