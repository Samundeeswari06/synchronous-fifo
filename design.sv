// Code your design here
module sync_fifo(
  input clk,
  input reset,
  input wr_en,
  input rd_en,
  input [7:0] din,
  output reg [7:0] dout,
  output full,
  output empty
);
  reg [7:0] mem [0:7];
  reg [2:0] wr_ptr = 0;
  reg [2:0] rd_ptr = 0;
  reg [3:0] count = 0;
  assign full = (count == 8);
  assign empty = (count == 0);
  always @(posedge clk or posedge reset) begin
    if(reset) begin
      wr_ptr <= 0;
      rd_ptr <= 0;
      count <= 0;
      dout <= 0;
    end else begin
      if(wr_en && !full) begin
        mem[wr_ptr] <= din;
        wr_ptr <= wr_ptr+1;
        count <= count+1;
      end
      if(rd_en && !empty) begin
        dout <= mem[rd_ptr];
        rd_ptr <= rd_ptr+1;
        count <= count-1;
      end 
    end
  end
endmodule