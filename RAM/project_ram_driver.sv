package project_ram_driver_pkg;
import uvm_pkg::*;
import project_ram_config_pkg::*;
import project_ram_seq_item_pkg::*;
import project_ram_sqr_pkg::*;
`include "uvm_macros.svh"
	class project_ram_driver extends uvm_driver #(project_ram_seq_item);
		`uvm_component_utils(project_ram_driver)

		virtual project_ram_if project_ram_vif;
		project_ram_config project_ram_cfg;
		project_ram_seq_item stim_seq_item;

		function new(string name="project_ram_driver", uvm_component parent = null);
			super.new(name,parent);
		endfunction : new


		task run_phase (uvm_phase phase);
			super.run_phase(phase);
			forever begin
				stim_seq_item=project_ram_seq_item::type_id::create("stim_seq_item");
				seq_item_port.get_next_item(stim_seq_item);
			
			project_ram_vif.din=stim_seq_item.din;
			project_ram_vif.rx_valid=stim_seq_item.rx_valid;
			project_ram_vif.rst_n=stim_seq_item.rst_n;
			//project_ram_vif.tx_valid=stim_seq_item.tx_valid;
            //project_ram_vif.dout=stim_seq_item.dout;
            
				@(negedge project_ram_vif.clk);
				seq_item_port.item_done();
				`uvm_info("run_phase",stim_seq_item.convert2string_stimulus(),UVM_HIGH)
			end
			
		endtask : run_phase
	endclass : project_ram_driver
endpackage : project_ram_driver_pkg