class apb_monitor extends uvm_monitor;
 `uvm_component_utils(apb_monitor) virtual apb_if vif; uvm_analysis_port #(apb_transaction) ap;
 function new(string name="apb_monitor",uvm_component parent=null); super.new(name,parent); ap=new("ap",this); endfunction
 function void build_phase(uvm_phase phase); super.build_phase(phase); if(!uvm_config_db#(virtual apb_if)::get(this,"","vif",vif)) `uvm_fatal("NOVIF","APB virtual interface not found"); endfunction
 task run_phase(uvm_phase phase); forever begin @(vif.mon_cb); if(vif.mon_cb.psel&&vif.mon_cb.penable&&vif.mon_cb.pready) begin apb_transaction tr=apb_transaction::type_id::create("tr"); tr.addr=vif.mon_cb.paddr; tr.write=vif.mon_cb.pwrite; tr.wdata=vif.mon_cb.pwdata; tr.rdata=vif.mon_cb.prdata; tr.slverr=vif.mon_cb.pslverr; ap.write(tr); end end endtask
endclass
