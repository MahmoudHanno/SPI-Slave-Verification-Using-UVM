
package spi_wrapper_monitor_pkg;
import spi_wrapper_seq_item_pkg::*;
import uvm_pkg::*;
`include "uvm_macros.svh"
class spi_wrapper_monitor extends uvm_monitor;
   `uvm_component_utils(spi_wrapper_monitor)
virtual spi_wrapper_if spi_wrapper_vif;
virtual spi_wrapper_G_if spi_wrapper_G_vif;
    spi_wrapper_seq_item rsp_seq_item;
   uvm_analysis_port #(spi_wrapper_seq_item) mon_ap;
   
   

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
         rsp_seq_item = spi_wrapper_seq_item::type_id::create("rsp_seq_item");
         @(negedge spi_wrapper_vif.clk);
         rsp_seq_item.SS_n = spi_wrapper_vif.SS_n;
         rsp_seq_item.MISO = spi_wrapper_vif.MISO;
         rsp_seq_item.rst_n = spi_wrapper_vif.rst_n;
         rsp_seq_item.MOSI = spi_wrapper_vif.MOSI;

         rsp_seq_item.SS_n_G = spi_wrapper_G_vif.SS_n;
         rsp_seq_item.MISO_G = spi_wrapper_G_vif.MISO;
         rsp_seq_item.rst_n_G = spi_wrapper_G_vif.rst_n;
         rsp_seq_item.MOSI_G = spi_wrapper_G_vif.MOSI;

         

         mon_ap.write(rsp_seq_item);
        `uvm_info("run_phase",rsp_seq_item.convert2string(),UVM_HIGH)
      end
   endtask : run_phase
endclass : spi_wrapper_monitor
endpackage : spi_wrapper_monitor_pkg