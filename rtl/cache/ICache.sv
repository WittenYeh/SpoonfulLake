/**
 * 这是一个片内的 ICache
 * 配置大小：8 KB
 * 2 way 组相联
 * offset 10位用于寻址
 */

`include "../common/Config.svh"

module ICache 
#(
    // size: 64B * 64 * 8 = 2^6 * 2^6 * 8 = 32 KB
    IndexBits = 6, // 2^6 = 64 sets
    OffsetBits = 6, // 2^6 = 64B
    BankBits = 2,
    NumWays = 8, 
    NumBanks = 2**BankBits
) 
(
    input logic clk,
    input logic rst,
    // this input port should use VIPT principle
    input logic [`INST_WIDTH-1: 0] target_addr,
    input logic valid,
    output logic [`INST_WIDTH-1: 0] fetched_inst,
    output logic ready
);


    
endmodule