`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Tecnológico de Costa Rica
// Engineer: Kaled Alfaro e Irene Rivera
// 
// Create Date:    20:37:25 02/21/2015 
// Design Name: 
// Module Name:    Sistema_prueba 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
/* 
	Este módulo consiste en un comparador de temperatura del cual se le asignan dos 
	temperaturas de referencia: 24°C y 27°C.

	Este detecta cuando la temperatura supera la temperatura de los 24°C para enviar una señal
	de posible alerta.
	En caso de encontrarse una temperatura superior de los 27°C se enviará un mensaje de 
	alerta fuerte.
*/
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////


module Flag_Danger(
		input wire [4:0] Temperatura, 		//Bus de temperatura
		output wire [1:0]Alerta			//Señal de Alerta
    );

//Declaración simbólica de las temperaturas de referencia (referencia 20°C )
localparam [4:0]
	T_Alerta = 5'b00100, 	//24°C
	T_AlertaFuerte = 5'b00111;//27°C

// Declaración por condición de alerta

//Alerta para alarma
assign Alerta[1] = (Temperatura>T_Alerta) ? 1'b1 : 1'b0; //¿Es la temperatura mayor a 24°C?

//Alerta para ventilacion
assign Alerta[0] = (Temperatura>=T_AlertaFuerte) ? 1'b1 : 1'b0; //¿Es la temperatura mayor a 28°C?


endmodule
