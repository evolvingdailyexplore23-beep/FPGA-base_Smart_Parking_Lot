`timescale 1ns / 1ps

module main_top(
    input clk,
    input rst,
    input [1:0] btn,         // btn[0]=R11(S0), btn[1]=V1(S3)
    input [7:0] sw,
    output [7:0] seg_code_c, // G2~H1(查詢時間)
    output [3:0] show_c,
    output [7:0] seg_code_s, // G6 (剩餘車位)
    output [3:0] show_s,
    output [7:0] led2        // D7~D0
);

    // 停車場管理
    wire [15:0] bcd_time;
    wire show_enable;
    wire [2:0] query_id;
    wire [3:0] remain_num;

    parking_manager u_pm(
        .clk(clk),
        .rst(rst),
        .btn_in(btn[0]),
        .btn_out(btn[1]),
        .sw(sw),
        .led2(led2),
        .bcd_time(bcd_time),
        .show_enable(show_enable), // 只輸出enable訊號
        .query_id(query_id),
        .remain_num(remain_num)
    );

    // 查詢時間顯示到G2~H1
    wire [3:0] scan_c;
    counter_decimal_4digit u_counter_disp(
        .clk(clk),
        .rst(rst),
        .bcd_in(bcd_time),
        .enable(show_enable), // 由parking_manager決定是否顯示
        .seg_code(seg_code_c),
        .scan(scan_c)
    );
    assign show_c = show_enable ? scan_c : 4'b0000;

    // 剩餘車格數顯示到G6
    space u_space(
        .clk(clk),
        .rst(rst),
        .remain_num(remain_num),
        .num(seg_code_s),
        .show(show_s)
    );
endmodule