// Copyright (C) 1991-2013 Altera Corporation
// Your use of Altera Corporation's design tools, logic functions 
// and other software and tools, and its AMPP partner logic 
// functions, and any output files from any of the foregoing 
// (including device programming or simulation files), and any 
// associated documentation or information are expressly subject 
// to the terms and conditions of the Altera Program License 
// Subscription Agreement, Altera MegaCore Function License 
// Agreement, or other applicable license agreement, including, 
// without limitation, that your use is for the sole purpose of 
// programming logic devices manufactured by Altera and sold by 
// Altera or its authorized distributors.  Please refer to the 
// applicable agreement for further details.

// PROGRAM		"Quartus II 64-Bit"
// VERSION		"Version 13.1.0 Build 162 10/23/2013 SJ Full Version"
// CREATED		"Sat Mar  1 13:57:21 2014"

module ddr2(
input wire	global_reset_n,
input wire	USB_UART_RXD,
input wire	OCT_RZQIN,
input wire	pll_ref_clk,
output wire	USB_UART_TXD,
output wire	mem_ck,
output wire	mem_ck_n,
output wire	mem_cke,
output wire	mem_cs_n,
output wire	mem_ras_n,
output wire	mem_cas_n,
output wire	mem_reset_n,
output wire	mem_we_n,
output wire	mem_odt,
output wire	[12:0] mem_a,
output wire	[2:0] mem_ba,
output wire	[1:0] mem_dm,
inout wire	[15:0] mem_dq,
inout wire	[1:0] mem_dqs,
inout wire	[1:0] mem_dqs_n,
output wire	[3:0] USR_LED,

//output wire SD_PIN3,	//GND
//output wire SD_PIN2,	//MOSI DI
//output wire SD_PIN1,	//CS
//output wire SD_PIN5,	//SCK

output wire SD_PIN3,	//MOSI DI
output wire SD_PIN2,	//CS
inout SD_PIN1,	//NC - Unused
output wire SD_PIN5,	//SCK
input wire SD_PIN7,	//MISO DO
input wire SD_PIN8	//IRQ?
);

wire	sysclk;

assign SD_PIN1 = 1'bz;
wire init_done;
wire pll_lock;

wire initial_reset_pulse_wire;
initial_reset_pulse
#(
	.INITIAL_US_DELAY(8* 1000000), //8 sec
	.CLOCK_SPEED_HZ(25 * 1000000), //25mhz
	.PULSE_LENGTH(9000)
) initial_reset_pulse_inst
(.clk(sysclk),
.pulse(initial_reset_pulse_wire)
);

kernel	b2v_inst(
	.uart_0_external_connection_rxd(USB_UART_RXD),
	.oct_rzqin(OCT_RZQIN),
	.ddr_ref_clk(sysclk),
        .ddr_ref_clk_reset_n(1'b1),
        .initial_rst_reset_n(initial_reset_pulse_wire),
	.memory_mem_dq(mem_dq),
	.memory_mem_dqs(mem_dqs),
	.memory_mem_dqs_n(mem_dqs_n),
	.uart_0_external_connection_txd(USB_UART_TXD),
	.memory_mem_ck(mem_ck),
	.memory_mem_ck_n(mem_ck_n),
	.memory_mem_cke(mem_cke),
	.memory_mem_cs_n(mem_cs_n),
	.memory_mem_ras_n(mem_ras_n),
	.memory_mem_cas_n(mem_cas_n),
	.memory_mem_we_n(mem_we_n),
	.memory_mem_reset_n(mem_reset_n),
	.memory_mem_odt(mem_odt),
	.memory_mem_a(mem_a),
	.memory_mem_ba(mem_ba),
	.memory_mem_dm(mem_dm),
	.out_port_from_the_led(USR_LED),
        .spi_0_MISO(SD_PIN7),//spi_0.MISO
        .spi_0_MOSI(SD_PIN3),//spi_0.MOSI
        .spi_0_SCLK(SD_PIN5),//spi_0.SCLK
        .spi_0_SS_n(SD_PIN2) //spi_0.SS_n
	);

assign	sysclk = pll_ref_clk;

endmodule
