package spi_wrapper_seq_item_pkg; 
	import uvm_pkg::*;
`include "uvm_macros.svh"
	class spi_wrapper_seq_item extends uvm_sequence_item;
		`uvm_object_utils(spi_wrapper_seq_item)
		  rand bit MISO,MOSI,SS_n,rst_n;
		  rand bit MISO_G,MOSI_G,SS_n_G,rst_n_G;
  		  function new(string name= "spi_wrapper_seq_item");
  		  	super.new(name);
  		  endfunction : new

  		  function string convert2string();
  		  	return $sformatf("%s rst_n=0b%0b, MISO=0b%0b, MOSI=0b%0b, SS_n= 0b%0b"
  		  		,super.convert2string(),rst_n,MISO,MOSI,SS_n);
  		  endfunction

  		  function string convert2string_stimulus();
  		  	return $sformatf("rst_n=0b%0b, MISO=0b%0b, MOSI=0b%0b, SS_n= 0b%0b"
  		  		,rst_n,MISO,MOSI,SS_n);
  		endfunction : convert2string_stimulus
  	endclass : spi_wrapper_seq_item
  endpackage : spi_wrapper_seq_item_pkg
