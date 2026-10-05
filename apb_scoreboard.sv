class apb_scoreboard extends uvm_scoreboard;

  `uvm_component_utils(apb_scoreboard)

  uvm_analysis_imp #(apb_transaction, apb_scoreboard) analysis_export;

  bit [31:0] refmem [bit [7:0]];

  function new(string name = "apb_scoreboard",
               uvm_component parent = null);
    super.new(name, parent);
    analysis_export = new("analysis_export", this);
  endfunction

  function void write(apb_transaction tr);

    bit [31:0] exp;

    if (tr.write) begin
      // Store written data in reference memory
      refmem[tr.addr] = tr.wdata;
    end
    else begin

      // Get expected read data
      if (refmem.exists(tr.addr))
        exp = refmem[tr.addr];
      else
        exp = 32'h00000000;

      // Check for unexpected slave error
      if (tr.slverr) begin
        `uvm_error("SCOREBOARD",
                   "Unexpected error on valid read")
      end
      else if (tr.rdata !== exp) begin
        `uvm_error("SCOREBOARD",
                   $sformatf("READ MISMATCH addr=%02h exp=%08h got=%08h",
                             tr.addr, exp, tr.rdata))
      end
      else begin
        `uvm_info("SCOREBOARD",
                  "READ PASS",
                  UVM_MEDIUM)
      end

    end

  endfunction

endclass
