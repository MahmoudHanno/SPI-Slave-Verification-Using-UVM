package project_ram_sqr_pkg;
	import project_ram_seq_item_pkg::*;
	import uvm_pkg::*;
	`include "uvm_macros.svh"
	class project_ram_sqr extends uvm_sequencer #(project_ram_seq_item);
		`uvm_component_utils(project_ram_sqr)
		function new(string name="project_ram_sqr",uvm_component parent= null);
			super.new(name,parent);
		endfunction : new
    endclass : project_ram_sqr
endpackage : project_ram_sqr_pkg