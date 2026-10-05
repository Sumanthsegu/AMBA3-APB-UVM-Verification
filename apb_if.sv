interface apb_if(input logic pclk,presetn);
 logic [7:0] paddr; logic psel,penable,pwrite; logic [31:0] pwdata,prdata; logic pready,pslverr;
 clocking drv_cb @(posedge pclk); default input #1step output #1step; output paddr,psel,penable,pwrite,pwdata; input prdata,pready,pslverr; endclocking
 clocking mon_cb @(posedge pclk); default input #1step; input paddr,psel,penable,pwrite,pwdata,prdata,pready,pslverr; endclocking
endinterface
