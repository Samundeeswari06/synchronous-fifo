// Code your testbench here
// or browse Examples
module tb_sync_fifo;
  reg clk, reset, wr_en, rd_en;
  reg [7:0] din;
  wire [7:0] dout;
  wire full, empty;
  sync_fifo fifo_inst(
    .clk(clk),
    .reset(reset),
    .wr_en(wr_en),
    .rd_en(rd_en),
    .din(din),
    .dout(dout),
    .full(full),
    .empty(empty)
  );
  always #5 clk = ~clk;
    initial begin
      $monitor("Time = %0t | wr_en = %b | rd_en = %b | din = %h | dout = %h | full = %b | empty = %b", $time, wr_en, rd_en, din, dout, full, empty);
      $dumpfile("sync_fifo.vcd");
      $dumpvars;
      clk = 0;
      reset = 1; 
      wr_en = 0;
      rd_en = 0;
      din = 8'h00;
      #10 reset = 0;
      wr_en = 1;
      din = 8'hA1;
      din = 8'hB2; #10;
      din = 8'hC3; #10;
      wr_en = 0;
      rd_en = 1; #10;
      #10; rd_en = 0;
      wr_en = 1;
      din = 8'hE5; #10;
      wr_en = 0;
      rd_en = 1; #50;
      rd_en = 0;
      $finish;
    end 
endmodule