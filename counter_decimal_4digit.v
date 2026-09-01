// 四位數BCD顯示（共陰極動態掃描）
// bcd_in: 16bit, [15:12]千 [11:8]百 [7:4]十 [3:0]個
module counter_decimal_4digit(
    input clk,
    input rst,
    input [15:0] bcd_in,
    input enable, // 1=顯示, 0=全滅
    output [7:0] seg_code,
    output [3:0] scan
);
    wire clk_1khz;
    clk_div #(.MAX(50_000-1)) u_clk1k(
        .clk_in(clk),
        .rst(rst),
        .clk_out(clk_1khz)
    );

    reg [1:0] scan_sel;
    reg [3:0] digit;

    always @(posedge clk_1khz or posedge rst) begin
        if(rst)
            scan_sel <= 0;
        else
            scan_sel <= scan_sel + 1;
    end

    always @(*) begin
        case(scan_sel)
            2'd0: digit = bcd_in[3:0];
            2'd1: digit = bcd_in[7:4];
            2'd2: digit = bcd_in[11:8];
            2'd3: digit = bcd_in[15:12];
            default: digit = 4'd0;
        endcase
    end

    assign scan = enable ? (4'b0001 << scan_sel) : 4'b0000;

    led_decoder u_decoder(
        .in(digit),
        .seg_code(seg_code)
    );
endmodule