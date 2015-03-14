`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Tecnológico de Costa Rica
// Engineer: Kaled Alfaro e Irene Rivera
// 
// Create Date:    18:56:38 02/23/2015 
// Design Name: 
// Module Name:    Driver_7seg
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
module Driver_7seg(
	input wire clk_disp,rst, //Clock y reset
	//Entradas para mostrar en los 4 displays
	input wire [6:0] Unidades,
	input wire [6:0] Decenas, 
	input wire [6:0] Estado,
	input wire [6:0] Actividad,
	//Salidas para activar los displays
	output reg [6:0] Catodo,
	output reg [3:0] Seleccion
);

reg [2:0] estado_actual, estado_siguiente;

//Declaracion simbolica de los estados de la maquina de estados del driver
localparam [2:0] 
	idle = 3'b000,
	unidades = 3'b001,
	decenas = 3'b010,
	actividad = 3'b011,
	estado = 3'b100;

//Comportamiento ante los cambios de clock y reset de la maquina de estados
always@(posedge clk_disp, posedge rst)
begin
	if(rst)
		estado_actual <= idle;
	else
		estado_actual <= estado_siguiente;
end

//Comportamiento de la maquina de estado
always@*
begin
	Catodo = 7'hff; 	//Se muestra en un reset
	Seleccion = 4'hf;	//Se muestra en un reset
	case(estado_actual)
		idle:
		//Estado ante el Reset
		begin
			estado_siguiente = unidades;
		end
		unidades:
		//Se enciende el display de Unidades
		begin
			estado_siguiente = decenas;
			Catodo = Unidades;
			Seleccion = 4'b1110;
		end
		decenas:
		//Se enciende el display de Decenas
		begin
			estado_siguiente = actividad;
			Catodo = Decenas;
			Seleccion = 4'b1101;
		end
		actividad:
		//Se enciende el display de actividad, muestra una "V" o "A"
		begin
			estado_siguiente = estado;
			Catodo = Actividad;
			Seleccion = 4'b1011;
		end
		estado:
		//Se enciende el display del # de estado
		begin
			estado_siguiente = unidades; //Vuelve a Unidades
			Catodo = Estado;
			Seleccion = 4'b0111;
		end
		default:
			estado_siguiente = idle;
	endcase
end
endmodule
