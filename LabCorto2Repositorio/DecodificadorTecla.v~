`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Tecnológico Costa Rica
// Engineer: Kaled Alfaro e Irene Rivera
// 
// Create Date:    21:10:06 02/22/2015 
// Design Name: 
// Module Name:    DecodificadorTecla
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

module DecodificadorTecla(
	//Dato entrante del teclado
	input wire [7:0] Dato_rx,
	//Señal para guardar
	input wire salvar,
	//Señal que indica la clase de dato esperado
	input wire [1:0] EstadoTipoDato,
	//Señal clk y rst
	input wire clk,rst,
	//variables programables
	output wire [4:0] temperatura,
	output wire ignicion,
	output wire presencia
    );
localparam [1:0]
	temp = 2'h1,
	ign = 2'h2,
	pres = 2'h3;

reg [4:0] temp_reg, temp_sig;
reg ign_reg, ign_sig;
reg pres_reg, pres_sig;
wire [4:0] temp_deco;
wire yn_deco;

	always@(posedge clk, posedge rst)
	begin
		if(rst)
		begin
			temp_reg <= 4'b0;
			ign_reg <= 1'b0;
			pres_reg <= 1'b0;
		end
		else
		begin
			temp_reg <= temp_sig;
			ign_reg <= ign_sig;
			pres_reg <= pres_sig;	
		end
	end

	always@*
	begin
		temp_sig = temp_reg;
		ign_sig = ign_reg;
		pres_sig = pres_reg;
		if(salvar)
		begin
			case(EstadoTipoDato)
				temp:
					temp_sig = temp_deco;
				ign:
					ign_sig = yn_deco;
				pres:
					pres_sig = yn_deco;
			endcase
		end
	end	
	
	assign temp_deco = 	(Dato_rx == 8'h45) ? 5'd0 : //'20'	
				(Dato_rx == 8'h16) ? 5'd4 : //'24'
				(Dato_rx == 8'h1e) ? 5'd8 : //'28'
				(Dato_rx == 8'h26) ? 5'd12 : //'32'
				(Dato_rx == 8'h25) ? 5'd16 : //'36'
				(Dato_rx == 8'h2e) ? 5'd20 : //'40'
				(Dato_rx == 8'h36) ? 5'd24 : //'44'
				(Dato_rx == 8'h3d) ? 5'd28 : //'48'
				(Dato_rx == 8'h3e) ? 5'd31 : 5'bxxxxx; //'51'

	assign yn_deco = (Dato_rx == 8'h35) ? 1'b1 : 1'b0; // 'y' o 'n'

	assign temperatura = temp_reg;
	assign ignicion = ign_reg;
	assign presencia = pres_reg;

endmodule

