package spi_wrapper_sqr_pkg;
	import spi_wrapper_seq_item_pkg::*;
	import uvm_pkg::*;
	`include "uvm_macros.svh"
	class spi_wrapper_sqr extends uvm_sequencer #(spi_wrapper_seq_item);
		`uvm_component_utils(spi_wrapper_sqr)
		function new(string name="spi_wrapper_sqr",uvm_component parent= null);
			super.new(name,parent);
		endfunction : new
    endclass : spi_wrapper_sqr
endpackage : spi_wrapper_sqr_pkg