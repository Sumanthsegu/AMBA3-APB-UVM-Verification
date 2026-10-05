class apb_base_test extends uvm_test;
 `uvm_component_utils(apb_base_test) apb_env env; virtual apb_if vif;
 function new(string name="apb_base_test",uvm_component parent=null); super.new(name,parent); endfunction
 function void build_phase(uvm_phase phase); super.build_phase(phase); env=apb_env::type_id::create("env",this); if(!uvm_config_db#(virtual apb_if)::get(this,"","vif",vif)) `uvm_fatal("NOVIF","Virtual interface not found"); uvm_config_db#(virtual apb_if)::set(this,"env.agent.*","vif",vif); endfunction
endclass
