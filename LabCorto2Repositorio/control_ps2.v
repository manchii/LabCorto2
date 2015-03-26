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
//	Módulo encargado de diferenciar las teclas permitidas, este módulo se encarga de establecer el protocolo 
//	entre el teclado y la unidad de detección de peligro.
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module control_ps2(
//Variables clock y reset
	input wire clk,rst,
//Señales de control ----- dadas por el módulo identificador de tecla
	input wire ctrl,
	input wire enter,
	input wire dato,
//--------------------------
//Salidas
	output reg salvar, // guardar dato
	output wire [1:0]EstadoTipoDato, // El tipo de dato esperado para leer y guardar
	output reg DatosListos //Señal de aviso para finalización de la recolección de datos
    );
 
 //Declaración simbólica de los estados: Inicio, Enter, Dato y Fin
	localparam [1:0]
		Inicio = 2'b00,
		Enter = 2'b01,
		Dato = 2'b10,
		Fin = 2'b11;
		
	reg [1:0] state_reg, state_next;
	//Se define el contador para generar la variable tipo de dato.
	reg [1:0] Cuenta_reg, Cuenta_next;
	 //Señal de control para determinar el fin del protocolo
	wire fin;
	//Asignación de parada del protocolo: cuando se hayan recolectado todos los datos
	assign fin = (Cuenta_reg == 2'b11);
	//Asignación de la salida de tipo de dato
	assign EstadoTipoDato = Cuenta_reg;
	
	//Descripción de la máquina de estados para control
	
	//Inicio
	always @(posedge clk, posedge rst) //Sincronización con el clock las transiciones
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
			
		
		//Asignación de las transiciones y salidas	
	always @*
		begin 
			state_next = state_reg;
			salvar = 1'b0;
			Cuenta_next = Cuenta_reg;
			DatosListos = 1'b0;
			case (state_reg)
//Se declaran las condiciones de salto para cada estado
				Inicio:
					if(ctrl)
						//si la tecla entrante corresponde a la tecla 
						//ctrl se avanza al siguiente estado
						state_next = Enter;
				
						
				Enter:
					if(enter) //si la tecla es enter se avanza al estado Dato.
						begin
						//Se realiza cuenta para cambiar el tipo de dato.
							Cuenta_next = Cuenta_reg+1'b1;
							state_next = Dato;
						end
				Dato:
					if(dato)
						begin
						//si se ingresa un dato se avanza al estado Fin
							state_next = Fin;
						//se envia un bit en alto a la salida salvar para guardar al dato
							salvar = 1'b1;
						end
				Fin:
					if(fin) //Si se encuentra en el fin del protocolo, se reinician las variables
					begin
						state_next = Inicio; //De vuelta al inicio
						DatosListos = 1'b1; // Se activa la señal de finalización 
						Cuenta_next = 2'h0; // Reinicio de la variable tipo de dato
					end
					//si no se cumple la condicion de finalizacion se regresa al estado de Enter.
					else
						state_next = Enter;
			endcase	
		end
	//Fin
	 
	 
	 
	 
	 
	 


endmodule
