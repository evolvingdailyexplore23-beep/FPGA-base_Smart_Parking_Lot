// 顯示剩餘車格數於單顆七段（G6）
module space(
    input clk,
    input rst,
    input [3:0] remain_num, // 剩餘車位
    output [7:0] num,
    output [3:0] show
);
    // show=0001，僅顯示最低位
    assign show = 4'b0001;
    led_decoder u_led_decoder(.in(remain_num), .seg_code(num));
endmodule