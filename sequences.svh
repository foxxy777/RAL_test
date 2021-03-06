//------------------------------------------------------------------------------
// Class: jelly_bean_sequence
//------------------------------------------------------------------------------
`ifndef SEQUENCERS_SVH
`define SEQUENCERS_SVH

`include "transactions.svh"
`include "ral.svh"

class jelly_bean_sequence extends uvm_sequence#( jelly_bean_transaction );
   `uvm_object_utils( jelly_bean_sequence )

   function new( string name = "" );
      super.new( name );
   endfunction: new

   task body();
      jelly_bean_transaction jb_tx;
      jb_tx = jelly_bean_transaction::type_id::create( .name( "jb_tx" ) );
      start_item( jb_tx );
      jb_tx.flavor     = jelly_bean_types::APPLE;
      jb_tx.color      = jelly_bean_types::GREEN;
      jb_tx.sugar_free = 0;
      jb_tx.sour       = 1;
      finish_item(jb_tx);
   endtask: body
endclass: jelly_bean_sequence

//------------------------------------------------------------------------------
// Class: jelly_bean_reg_sequence
//------------------------------------------------------------------------------

class jelly_bean_reg_sequence extends uvm_reg_sequence;
   `uvm_object_utils( jelly_bean_reg_sequence )

   function new( string name = "" );
      super.new( name );
   endfunction: new

   virtual task body();
      jelly_bean_reg_block       jb_reg_block;
      jelly_bean_types::flavor_e flavor;
      jelly_bean_types::color_e  color;
      bit                        sugar_free;
      bit                        sour;
      uvm_status_e               status;
      uvm_reg_data_t             value;

      $cast( jb_reg_block, model );//model是系统自带的reg_block类型，我们操作的就是这个对象.
      //逻辑上应该是把系统的model对象，cast成我们自定义jb_reg_block形式
      //下面是赋值 （1）把我们在body当下定义的临时变量进行赋值
      flavor     = jelly_bean_types::APPLE;
      color      = jelly_bean_types::GREEN;
      sugar_free = 0;
      sour       = 1;
      //（2）大括号里面()的说把我们赋完值的临时变量给到当下body的jb_reg_block里面
      //（3）然后通过write_reg来把东西给到系统的model里面
      write_reg( jb_reg_block.jb_recipe_reg, status, { sour, sugar_free, color, flavor } );//应该这里是会去使用uvm库自带的op结构体，用UVM_WRITE
      read_reg( jb_reg_block.jb_taste_reg, status, value );
   endtask: body
     
endclass: jelly_bean_reg_sequence

`endif
//==============================================================================
// Copyright (c) 2011-2015 ClueLogic, LLC
// http://cluelogic.com/
//==============================================================================
