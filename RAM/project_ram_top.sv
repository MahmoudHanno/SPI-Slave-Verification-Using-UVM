import project_ram_test_pkg::*;
import project_ram_config_pkg::*;
import uvm_pkg::*;
`include "uvm_macros.svh"
module top();
	bit clk;

	initial begin 
		forever 
		#1 clk= ~clk;
	end 
    /*
    module spi_ram(din,rx_valid,tx_valid,dout,clk,rst_n);   
input [9:0] din;
input rx_valid;
input clk,rst_n;
output reg tx_valid;
output reg[7:0] dout;
*/
	project_ram_if ramif(clk);
	spi_ram DUT(ramif.din,ramif.rx_valid,ramif.tx_valid,ramif.dout,clk,ramif.rst_n);

	initial begin
		uvm_config_db #(virtual project_ram_if)::set(null, "uvm_test_top","project_ram_IF",ramif);
		run_test("project_ram_test");
	end

endmodule