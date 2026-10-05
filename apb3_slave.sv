// Reference APB3 slave for this reconstructed portfolio environment.
// It is NOT claimed to be the original historical DUT.
module apb3_slave #(parameter int ADDR_WIDTH=8, DATA_WIDTH=32)(
 input logic pclk,presetn,input logic [ADDR_WIDTH-1:0] paddr,input logic psel,penable,pwrite,
 input logic [DATA_WIDTH-1:0] pwdata,output logic [DATA_WIDTH-1:0] prdata,
 output logic pready,pslverr);
 localparam int DEPTH=256; logic [DATA_WIDTH-1:0] mem[0:DEPTH-1];
 wire access=psel&&penable;
 always_comb begin
  pready=0; pslverr=0; prdata='0;
  if(access) begin
   pready=1;
   if(paddr<DEPTH) begin if(!pwrite) prdata=mem[paddr]; end
   else pslverr=1;
  end
 end
 always_ff @(posedge pclk or negedge presetn) begin
  if(!presetn) begin for(int i=0;i<DEPTH;i++) mem[i]<='0; end
  else if(access&&pwrite&&(paddr<DEPTH)) mem[paddr]<=pwdata;
 end
endmodule
