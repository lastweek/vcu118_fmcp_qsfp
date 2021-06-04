// Generator : SpinalHDL v1.4.4    git head : 2d165489e84bc6f3f59eeb1d693de5465823c6e1
// Component : AxisPktGen_512
// Git hash  : 6a80a1b2b2d38b42e75ce187d62b91d907a66cfa



module AxisPktGen_512 (
  input               enable,
  output              out_tvalid,
  input               out_tready,
  output              out_tlast,
  output     [511:0]  out_tdata,
  output     [63:0]   out_tkeep,
  output     [0:0]    out_tuser
);

  assign out_tlast = 1'b0;
  assign out_tvalid = 1'b0;
  assign out_tdata = 512'h0;
  assign out_tkeep = 64'h0;
  assign out_tuser = 1'b0;

endmodule
