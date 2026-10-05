class apb_coverage extends uvm_subscriber #(apb_transaction);
 `uvm_component_utils(apb_coverage) apb_transaction tr;
 covergroup apb_cg;
  option.per_instance=1;
  cp_write: coverpoint tr.write { bins read={0}; bins write={1}; }
  cp_addr: coverpoint tr.addr { bins low={[8'h00:8'h1F]}; bins middle={[8'h20:8'hDF]}; bins high={[8'hE0:8'hFF]}; }
  cp_data: coverpoint tr.wdata { bins zero={32'h0}; bins ones={32'hFFFFFFFF}; bins aa={32'hAAAAAAAA}; bins five5={32'h55555555}; bins other=default; }
  cp_error: coverpoint tr.slverr { bins no_error={0}; bins error={1}; }
  write_x_addr: cross cp_write,cp_addr;
 endgroup
 function new(string name="apb_coverage",uvm_component parent=null); super.new(name,parent); apb_cg=new(); endfunction
 function void write(apb_transaction t); tr=t; apb_cg.sample(); endfunction
endclass
