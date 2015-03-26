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
//	Módulo encargado para habilitar la lectura después del código de ruptura F0 del protocolo del teclado
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////

module FiltroTecla(
	//Dato entrante capturado del teclado
	input wire [7:0] Dato_rx,
	//Señal de dato entrante listo para leerse
	input wire rx_done_tick,
	//Señal clock y reset
	input wire clk,rst,
	//Señal de permiso a leer
	output reg filtro_enable
    );
//se declaran los estados y sus valores de manera simbólica
localparam [1:0]
	idle = 2'h0,
	f0 = 2'h1,
	espera = 2'h2,
	leer = 2'h3;

//Registro para alojar los estados
	reg [1:0] filtro_reg, filtro_sig;
	
//Descripción de la máquina de estados
//Inicio
	always@(posedge clk, posedge rst)
	begin
		if(rst)
			filtro_reg <=0;
		else
			filtro_reg <= filtro_sig;
	end

//Descripción de las transiciones y las salidas
	always@*
	begin
		filtro_sig = filtro_reg;
		filtro_enable = 1'b0;
		case(filtro_reg)
			idle:
			//espera a que el módulo de recepción de datos habilite la lectura para empezar la transición
				if(rx_done_tick)
					filtro_sig = f0;
			f0:
				if(Dato_rx==8'hf0)//revisa si el dato que ingresa corresponde a un f0 en hexadecimal 
					filtro_sig = espera;//si se cumple la condición se avanza al estado de espera
				else
					filtro_sig = idle;//si no se cumple se regresa al estado de idle
			espera:
				if(rx_done_tick)//Se espera hasta llegue la señal de habilitación de lectura
				begin
					//de darse la condicion se avanza al estado de leer
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
//Fin


endmodule
