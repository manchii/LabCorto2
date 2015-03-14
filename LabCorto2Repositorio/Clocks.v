`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Tecnológico de Costa Rica
// Engineer: Kaled Alfaro e Irene Rivera
// 
// Create Date:    23:18:58 02/26/2015 
// Design Name: 
// Module Name:    Clocks 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//		Módulo encargado de la activación y funcionamiento del reloj o clock básico
//		encargado del funcionamiento de los módulos
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module Clocks(
	input wire clk,rst,       //entradas para el reloj
	output wire clk_display   //salida del reloj
    );
localparam N=17;

reg [N:0]Contador, Cuenta_siguiente; 

//Comportamiento del reloj
always@(posedge clk, posedge rst) //funciona cuando hay cambio a franco positivo 
begin
	if(rst)
		Contador <= 0;
	else
		Contador <=Cuenta_siguiente; 
end

always@*
	Cuenta_siguiente = Contador + 1'b1;

assign clk_display = Contador[N];

endmodule
