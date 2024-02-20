module Sram #(
    EleLen = 32,
    EleIdxWidth = 10,
    NumEle = 2 ** EleIdxWidth
) (
    input logic rst,
    input logic clk,
    // whether the reply in the cycle valid or not
    input logic valid,
    input logic read_or_write,
    input logic [EleLen-1: 0] write_ele,
    input logic [EleIdxWidth-1: 0] addr,
    output logic ready,
    output logic [EleLen-1: 0] read_ele
);

generate
    genvar i;
    for (i = 0; i < NumEle; i = i + 1) begin
        Reg #(EleLen, 0) ele (clk, rst, write_ele, read_ele, addr==i);
    end
endgenerate

endmodule