`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Tecnológico de Costa Rica
// Engineer: Kaled Alfaro e Irene Rivera
// 
// Create Date:    22:25:51 02/26/2015 
// Design Name: 
// Module Name:    Sistema_Completo 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: este
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module Sistema_Completo(
	input wire [4:0] Temperatura,
	input wire Presencia,
	input wire Ignicion,
	input wire clk,rst,
	output wire Ventilacion,
	output wire Alarma,
	output wire [6:0] Catodo,
	output wire [3:0] Seleccion
    );

//Declaracion simbolica de los estados de la maquina
localparam [1:0]
	leer = 2'b01,
	decidir = 2'b10, 
	alerta = 2'b11;

//Inicio de declaracion de variables
//Variables de lectura de datos
wire [4:0] Temperatura_Sincronizada;
wire Presencia_Sincronizada;
wire Ignicion_Sincronizada;
wire 	Dato_listo_Temp0,Dato_listo_Temp1,Dato_listo_Temp2,Dato_listo_Temp3,Dato_listo_Temp4,
	Dato_listo_Presencia,Dato_listo_Ignicion;
wire Dato_listo;

//Banderas
wire [1:0] Alerta;
wire Activar_Decidir;
wire Peligro;

//Variables del display
wire [6:0] Unidades, Decenas, Actividad; 
reg [6:0] Estado;
wire [3:0] Unidades_BCD, Decenas_BCD;
wire [1:0] Estado_maquina;
wire clk_disp;

always@*
begin
	case(Estado_maquina)
		leer: Estado = 7'b1001111;
		decidir: Estado = 7'b0010010;
		alerta: Estado = 7'b0000110;
		default: Estado = 7'hff;
	endcase
end

//Inicio de descripcion
assign Dato_listo = Dato_listo_Temp0 | Dato_listo_Temp1 | Dato_listo_Temp2 | Dato_listo_Temp3 | Dato_listo_Temp4 |
	Dato_listo_Presencia | Dato_listo_Ignicion;

Reg_AntiRebote ModuloRegistroTemp0(
	.clk(clk),//1bit
	.rst(rst),//1bit
	.Switch(Temperatura[0]),//1bit
	.Dato_Sincronizado(Temperatura_Sincronizada[0]),//1bit
	.Dato_listo(Dato_listo_Temp0)//1bit
);

Reg_AntiRebote ModuloRegistroTemp1(
	.clk(clk),//1bit
	.rst(rst),//1bit
	.Switch(Temperatura[1]),//1bit
	.Dato_Sincronizado(Temperatura_Sincronizada[1]),//1bit
	.Dato_listo(Dato_listo_Temp1)//1bit
);

Reg_AntiRebote ModuloRegistroTemp2(
	.clk(clk),//1bit
	.rst(rst),//1bit
	.Switch(Temperatura[2]),//1bit
	.Dato_Sincronizado(Temperatura_Sincronizada[2]),//1bit
	.Dato_listo(Dato_listo_Temp2)//1bit
);

Reg_AntiRebote ModuloRegistroTemp3(
	.clk(clk),//1bit
	.rst(rst),//1bit
	.Switch(Temperatura[3]),//1bit
	.Dato_Sincronizado(Temperatura_Sincronizada[3]),//1bit
	.Dato_listo(Dato_listo_Temp3)//1bit
);

Reg_AntiRebote ModuloRegistroTemp4(
	.clk(clk),//1bit
	.rst(rst),//1bit
	.Switch(Temperatura[4]),//1bit
	.Dato_Sincronizado(Temperatura_Sincronizada[4]),//1bit
	.Dato_listo(Dato_listo_Temp4)//1bit
);

Reg_AntiRebote ModuloRegistroPresencia(
	.clk(clk),//1bit
	.rst(rst),//1bit
	.Switch(Presencia),//1bit
	.Dato_Sincronizado(Presencia_Sincronizada),//1bit
	.Dato_listo(Dato_listo_Presencia)//1bit
);

Reg_AntiRebote ModuloRegistroIgnicion(
	.clk(clk),//1bit
	.rst(rst),//1bit
	.Switch(Ignicion),//1bit
	.Dato_Sincronizado(Ignicion_Sincronizada),//1bit
	.Dato_listo(Dato_listo_Ignicion)//1bit
);

LogicaDeActivacion ModulodeActivacion(
	.Alerta(Alerta),//2bits
	.rst(rst),//2bits
	.clk(clk),//1bit
	.Presencia(Presencia_Sincronizada),//1bit
	.Ignicion(Ignicion_Sincronizada),//1bit
	.Activar_Decidir(Activar_Decidir),//1bit,
	.Alarma(Alarma),//1bit
	.Ventilacion(Ventilacion),//1bit
	.Peligro(Peligro)//1bit
);

Flag_Danger ModuloAvisodePeligro(
	.Temperatura(Temperatura_Sincronizada), //5bits
	.Alerta(Alerta) //2bits
);

Driver_7seg ModuloControlador7seg(
	.clk_disp(clk_disp),//1bit
	.rst(rst), //1bit
	.Unidades(Unidades), //7bits
	.Decenas(Decenas), //7bits
	.Estado(Estado), //7bits
	.Actividad(Actividad), //7bits
	.Catodo(Catodo), //7bits
	.Seleccion(Seleccion) //4bits
);

Deco7Seg ModuloDeco7seg_Unidades(
	.hex(Unidades_BCD), //4bits
	.sseg(Unidades) //7bits
);

Deco7Seg ModuloDeco7seg_Decenas(
	.hex(Decenas_BCD), //4bits
	.sseg(Decenas) //7bits
);

ConversorBCD ModuloConversorBCD (
	.Temperatura_sincronizada(Temperatura_Sincronizada), //5bits
	.Decenas(Decenas_BCD), //4bits
	.Unidades(Unidades_BCD) //4bits
);

Control ModuloControl (
	.Dato_listo(Dato_listo),//1bit
	.Peligro(Peligro),//1bit
	.rst(rst),//1bit
	.clk(clk),
	.Activar_Decidir(Activar_Decidir),//1bit
	.Estados(Estado_maquina) //2bits
);

Clocks ModuloClock_display (
	.clk(clk),	//1bit
	.rst(rst),	//1bit
	.clk_display(clk_disp) //1bit
);

Activacion_7seg ModuloActivacion_7seg (
	.Ventilacion(Ventilacion), //1bit
	.Alarma(Alarma),	//1bit
	.Activacion(Actividad)	//7bits
);


endmodule
