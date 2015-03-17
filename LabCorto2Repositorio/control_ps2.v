`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Tecnológico de Costa Rica
// Engineer: Kaled Alfaro e Irene Rivera
// 
// Create Date:    13:22:48 03/14/2015 
// Design Name: 
// Module Name:    control_ps2 
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
module control_ps2(
	input wire clk,rst,
//Teclas de control
	input wire ctrl,
	input wire enter,
	input wire dato,
//--------------------------
//Salidas
	output reg salvar,
	output wire [1:0]EstadoTipoDato,
	output reg DatosListos
    );
 
 //declaración de los estados: Inicio, Enter, Dato y Fin
 //Se declara cual el número de cuenta al que corresponde cadfa estado
	localparam [1:0]
		Inicio = 2'b00,
		Enter = 2'b01,
		Dato = 2'b10,
		Fin = 2'b11;
		
	reg [1:0] state_reg, state_next;
	reg [1:0] Cuenta_reg, Cuenta_next;
	wire fin;
	
	assign fin = (Cuenta_reg == 2'b11);
	assign EstadoTipoDato = Cuenta_reg;
	
	always @(posedge clk, posedge rst)
			if(rst)
				begin
				Cuenta_reg <= 2'b00;
				state_reg <= Inicio;
				end
			else
			begin
				Cuenta_reg <= Cuenta_next;
				state_reg <= state_next;
			end	
			
			
	always @*
		begin 
			state_next = state_reg;
			salvar = 1'b0;
			Cuenta_next = Cuenta_reg;
			DatosListos = 1'b0;
			case (state_reg)
//Se declara en que momento debe darse cada estado
				Inicio:
					if(ctrl)
						state_next = Enter;
						
				Enter:
					if(enter)
						begin
							Cuenta_next = Cuenta_reg+1'b1;
							//si la situación se cumple se suma uno a la cuenta y se pasa al siguiente estado
							state_next = Dato;
						end
				Dato:
					if(dato)
						begin
							state_next = Fin;
							salvar = 1'b1;
						end
				Fin:
					if(fin)
					begin
						state_next = Inicio;
						DatosListos = 1'b1;
						Cuenta_next = 2'h0;
					end
					else
						state_next = Enter;
			endcase	
		end
	 
	 
	 
	 
	 
	 
	 


endmodule
