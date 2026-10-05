class apb_scoreboard extends uvm_scoreboard;
 `uvm_component_utils(apb_scoreboard) uvm_analysis_imp #(apb_transaction,apb_scoreboard) analysis_export; bit [31:0] refmem[bit[7:0]];
 function new(string name="apb_scoreboard",uvm_component parent=null); super.new(name,parent); analysis_export=new("analysis_export",this); endfunction
 function void write(apb_transaction tr);
  if(tr.write) refmem[tr.addr]=tr.wdata;
  else begin bit [31:0] exp=refmem.exists(tr.addr)?refmem[tr.addr]:32'h0; if(tr.slverr) `uvm_error("SCOREBOARD","Unexpected error on valid read") else if(tr.rdata!==exp) `uvm_error("SCOREBOARD",$sformatf("READ MISMATCH addr=%02h exp=%08h got=%08h",tr.addr,exp,tr.rdata)); else `uvm_info("SCOREBOARD","READ PASS",UVM_MEDIUM); end
 endfunction
endclass
