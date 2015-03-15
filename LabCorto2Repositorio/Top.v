`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Tecnológico de Costa Rica
// Engineer: Kaled Alfaro e Irene Rivera
// 
// Create Date:    13:22:48 03/14/2015 
// Design Name: 
// Module Name:    Interfaz_ps2
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module Top(
	input wire ps2d,ps2c,
	input wire clk,rst,
	output wire Ventilacion,
	output wire Alarma,
	output wire [6:0] Catodo,
	output wire [3:0] Seleccion	
    );

wire [4:0] temperatura;
wire ignicion, presencia, DatosListos;

Interfaz_ps2 modulointerfazps2(
	.ps2d(ps2d),
	.ps2c(ps2c),
	.clk(clk),
	.rst(rst),
	.temperatura(temperatura),
	.ignicion(ignicion),
	.presencia(presencia),
	.DatosListos(DatosListos)
);

Proyecto_1 modulopasado(
	.Temperatura(temperatura),
	.Presencia(presencia),
	.Ignicion(ignicion),
	.DatosListos(DatosListos),
	.clk(clk),
	.rst(rst),
	.Ventilacion(Ventilacion),
	.Alarma(Alarma),
	.Catodo(Catodo),
	.Seleccion(Seleccion)
);

endmodule


