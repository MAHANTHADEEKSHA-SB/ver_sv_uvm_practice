// Code your design here
module edd_dtc(clk,reset,in,pedge);
  input clk;
  input reset;
  input in;
  output reg pedge;
  
  reg prev;
  
  always@(posedge clk or negedge reset)begin
    if(!reset)begin
      pedge <= 1'b0;
      prev <= 1'b0;
    end
    else begin
      prev <= in;
      if((in == 1'b1)&&(prev == 1'b0))begin
        pedge <= 1'b1;
      end
      else begin
        pedge <= 1'b0;
      end
    end
  end
endmodule : edd_dtc

module edd_top(clk,reset,in,pedge,pedge_1);
  input wire clk;
  input wire reset;
  input wire [7 : 0] in;
  output wire [7 : 0] pedge;
  output reg [7 : 0] pedge_1;
  
  reg [7 : 0] prev;
  
  //using generate loop
  genvar i;
  generate
    for(i = 0;i < 8;i = i + 1)begin : dtc_gen
      edd_dtc EDGE_DTC(.clk(clk),.reset(reset),.in(in[i]),.pedge(pedge[i]));
    end
  endgenerate
  
  //using bitwise expression
  always@(posedge clk or negedge reset)begin
    if(!reset)begin
      pedge_1 <= '0;
      prev <= '0;
    end
    else begin
      prev <= in;
      pedge_1 <= in & ~prev;
    end
  end
endmodule : edd_top