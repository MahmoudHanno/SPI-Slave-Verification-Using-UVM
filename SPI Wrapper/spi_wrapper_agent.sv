package spi_wrapper_agent_pkg;
import spi_wrapper_config_pkg::*;
import spi_wrapper_driver_pkg::*;
import spi_wrapper_sqr_pkg::*;
import spi_wrapper_monitor_pkg::*;
import spi_wrapper_seq_item_pkg::*;
import uvm_pkg::*;
`include "uvm_macros.svh"

class spi_wrapper_agent extends uvm_agent;
   `uvm_component_utils(spi_wrapper_agent)
   spi_wrapper_sqr sqr;
   spi_wrapper_driver drv;
   spi_wrapper_monitor mon;
   spi_wrapper_config spi_wrapper_cfg;
   uvm_analysis_port #(spi_wrapper_seq_item) agt_ap;

   function new(string name = "spi_wrapper_agent", uvm_component parent=null);
      super.new(name, parent);
   endfunction : new

   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      if (!uvm_config_db #(spi_wrapper_config)::get(this, "", "CFG", spi_wrapper_cfg))
         `uvm_fatal("Build Phase", {"Unable to get configuration object for ", get_full_name(), " in ", get_parent().get_full_name()});
      sqr = spi_wrapper_sqr::type_id::create("sqr", this);
      drv = spi_wrapper_driver::type_id::create("drv", this);
      mon = spi_wrapper_monitor::type_id::create("mon", this);
      agt_ap = new("agt_ap", this);
   endfunction : build_phase

   virtual function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);
      drv.spi_wrapper_vif = spi_wrapper_cfg.spi_wrapper_vif;
      mon.spi_wrapper_vif = spi_wrapper_cfg.spi_wrapper_vif;
      drv.spi_wrapper_G_vif = spi_wrapper_cfg.spi_wrapper_G_vif;
      mon.spi_wrapper_G_vif = spi_wrapper_cfg.spi_wrapper_G_vif;

        drv.seq_item_port.connect(sqr.seq_item_export);
        mon.mon_ap.connect(agt_ap);
   endfunction : connect_phase
endclass : spi_wrapper_agent
endpackage : spi_wrapper_agent_pkg