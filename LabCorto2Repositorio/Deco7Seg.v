`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Tecnológico Costa Rica
// Engineer: Kaled Alfaro e Irene Rivera
// 
// Create Date:    21:10:06 02/22/2015 
// Design Name: 
// Module Name:    Deco7Seg 
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

module Deco7Seg(
	//Numero binario a mostrar
	input wire [3:0] hex,
	//Numero procesado para mostrar en display de 7 segmentos
	output reg [6:0] sseg
    );
	//Comportamiento del decodificador
	always @*
	begin
		case(hex)
			4'h0: sseg[6:0] = 7'b0000001;
			4'h1: sseg[6:0] = 7'b1001111;
			4'h2: sseg[6:0] = 7'b0010010;
			4'h3: sseg[6:0] = 7'b0000110;
			4'h4: sseg[6:0] = 7'b1001100;
			4'h5: sseg[6:0] = 7'b0100100;
			4'h6: sseg[6:0] = 7'b0100000;
			4'h7: sseg[6:0] = 7'b0001111;
			4'h8: sseg[6:0] = 7'b0000000;
			4'h9: sseg[6:0] = 7'b0000100;
			default: sseg[6:0] = 7'bxxxxxxx;
		endcase
	end
endmodule
