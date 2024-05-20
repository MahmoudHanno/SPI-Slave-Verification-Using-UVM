
package project_ram_monitor_pkg;
import project_ram_seq_item_pkg::*;
import uvm_pkg::*;
`include "uvm_macros.svh"
class project_ram_monitor extends uvm_monitor;
   `uvm_component_utils(project_ram_monitor)
virtual project_ram_if project_ram_vif;
    project_ram_seq_item rsp_seq_item;
   uvm_analysis_port #(project_ram_seq_item) mon_ap;
   
   

    function new(string name, uvm_component parent);
      super.new(name, parent);
    endfunction : new

    function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      mon_ap = new("mon_ap", this);
   endfunction : build_phase

    task run_phase(uvm_phase phase);
      super.run_phase(phase);
      forever begin
         rsp_seq_item = project_ram_seq_item::type_id::create("rsp_seq_item");
         @(negedge project_ram_vif.clk);
         rsp_seq_item.din = project_ram_vif.din;
         rsp_seq_item.rx_valid = project_ram_vif.rx_valid;
         rsp_seq_item.rst_n = project_ram_vif.rst_n;
         rsp_seq_item.tx_valid = project_ram_vif.tx_valid;
         rsp_seq_item.dout = project_ram_vif.dout;
         mon_ap.write(rsp_seq_item);
        `uvm_info("run_phase",rsp_seq_item.convert2string(),UVM_HIGH)
      end
   endtask : run_phase
endclass : project_ram_monitor
endpackage : project_ram_monitor_pkg