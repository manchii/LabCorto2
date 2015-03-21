`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Tecnológico Costa Rica
// Engineer: Kaled Alfaro e Irene Rivera
// 
// Create Date:    21:10:06 02/22/2015 
// Design Name: 
// Module Name:    FiltroTecla
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

module FiltroTecla(
	//Dato entrante del teclado
	input wire [7:0] Dato_rx,
	//Señal de nuevo dato entrante
	input wire rx_done_tick,
	//Señal clk y rst
	input wire clk,rst,
	//Señal de permiso a leer
	output reg filtro_enable
    );
//se declaran los estados y sus valores iniciales
localparam [1:0]
	idle = 2'h0,
	f0 = 2'h1,
	espera = 2'h2,
	leer = 2'h3;

	reg [1:0] filtro_reg, filtro_sig;
	
	always@(posedge clk, posedge rst)
	begin
		if(rst)
			filtro_reg <=0;
		else
			filtro_reg <= filtro_sig;
	end

	always@*
	begin
		filtro_sig = filtro_reg;
		filtro_enable = 1'b0;
		case(filtro_reg)
			idle:
				if(rx_done_tick)//espera a que el teclado envie el mensaje de mensaje enviado para empezar la maquina
					filtro_sig = f0;
			f0:
				if(Dato_rx==8'hf0)//revisa si el dato que ingresa corresponde a un f0 en hexadecimal 
					filtro_sig = espera;//si se cumple la condicion se avanza al estado de espera
				else
					filtro_sig = idle;//si no se cumple se regresa al estado de idle
			espera:
				if(rx_done_tick)//espera que llegue de nuevo el aviso desde el teclado que se envio un codigo de tecla
				begin
					//de darse la condicion se avanza al estado de leer  el dato de tecla que entro
					//luego envia un bit en alto para el enable
					filtro_sig = leer;
					filtro_enable = 1'b1;
				end
			leer:
			begin
				//habilita el módulo siguiente 
				filtro_enable = 1'b1;
				filtro_sig = idle;
			end	
		endcase
	end

endmodule
