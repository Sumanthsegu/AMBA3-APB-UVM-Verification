class apb_smoke_test extends apb_base_test;
 `uvm_component_utils(apb_smoke_test)
 function new(string name="apb_smoke_test",uvm_component parent=null); super.new(name,parent); endfunction
 task run_phase(uvm_phase phase);
  apb_write_sequence wr; apb_read_sequence rd; apb_random_sequence rnd;
  phase.raise_objection(this);
  wr=apb_write_sequence::type_id::create("wr"); wr.addr=8'h10; wr.data=32'h12345678; wr.start(env.agent.sequencer);
  rd=apb_read_sequence::type_id::create("rd"); rd.addr=8'h10; rd.start(env.agent.sequencer);
  rnd=apb_random_sequence::type_id::create("rnd"); rnd.start(env.agent.sequencer);
  #100ns; phase.drop_objection(this);
 endtask
endclass
