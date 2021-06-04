// Generator : SpinalHDL v1.4.4    git head : 2d165489e84bc6f3f59eeb1d693de5465823c6e1
// Component : AxisSink_512
// Git hash  : 7eff51f53798e55158bf06590bd47abc5af9b83f



module AxisSink_512 (
  input               in_tvalid,
  output              in_tready,
  input               in_tlast,
  input      [511:0]  in_tdata,
  input      [63:0]   in_tkeep,
  input      [0:0]    in_tuser,
  input               clk,
  input               reset
);
  reg        [511:0]  tdata;
  reg        [63:0]   tkeep;
  reg        [7:0]    counter;
  reg                 isFirstFlit;
  reg                 isLastFlit;
  reg                 in_payload_first;

  assign in_tready = 1'b1;
  always @ (posedge clk) begin
    if(reset) begin
      counter <= 8'h0;
      in_payload_first <= 1'b1;
    end else begin
      if((in_tvalid && in_tready))begin
        in_payload_first <= in_tlast;
      end
      if((in_tvalid && in_tready))begin
        counter <= (counter + 8'h01);
      end
    end
  end

  always @ (posedge clk) begin
    isFirstFlit <= 1'b0;
    isLastFlit <= 1'b0;
    if(in_tvalid)begin
      tdata <= in_tdata;
      tkeep <= in_tkeep;
    end
    if((in_tvalid && in_payload_first))begin
      isFirstFlit <= 1'b1;
    end else begin
      if((in_tvalid && in_tlast))begin
        isLastFlit <= 1'b1;
      end
    end
  end


endmodule
