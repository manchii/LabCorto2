`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Tecnológico Costa Rica
// Engineer: Kaled Alfaro e Irene Rivera
// 
// Create Date:    21:10:06 02/22/2015 
// Design Name: 
// Module Name:    Identificador
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

module Identificador(
	//Dato entrante del teclado
	input wire [7:0] Dato_rx,
	//Señal que habilita cuando tomar el dato despues del 'F0'
	input wire filtro_enable,
	//Señal que indica la clase de dato esperado
	input wire [1:0] EstadoTipoDato,
	//Señales de control
	output reg ctrl,
	output reg enter,
	output reg dato
    );
localparam [1:0]
	temperatura = 2'h1,
	ignicion = 2'h2,
	presencia = 2'h3;

wire ykey_nkey; 
wire temp_key;

	//Comportamiento del identificador de tecla
	always @*
	begin
		ctrl = 0;
		enter = 0;
		dato = 0;
		if(filtro_enable == 1'b1)
		begin		
			ctrl = (Dato_rx == 8'h14) ? 1'b1 : 1'b0;
			enter = (Dato_rx == 8'h5a) ? 1'b1 : 1'b0;
			case(EstadoTipoDato)
				temperatura:
					dato = temp_key;
				ignicion:
					dato = ykey_nkey;
				precensia:
					dato = ykey_nkey;
			endcase
		end
	end
	assign temp_key = 	(Dato_rx == 8'h45) ? 1'b1 : //'0'	
				(Dato_rx == 8'h16) ? 1'b1 : //'1'
				(Dato_rx == 8'h1e) ? 1'b1 : //'2'
				(Dato_rx == 8'h26) ? 1'b1 : //'3'
				(Dato_rx == 8'h25) ? 1'b1 : //'4'
				(Dato_rx == 8'h2e) ? 1'b1 : //'5'
				(Dato_rx == 8'h36) ? 1'b1 : //'6'
				(Dato_rx == 8'h3d) ? 1'b1 : //'7'
				(Dato_rx == 8'h3e) ? 1'b1 : 1'b0; //'8'
	assign ykey_nkey = ((Dato_rx == 8'h35) || (Dato_rx == 8'h31)) ? 1'b1 : 1'b0; // 'y' o 'n'	
	

endmodule

