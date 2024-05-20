package spi_wrapper_read_addr_seq_pkg;
	import spi_wrapper_seq_item_pkg::*;
	import uvm_pkg::*;
	`include "uvm_macros.svh"
	class spi_wrapper_read_addr_seq extends uvm_sequence #(spi_wrapper_seq_item);
		`uvm_object_utils(spi_wrapper_read_addr_seq);
		spi_wrapper_seq_item seq_item;

		function new(string name ="spi_wrapper_read_addr_seq");
			super.new(name);
		endfunction : new

		task body;
			seq_item=spi_wrapper_seq_item::type_id::create("seq_item");
			start_item(seq_item);
				seq_item.SS_n=0;
				seq_item.SS_n_G=0;
				seq_item.rst_n=1;
				seq_item.rst_n_G=1;
			finish_item(seq_item);
			start_item(seq_item);
				seq_item.MOSI=1;
				seq_item.MOSI_G=1;
			finish_item(seq_item);
			start_item(seq_item);
				seq_item.MOSI=1;
				seq_item.MOSI_G=1;
			finish_item(seq_item);
			start_item(seq_item);
				seq_item.MOSI=0;
				seq_item.MOSI_G=0;
			finish_item(seq_item);
			repeat(8)begin
				start_item(seq_item);
					seq_item.MOSI=$random;
					seq_item.MOSI_G=$random;
				finish_item(seq_item);
			end
			
			start_item(seq_item);
				seq_item.SS_n=1;
				seq_item.SS_n_G=1;
			finish_item(seq_item);
		endtask : body
	endclass : spi_wrapper_read_addr_seq
endpackage : spi_wrapper_read_addr_seq_pkg