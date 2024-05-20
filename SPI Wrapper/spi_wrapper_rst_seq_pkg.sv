package spi_wrapper_rst_seq_pkg;
	import spi_wrapper_seq_item_pkg::*;
	import uvm_pkg::*;
	`include "uvm_macros.svh"
	class spi_wrapper_rst_seq extends uvm_sequence #(spi_wrapper_seq_item);
		`uvm_object_utils(spi_wrapper_rst_seq);
		spi_wrapper_seq_item seq_item;

		function new(string name ="spi_wrapper_rst_seq");
			super.new(name);
		endfunction : new

		task body;
			seq_item=spi_wrapper_seq_item::type_id::create("seq_item");
			start_item(seq_item);
			seq_item.rst_n=0;
			seq_item.rst_n_G=0;
			seq_item.SS_n=$random;
			seq_item.SS_n_G=$random;
			seq_item.MOSI=$random;
			seq_item.MOSI_G=$random;
			finish_item(seq_item);
		endtask : body
	endclass : spi_wrapper_rst_seq
endpackage : spi_wrapper_rst_seq_pkg