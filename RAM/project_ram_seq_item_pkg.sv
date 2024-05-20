package project_ram_seq_item_pkg; 
	import uvm_pkg::*;
`include "uvm_macros.svh"
	class project_ram_seq_item extends uvm_sequence_item;
		`uvm_object_utils(project_ram_seq_item)
		  rand bit [9:0] din;
  		  rand bit rx_valid,clk,rst_n,tx_valid; 
  		  rand bit [7:0] dout;
		  bit [7:0] fifo_addr[$];
  		  function new(string name= "project_ram_seq_item");
  		  	super.new(name);
  		  endfunction : new

  		  function string convert2string();
  		  	return $sformatf("%s rst_n=0b%0b, din=0b%0b, rx_valid=0b%0b, tx_valid= 0b%0b, dout=0b%0b"
  		  		,super.convert2string(),rst_n,din,rx_valid,tx_valid,dout);
  		  endfunction

  		  function string convert2string_stimulus();
  		  	return $sformatf("rst_n=0b%0b, din=0b%0b, rx_valid=0b%0b, tx_valid= 0b%0b, dout=0b%0b"
  		  		,rst_n,din,rx_valid,tx_valid,dout);
  		endfunction : convert2string_stimulus
  	endclass : project_ram_seq_item
  endpackage : project_ram_seq_item_pkg
