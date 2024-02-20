// 选择器模板内部实现
module MuxKeyInternal 
#(
    NUM_KEY = 2, 
    KEY_LEN = 1, 
    DATA_LEN = 1, 
    HAS_DEFAULT = 0
) 
(
  output reg [DATA_LEN-1: 0] out,
  input [KEY_LEN-1: 0] key,
  input [DATA_LEN-1: 0] default_out,
  input [NUM_KEY*(KEY_LEN + DATA_LEN)-1: 0] kv_pairs
);

  localparam PAIR_LEN = KEY_LEN + DATA_LEN;
  wire [PAIR_LEN-1:0] pair_list [NUM_KEY-1:0];
  wire [KEY_LEN-1:0] key_list [NUM_KEY-1:0];
  wire [DATA_LEN-1:0] data_list [NUM_KEY-1:0];

  genvar n;
  generate
    for (n = 0; n < NUM_KEY; n = n + 1) begin
      assign pair_list[n] = kv_pairs[PAIR_LEN*(n+1)-1 : PAIR_LEN*n];
      assign data_list[n] = pair_list[n][DATA_LEN-1 : 0];
      assign key_list[n]  = pair_list[n][PAIR_LEN-1 : DATA_LEN];
    end
  endgenerate

  reg [DATA_LEN-1 : 0] kv_pairs_out;
  reg hit;
  integer i;
  always @(*) begin
    kv_pairs_out = 0;
    hit = 0;
    for (i = 0; i < NUM_KEY; i = i + 1) begin
      kv_pairs_out = kv_pairs_out | ({DATA_LEN{key == key_list[i]}} & data_list[i]);
      hit = hit | (key == key_list[i]);
    end
    if (!HAS_DEFAULT) out = kv_pairs_out;
    else out = (hit ? kv_pairs_out : default_out);
  end
endmodule