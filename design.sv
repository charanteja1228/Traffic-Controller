module traffic_signal(
  input x,
  input clk,
  input reset,
  output reg [1:0]hwy_signal,cntry_road_signal,
  output logic [2:0] state_out,next_state_out
);
  typedef enum logic [2:0]{s0,s1,s2,s3,s4}state_t;
  typedef enum logic[1:0]{red,yellow,green}signal_t;
  
  state_t state,next_state;
  
  always @(posedge clk or posedge reset) begin
    if(reset)
      state<=s0;
    else
      state<=next_state;
  end
  
  always@(*)
    begin
      case(state) 

        s0 :begin
          hwy_signal=green;
          cntry_road_signal=red;
        end

        s1:begin
          hwy_signal=yellow;
          cntry_road_signal=red;
        end

        s2:begin
          hwy_signal=red;
          cntry_road_signal=red;
        end

        s3:begin
          hwy_signal=red;
          cntry_road_signal=green;
        end

        s4:begin
          hwy_signal=red;
          cntry_road_signal=yellow;
        end
     
      endcase
    end
  
  always @(*) begin
    
    case(state)
      s0:next_state=x?s1:s0;
      s1:next_state=s2;
      s2:next_state=s3;
      s3:next_state=x?s3:s4;
      s4:next_state=s0;
      default:next_state=s0;
    endcase
  end
  
  assign state_out=state;
  assign next_state_out=next_state;
  
endmodule
