package project_ram_scoreboard_pkg;
import project_ram_seq_item_pkg::*;
import uvm_pkg::*;
`include "uvm_macros.svh"
class project_ram_scoreboard extends uvm_scoreboard;
	`uvm_component_utils(project_ram_scoreboard)
    uvm_analysis_port #(project_ram_seq_item) sb_export;
    uvm_tlm_analysis_fifo #(project_ram_seq_item) sb_fifo;
    project_ram_seq_item seq_item_sb;
    logic [7:0] dataout_ref;
    logic [7:0] memory[0:255];
    logic [7:0] address_write, address_read;
    logic tx_valid_ref;
    int error_count=0;
    int correct_count=0;

	function new(string name="project_ram_scoreboard", uvm_component parent = null);
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
            compare(seq_item_sb);
        end
    endtask : run_phase

    function void compare(project_ram_seq_item seq_item_compare);
        if(seq_item_compare.din[9:8]==2'b00) begin
            address_write=seq_item_compare.din[7:0];
            tx_valid_ref=0;
        end
        if(seq_item_compare.din[9:8]==2'b01) begin
            memory[address_write]=seq_item_compare.din[7:0];
            tx_valid_ref=0;
        end 
        if(seq_item_compare.din[9:8]==2'b10) begin
            address_read=seq_item_compare.din[7:0];
            tx_valid_ref=0;  
        end
        if(seq_item_compare.din[9:8]==2'b11) begin
            dataout_ref=memory[address_read];
            tx_valid_ref=1;
            if(seq_item_compare.dout[7:0]==dataout_ref) begin
                `uvm_info(get_type_name(),$sformatf("Data Address= %d, Data Matched=  %h",address_read,seq_item_compare.dout[7:0]),UVM_LOW);
                correct_count++;
            end
            else begin
                `uvm_error(get_type_name(),$sformatf("Data Address= %d, Data Mismatched=  %h",address_read,seq_item_compare.dout[7:0]));
                error_count++;
            end  
        end
        if(seq_item_compare.tx_valid==tx_valid_ref) begin
            `uvm_info(get_type_name(),$sformatf("TX_VALID Matched= %h",seq_item_compare.tx_valid),UVM_LOW);
            correct_count++;
        end
        else begin
            `uvm_error(get_type_name(),$sformatf("TX_VALID Mismatched= %h",seq_item_compare.tx_valid));
            error_count++;
        end

    endfunction : compare
endclass : project_ram_scoreboard
endpackage : project_ram_scoreboard_pkg