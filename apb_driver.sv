class apb_driver extends uvm_driver #(apb_transaction);
 `uvm_component_utils(apb_driver) virtual apb_if vif;
 function new(string name="apb_driver",uvm_component parent=null); super.new(name,parent); endfunction
 function void build_phase(uvm_phase phase); super.build_phase(phase); if(!uvm_config_db#(virtual apb_if)::get(this,"","vif",vif)) `uvm_fatal("NOVIF","APB virtual interface not found"); endfunction
 task run_phase(uvm_phase phase); forever begin seq_item_port.get_next_item(req); drive_transfer(req); seq_item_port.item_done(); end endtask
 task drive_transfer(apb_transaction tr);
  vif.drv_cb.psel<=0; vif.drv_cb.penable<=0; vif.drv_cb.pwrite<=0; @(vif.drv_cb);
  vif.drv_cb.psel<=1; vif.drv_cb.penable<=0; vif.drv_cb.pwrite<=tr.write; vif.drv_cb.paddr<=tr.addr; vif.drv_cb.pwdata<=tr.wdata; @(vif.drv_cb);
  vif.drv_cb.penable<=1; do @(vif.drv_cb); while(!vif.drv_cb.pready);
  tr.rdata=vif.drv_cb.prdata; tr.slverr=vif.drv_cb.pslverr;
  vif.drv_cb.psel<=0; vif.drv_cb.penable<=0; vif.drv_cb.pwrite<=0; @(vif.drv_cb);
 endtask
endclass
