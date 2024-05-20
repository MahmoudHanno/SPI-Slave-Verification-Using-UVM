package project_ram_agent_pkg;
import project_ram_config_pkg::*;
import project_ram_driver_pkg::*;
import project_ram_sqr_pkg::*;
import project_ram_monitor_pkg::*;
import project_ram_seq_item_pkg::*;
import uvm_pkg::*;
`include "uvm_macros.svh"

class project_ram_agent extends uvm_agent;
   `uvm_component_utils(project_ram_agent)
   project_ram_sqr sqr;
   project_ram_driver drv;
   project_ram_monitor mon;
   project_ram_config project_ram_cfg;
   uvm_analysis_port #(project_ram_seq_item) agt_ap;

   function new(string name = "project_ram_agent", uvm_component parent=null);
      super.new(name, parent);
   endfunction : new

   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      if (!uvm_config_db #(project_ram_config)::get(this, "", "CFG", project_ram_cfg))
         `uvm_fatal("Build Phase", {"Unable to get configuration object for ", get_full_name(), " in ", get_parent().get_full_name()});
      sqr = project_ram_sqr::type_id::create("sqr", this);
      drv = project_ram_driver::type_id::create("drv", this);
      mon = project_ram_monitor::type_id::create("mon", this);
      agt_ap = new("agt_ap", this);
   endfunction : build_phase

   virtual function void connect_phase(uvm_phase phase);
      drv.project_ram_vif = project_ram_cfg.project_ram_vif;
      mon.project_ram_vif = project_ram_cfg.project_ram_vif;
        drv.seq_item_port.connect(sqr.seq_item_export);
        mon.mon_ap.connect(agt_ap);
   endfunction : connect_phase
endclass : project_ram_agent
endpackage : project_ram_agent_pkg