package project_ram_env_pkg;
import project_ram_agent_pkg::*;
import project_ram_coverage_pkg::*;
import project_ram_scoreboard_pkg::*;
import uvm_pkg::*;
`include "uvm_macros.svh"
class project_ram_env extends uvm_env;
	`uvm_component_utils(project_ram_env)

	project_ram_agent agt;
	project_ram_coverage cov;
	project_ram_scoreboard sb;
	function new(string name="project_ram_env", uvm_component parent = null);
		super.new(name,parent);
	endfunction : new

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		agt= project_ram_agent::type_id::create("agt",this);
		cov=project_ram_coverage::type_id::create("cov",this);
		sb=project_ram_scoreboard::type_id::create("sb",this);
	endfunction

	function void connect_phase(uvm_phase phase);
		agt.agt_ap.connect(cov.cov_export);
		agt.agt_ap.connect(sb.sb_export);
	endfunction
endclass : project_ram_env
endpackage : project_ram_env_pkg