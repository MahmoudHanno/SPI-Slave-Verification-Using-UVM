package spi_wrapper_test_pkg; 
import spi_wrapper_config_pkg::*;
import spi_wrapper_env_pkg::*;
import spi_wrapper_rst_seq_pkg::*;
import spi_wrapper_read_addr_seq_pkg::*;
import spi_wrapper_read_data_seq_pkg::*;
import spi_wrapper_write_addr_seq_pkg::*;
import spi_wrapper_write_data_seq_pkg::*;
import uvm_pkg::*;
`include "uvm_macros.svh"
class spi_wrapper_test extends uvm_test;
	`uvm_component_utils(spi_wrapper_test)

	spi_wrapper_env env;
	spi_wrapper_config spi_wrapper_cfg;
	spi_wrapper_rst_seq reset_seq;
	spi_wrapper_read_data_seq read_data_seq;
	spi_wrapper_read_addr_seq read_addr_seq;
	spi_wrapper_write_data_seq write_data_seq;
	spi_wrapper_write_addr_seq write_addr_seq;
	

	function new(string name= "spi_wrapper_test", uvm_component parent= null);
		super.new(name,parent);
	endfunction : new

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		env = spi_wrapper_env::type_id::create("env",this);
		spi_wrapper_cfg= spi_wrapper_config::type_id::create("spi_wrapper_cfg",this);
		reset_seq= spi_wrapper_rst_seq::type_id::create("reset_seq",this);
		read_data_seq= spi_wrapper_read_data_seq::type_id::create("read_data_seq",this);
		read_addr_seq= spi_wrapper_read_addr_seq::type_id::create("read_addr_seq",this);
		write_data_seq= spi_wrapper_write_data_seq::type_id::create("write_data_seq",this);
		write_addr_seq= spi_wrapper_write_addr_seq::type_id::create("write_addr_seq",this);
		if(!uvm_config_db #(virtual spi_wrapper_if)::get(this,"","spi_wrapper_IF",spi_wrapper_cfg.spi_wrapper_vif))
			`uvm_fatal("build_phase","Test- Unable to get the virtual interface of the SPI RAM from uvm_config_db");
		if(!uvm_config_db #(virtual spi_wrapper_G_if)::get(this,"","spi_wrapper_G_IF",spi_wrapper_cfg.spi_wrapper_G_vif))
			`uvm_fatal("build_phase","Test- Unable to get the virtual interface of the SPI RAM from uvm_config_db");

		uvm_config_db #(spi_wrapper_config)::set(this,"*","CFG",spi_wrapper_cfg);
	endfunction : build_phase


	task run_phase(uvm_phase phase);
		super.run_phase(phase);
		phase.raise_objection(this);
		 `uvm_info("run_phase","Reset asserted", UVM_LOW)
		 reset_seq.start(env.agt.sqr);
		 `uvm_info("run_phase","Reset Deasserted", UVM_LOW)

		 `uvm_info("run_phase","stimulus generation started", UVM_LOW)
		 repeat(1000)begin
			//write address sequence
			write_addr_seq.start(env.agt.sqr);
			//write data sequence
			write_data_seq.start(env.agt.sqr);
		 end
		 repeat(100)begin
			//write address sequence
			read_addr_seq.start(env.agt.sqr);
			//write data sequence
			read_data_seq.start(env.agt.sqr);
		 end 
		 repeat(10)begin
			//write address sequence
			write_addr_seq.start(env.agt.sqr);
			//write data sequence
			write_data_seq.start(env.agt.sqr);
		 end
		 `uvm_info("run_phase","Stimulus Deasserted", UVM_LOW)
		phase.drop_objection(this);	
	endtask : run_phase

endclass : spi_wrapper_test
endpackage : spi_wrapper_test_pkg