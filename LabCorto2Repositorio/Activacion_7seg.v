`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Tecnológico de Costa Rica
// Engineer: Kaled Alfaro e Irene Rivera
// 
// Create Date:    09:44:40 02/27/2015 
// Design Name: 
// Module Name:    Activacion_7seg 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//      	Módulo encargado de activar el display de 7 segmentos y mostrar el mensaje designado
//		para alarma y ventilación.
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module Activacion_7seg(
	//Señales del sistema de salida
	input wire Ventilacion,
	input wire Alarma,
	//Señal para mostrar en display
	output wire [6:0] Activacion
    );
//Declaracion de la letra a mostrar en 7segmentos
localparam [6:0]
	A = 7'b0001000,
	V = 7'b1000001;	

//Se muestra el ventilacion, sino la alarma, sino nada.
assign Activacion = Ventilacion ? V : Alarma ? A : 7'hff;

endmodule
