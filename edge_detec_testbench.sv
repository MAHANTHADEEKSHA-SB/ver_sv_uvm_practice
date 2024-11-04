// Code your testbench here
// or browse Examples

module tb_top;
  reg clk;
  reg reset;
  wire [7 : 0] pedge,pedge_1;
  reg [7 : 0] in;
  
  initial begin
    clk = 1'b1;
    reset = 1'b1;
  end
  
  `include "file_name.sv"
  
  always#5 clk = ~clk;
  //Design Module
  edd_top DUT (.clk(clk),.reset(reset),.in(in),.pedge(pedge),.pedge_1(pedge_1));
  
  initial begin
    @(posedge clk)reset = 1'b0;
    @(posedge clk)reset = 1'b1;
    @(posedge clk)reset = 1'b1;in <= '0;
    @(posedge clk)in <= 8'h2;
    repeat(3)begin
      @(posedge clk);
    end
    @(posedge clk) in <= 8'he;
    @(posedge clk) in <= '0;
    @(posedge clk) in <= 8'h2;
    repeat(9)begin
      @(posedge clk);
    end
    $finish();
  end
  
  initial begin
    $dumpvars;
    $dumpfile("dump.vcd");
  end
endmodule : tb_top