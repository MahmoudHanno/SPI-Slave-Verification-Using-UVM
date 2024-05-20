import spi_wrapper_test_pkg::*;
import spi_wrapper_config_pkg::*;
import uvm_pkg::*;
`include "uvm_macros.svh"
module top();
	bit clk;

	initial begin 
		forever 
		#1 clk= ~clk;
	end 
    /*
    module spi_wrapper(MISO,MOSI,SS_n,clk,rst_n);
input MOSI,clk,rst_n,SS_n;
output MISO;
*/
	spi_wrapper_if spiif(clk);
	spi_wrapper_G_if spiif_G(clk);
	spi_wrapper DUT(spiif.MISO,spiif.MOSI,spiif.SS_n,clk,spiif.rst_n);
	//module SPISLAVE(MOSI,MISO,SS_n,clk,rst_n);
	SPISLAVE GOLDEN(spiif_G.MOSI,spiif_G.MISO,spiif_G.SS_n,clk,spiif_G.rst_n);
	initial begin
		uvm_config_db #(virtual spi_wrapper_if)::set(null, "uvm_test_top","spi_wrapper_IF",spiif);
		uvm_config_db #(virtual spi_wrapper_G_if)::set(null, "uvm_test_top","spi_wrapper_G_IF",spiif_G);
		run_test("spi_wrapper_test");
	end
endmodule