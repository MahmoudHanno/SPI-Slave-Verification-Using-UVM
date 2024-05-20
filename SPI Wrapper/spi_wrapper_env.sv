package spi_wrapper_env_pkg;
import spi_wrapper_agent_pkg::*;
import spi_wrapper_coverage_pkg::*;
import spi_wrapper_scoreboard_pkg::*;
import uvm_pkg::*;
`include "uvm_macros.svh"
class spi_wrapper_env extends uvm_env;
	`uvm_component_utils(spi_wrapper_env)

	spi_wrapper_agent agt;
	spi_wrapper_coverage cov;
	spi_wrapper_scoreboard sb;
	function new(string name="spi_wrapper_env", uvm_component parent = null);
		super.new(name,parent);
	endfunction : new

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		agt= spi_wrapper_agent::type_id::create("agt",this);
		cov=spi_wrapper_coverage::type_id::create("cov",this);
		sb=spi_wrapper_scoreboard::type_id::create("sb",this);
	endfunction

	function void connect_phase(uvm_phase phase);
		agt.agt_ap.connect(cov.cov_export);
		agt.agt_ap.connect(sb.sb_export);
	endfunction
endclass : spi_wrapper_env
endpackage : spi_wrapper_env_pkg