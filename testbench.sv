//------------------------------------------------------------------------------
// Module: top
//------------------------------------------------------------------------------
`include "test.svh"
module top;
   import uvm_pkg::*;

   reg clk;
    initial begin
      clk = 0;
      #5ns ;
      forever #5ns clk = ! clk;
   end
   
   jelly_bean_if     jb_if( clk );
   jelly_bean_taster jb_taster( jb_if );

   jelly_bean_reg_hw_reset_test t0;
   jelly_bean_reg_test t1;

   initial begin
     $dumpfile( "dump.vcd" );
     $dumpvars;
   end

   initial begin
      uvm_config_db#( virtual jelly_bean_if )::set( .cntxt( null ), 
                                                    .inst_name( "uvm_test_top" ),
                                                    .field_name( "jb_if" ),
                                                    .value( jb_if ) );
      run_test("jelly_bean_reg_hw_reset_test");
      //#1000
      //run_test("jelly_bean_reg_hw_reset_test");
      //目前只能一次跑一个run_test,以后应该用config做下替换就可以跑多几个run_test了
   end
endmodule: top

//==============================================================================
// Copyright (c) 2011-2015 ClueLogic, LLC
// http://cluelogic.com/
//==============================================================================

