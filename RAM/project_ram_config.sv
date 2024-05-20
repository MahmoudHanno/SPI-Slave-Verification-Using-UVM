package project_ram_config_pkg;
import uvm_pkg::*;
`include "uvm_macros.svh"
class project_ram_config extends uvm_object;
`uvm_object_utils(project_ram_config)

virtual project_ram_if project_ram_vif;

function new( string name="project_ram_config");
	super.new(name);
endfunction : new
endclass : project_ram_config
endpackage : project_ram_config_pkg
