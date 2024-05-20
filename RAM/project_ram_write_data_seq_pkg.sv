package project_ram_write_data_seq_pkg;
	import project_ram_seq_item_pkg::*;
	import uvm_pkg::*;
	`include "uvm_macros.svh"
	class project_ram_write_data_seq extends uvm_sequence #(project_ram_seq_item);
		`uvm_object_utils(project_ram_write_data_seq);
		project_ram_seq_item seq_item;

		function new(string name ="project_ram_write_data_seq");
			super.new(name);
		endfunction : new

		task body;
			seq_item=project_ram_seq_item::type_id::create("seq_item");
			start_item(seq_item);
			seq_item.rst_n=1;
			seq_item.rx_valid=1;
			seq_item.din[9:8]=2'b01;
			seq_item.din[7:0]=$random;
			finish_item(seq_item);
		endtask : body
	endclass : project_ram_write_data_seq
endpackage : project_ram_write_data_seq_pkg
