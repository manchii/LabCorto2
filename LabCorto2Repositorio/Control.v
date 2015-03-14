`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Tecnológico de Costa Rica
// Engineer: Kaled Alfaro e Irene Rivera
// 
// Create Date:    20:37:25 02/21/2015 
// Design Name: 
// Module Name:    Control 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//		Módulo de la máquina de estados encargada de leer los datos de temperatura y definir 
//		si el infante se encuentra en peligro
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////

module Control(
	input wire Dato_listo, //Variable de salto condicional	
	input wire Peligro,	//Variable de salto condicional
	input wire rst,clk,	//Reset y Clock
	output reg Activar_Decidir, //Habilitación para guardar cambios en los registros de salida.
	output wire [1:0] Estados  // Salida para mostrar el estado del circuito a otro modulo
);

//Declaracion simbolica de los estados de la maquina
localparam [1:0]
	leer = 2'b01,
	decidir = 2'b10, 
	alerta = 2'b11;

//Registros de estado
reg [1:0] estado_actual, estado_siguiente;

//Comportamiento ante cada clock de la maquina
always@(posedge clk,posedge rst)
	
	if(rst)
		estado_actual <= leer;
	else
		estado_actual <= estado_siguiente;


//Comportamiento de los cambios y salidas de la maquina de estados finita
always@*
begin
	estado_siguiente=estado_actual;	//no cambia de estado
	Activar_Decidir=1'b0;		//no se registra un cambio para la salida
	case(estado_actual)
		leer:		//Si Aparece un dato se va al estado de decision
		begin
			if(Dato_listo) 
				estado_siguiente=decidir;
		end
		
		decidir:	
		//Si habilita la decision y si no se encuentra peligro regresa a esperar otro dato.
		//En caso de haber peligro se va al estado de alerta.
		begin
			Activar_Decidir=1'b1;
			if(Peligro)
				estado_siguiente=alerta;
			else
				estado_siguiente=leer;
		end
		
		alerta:
		//Se queda en estado de alerta hasta recibir otro dato para decidir.
		begin
			if(Dato_listo)
				estado_siguiente=decidir;
		end		
		default: estado_siguiente=leer;
	endcase
	
end
//Asigancion de la salida de Estadas tomada de la maquina de estados.
assign Estados = estado_actual;

endmodule
