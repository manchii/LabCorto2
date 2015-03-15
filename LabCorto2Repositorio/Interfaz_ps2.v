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
module Interfaz_ps2(
	input wire ps2d,ps2c,
	input wire clk,rst,
	output wire [4:0] temperatura,
	output wire ignicion,
	output wire presencia,
	output wire DatosListos
    );

wire rx_done_tick; 
wire [7:0] Dato_rx;
wire Filtro_enable;
wire [1:0] EstadoTipoDato;
wire ctrl, enter, dato;
wire salvar;


recieve_data modulorecepcion(
	.clk(clk),
	.reset(rst),
	.ps2d(ps2d),
	.ps2c(ps2c),
	.rx_en(1'b1),
	.rx_done_tick(rx_done_tick),
	.dout(Dato_rx)
); 	

FiltroTecla modulofiltrotecla(
	.clk(clk),
	.rst(rst),
	.rx_done_tick(rx_done_tick),
	.Dato_rx(Dato_rx),
	.filtro_enable(Filtro_enable)
);

Identificador moduloidentificador(
	.Dato_rx(Dato_rx),
	.filtro_enable(Filtro_enable),
	.EstadoTipoDato(EstadoTipoDato),
	.ctrl(ctrl),
	.enter(enter),
	.dato(dato)
);

DecodificadorTecla moduloDecodificadorTecla(
	.Dato_rx(Dato_rx),
	.salvar(salvar),
	.EstadoTipoDato(EstadoTipoDato),
	.clk(clk),
	.rst(rst),
	.temperatura(temperatura),
	.ignicion(ignicion),
	.presencia(presencia)
);

control_ps2 modulocontrolps2(
	.clk(clk),
	.rst(rst),
	.ctrl(ctrl),
	.enter(enter),
	.dato(dato),
	.salvar(salvar),
	.EstadoTipoDato(EstadoTipoDato),
	.DatosListos(DatosListos)
);

endmodule

