`timescale 1ns/1ps
module tb_top;
 import uvm_pkg::*; import apb_pkg::*; `include "uvm_macros.svh"
 logic pclk,presetn;
 apb_if apb_vif(.pclk(pclk),.presetn(presetn));
 apb3_slave dut(.pclk(pclk),.presetn(presetn),.paddr(apb_vif.paddr),.psel(apb_vif.psel),.penable(apb_vif.penable),.pwrite(apb_vif.pwrite),.pwdata(apb_vif.pwdata),.prdata(apb_vif.prdata),.pready(apb_vif.pready),.pslverr(apb_vif.pslverr));
 initial begin pclk=0; forever #5 pclk=~pclk; end
 initial begin presetn=0; repeat(3) @(posedge pclk); presetn=1; end
 initial begin uvm_config_db#(virtual apb_if)::set(null,"uvm_test_top","vif",apb_vif); run_test("apb_smoke_test"); end
endmodule
