package spi_wrapper_scoreboard_pkg;
import spi_wrapper_seq_item_pkg::*;
import uvm_pkg::*;
`include "uvm_macros.svh"
class spi_wrapper_scoreboard extends uvm_scoreboard;
	`uvm_component_utils(spi_wrapper_scoreboard)
    uvm_analysis_port #(spi_wrapper_seq_item) sb_export;
    uvm_tlm_analysis_fifo #(spi_wrapper_seq_item) sb_fifo;
    spi_wrapper_seq_item seq_item_sb;
    
    logic [7:0] memory[0:255];
    logic MISO_ref,check_flag;
    logic [7:0] dataout_ref;
    logic [7:0] address_write, address_read;
    logic signed [4:0] counter=0;
    logic [3:0] MISO_counter=0;
    logic [9:0] MOSI_total;
    int error_count=0;
    int correct_count=0;
	function new(string name="spi_wrapper_scoreboard", uvm_component parent = null);
		super.new(name,parent);
	endfunction : new

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
        sb_export=new("sb_export",this);
        sb_fifo=new("sb_fifo",this);
	endfunction : build_phase

	function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        sb_export.connect(sb_fifo.analysis_export);
	endfunction : connect_phase

    task run_phase(uvm_phase phase);
        super.run_phase(phase);
        forever begin
           sb_fifo.get(seq_item_sb);
           if(seq_item_sb.MISO==seq_item_sb.MISO_G)begin
               correct_count++;
               `uvm_info("run_phase","Correct data received",UVM_LOW)
           end
           if(seq_item_sb.MISO!=seq_item_sb.MISO_G) begin
               error_count++;
               `uvm_error(get_type_name(),$sformatf(" Data Mismatched, MISO should be %b insteaed it is %b ", seq_item_sb.MISO_G, seq_item_sb.MISO));
           end
           
        end
    endtask : run_phase

endclass : spi_wrapper_scoreboard
endpackage : spi_wrapper_scoreboard_pkg