`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Tecnológico de Costa Rica
// Engineer: Kaled Alfaro e Irene Rivera
// 
// Create Date:    19:07:13 02/22/2015 
// Design Name: 
// Module Name:    ConversorBCD 
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

module ConversorBCD(
		//Señal de temperatura digital
		input [4:0] Temperatura_sincronizada,
		//Señal de temperatura BCD
		output reg [3:0] Decenas, 
		output reg [3:0] Unidades
    );
	
	//Comportamiento del decodificador a BCD
	always @*
	begin
		case(Temperatura_sincronizada)
			5'd0: begin Decenas <= 4'h2; Unidades <= 4'h0; end
			5'd1: begin Decenas <= 4'h2; Unidades <= 4'h1; end
			5'd2: begin Decenas <= 4'h2; Unidades <= 4'h2; end
			5'd3: begin Decenas <= 4'h2; Unidades <= 4'h3; end
			5'd4: begin Decenas <= 4'h2; Unidades <= 4'h4; end
			5'd5: begin Decenas <= 4'h2; Unidades <= 4'h5; end
			5'd6: begin Decenas <= 4'h2; Unidades <= 4'h6; end
			5'd7: begin Decenas <= 4'h2; Unidades <= 4'h7; end
			5'd8: begin Decenas <= 4'h2; Unidades <= 4'h8; end
			5'd9: begin Decenas <= 4'h2; Unidades <= 4'h9; end
			5'd10: begin Decenas <= 4'h3; Unidades <= 4'h0; end
			5'd11: begin Decenas <= 4'h3; Unidades <= 4'h1; end
			5'd12: begin Decenas <= 4'h3; Unidades <= 4'h2; end
			5'd13: begin Decenas <= 4'h3; Unidades <= 4'h3; end
			5'd14: begin Decenas <= 4'h3; Unidades <= 4'h4; end
			5'd15: begin Decenas <= 4'h3; Unidades <= 4'h5; end
			5'd16: begin Decenas <= 4'h3; Unidades <= 4'h6; end
			5'd17: begin Decenas <= 4'h3; Unidades <= 4'h7; end
			5'd18: begin Decenas <= 4'h3; Unidades <= 4'h8; end
			5'd19: begin Decenas <= 4'h3; Unidades <= 4'h9; end
			5'd20: begin Decenas <= 4'h4; Unidades <= 4'h0; end
			5'd21: begin Decenas <= 4'h4; Unidades <= 4'h1; end
			5'd22: begin Decenas <= 4'h4; Unidades <= 4'h2; end
			5'd23: begin Decenas <= 4'h4; Unidades <= 4'h3; end
			5'd24: begin Decenas <= 4'h4; Unidades <= 4'h4; end
			5'd25: begin Decenas <= 4'h4; Unidades <= 4'h5; end
			5'd26: begin Decenas <= 4'h4; Unidades <= 4'h6; end
			5'd27: begin Decenas <= 4'h4; Unidades <= 4'h7; end
			5'd28: begin Decenas <= 4'h4; Unidades <= 4'h8; end
			5'd29: begin Decenas <= 4'h4; Unidades <= 4'h9; end
			5'd30: begin Decenas <= 4'h5; Unidades <= 4'h0; end
			5'd31: begin Decenas <= 4'h5; Unidades <= 4'h1; end	
		endcase
	end
endmodule
