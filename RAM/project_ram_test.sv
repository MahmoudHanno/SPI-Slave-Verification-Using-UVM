package project_ram_test_pkg; 
import project_ram_config_pkg::*;
import project_ram_env_pkg::*;
import project_ram_read_data_seq_pkg::*;
import project_ram_read_addr_seq_pkg::*;
import project_ram_write_addr_seq_pkg::*;
import project_ram_write_data_seq_pkg::*;
import project_ram_rst_seq_pkg::*;
import uvm_pkg::*;
`include "uvm_macros.svh"
class project_ram_test extends uvm_test;
	`uvm_component_utils(project_ram_test)

	project_ram_env env;
	project_ram_config project_ram_cfg;
	project_ram_read_data_seq read_data_seq;
	project_ram_read_addr_seq read_addr_seq;
	project_ram_write_data_seq write_data_seq;
	project_ram_write_addr_seq write_addr_seq;
	project_ram_rst_seq reset_seq;
	function new(string name= "project_ram_test", uvm_component parent= null);
		super.new(name,parent);
	endfunction : new

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		env = project_ram_env::type_id::create("env",this);
		project_ram_cfg= project_ram_config::type_id::create("project_ram_cfg",this);
		read_data_seq= project_ram_read_data_seq::type_id::create("read_data_seq",this);
		read_addr_seq= project_ram_read_addr_seq::type_id::create("read_addr_seq",this);
		write_data_seq= project_ram_write_data_seq::type_id::create("write_data_seq",this);
		write_addr_seq= project_ram_write_addr_seq::type_id::create("write_addr_seq",this);
		reset_seq= project_ram_rst_seq::type_id::create("reset_seq",this);
		if(!uvm_config_db #(virtual project_ram_if)::get(this,"","project_ram_IF",project_ram_cfg.project_ram_vif))
			`uvm_fatal("build_phase","Test- Unable to get the virtual interface of the SPI RAM from uvm_config_db");

		uvm_config_db #(project_ram_config)::set(this,"*","CFG",project_ram_cfg);
	endfunction : build_phase


	task run_phase(uvm_phase phase);
		super.run_phase(phase);
		phase.raise_objection(this);
		 `uvm_info("run_phase","Reset asserted", UVM_LOW)
		 reset_seq.start(env.agt.sqr);
		 `uvm_info("run_phase","Reset Deasserted", UVM_LOW)

		 `uvm_info("run_phase","stimulus generation started", UVM_LOW)

		 repeat(10000)begin
			//write address sequence
			write_addr_seq.start(env.agt.sqr);
			//write data sequence
			write_data_seq.start(env.agt.sqr);
		 end
		 repeat(256)begin
			//read address sequence
			read_addr_seq.start(env.agt.sqr);
			//read data sequence
			read_data_seq.start(env.agt.sqr);
		 end
		 repeat(10)begin
			//write address sequence
			write_addr_seq.start(env.agt.sqr);
			//write data sequence
			write_data_seq.start(env.agt.sqr);
		 end
		 repeat(25)begin
			//read address sequence
			read_addr_seq.start(env.agt.sqr);
			//read data sequence
			read_data_seq.start(env.agt.sqr);
		 end
		 `uvm_info("run_phase","Stimulus Deasserted", UVM_LOW)
		phase.drop_objection(this);	
	endtask : run_phase

endclass : project_ram_test
endpackage : project_ram_test_pkg