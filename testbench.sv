module traffic_signal_tb;
  logic x,clk,reset;
  logic [1:0]hwy_signal,cntry_road_signal;
  logic [2:0]state_out,next_state_out;
  
  traffic_signal dut(
    .x(x),
    .clk(clk),
    .reset(reset),
    .hwy_signal(hwy_signal),
    .cntry_road_signal(cntry_road_signal),
    .state_out(state_out),
    .next_state_out(next_state_out)
  );
  
  always #5 clk=~clk;
  
   initial begin
      $dumpfile("dump.vcd");
      $dumpvars;
      clk=0;
      x = 0;
      reset = 1;
      #10 reset = 0;
     $monitor("%0t\t x=%b\t state=%0d\t --> \t next state=%0d\t Hwy=%b\t Country=%b", 
         $time, x, state_out,next_state_out,hwy_signal, cntry_road_signal);
      #15 x = 1; 
      #20 x = 0; 
      #25 x = 1; 
      #30 x = 0; 
      #35 x = 0;
      $finish;
  end
endmodule
  
