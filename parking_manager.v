module parking_manager(
    input clk,
    input rst,
    input btn_in,
    input btn_out,
    input [7:0] sw,
    output reg [7:0] led2,
    output reg [15:0] bcd_time,
    output reg show_enable,
    output reg [2:0] query_id,
    output reg [3:0] remain_num
);

    // debounce pulse
    wire in_pulse, out_pulse;
    debounce_onepulse db_in(.clk(clk), .rst(rst), .btn_in(btn_in), .btn_pulse(in_pulse));
    debounce_onepulse db_out(.clk(clk), .rst(rst), .btn_in(btn_out), .btn_pulse(out_pulse));

    reg [7:0] used;         // 1=該格有人
    reg [7:0] paused;       // 1=該格已停計時
    reg [15:0] timers[7:0]; // 8組BCD計時
    reg [3:0] remain;

    // 1Hz clock
    wire clk_1hz;
    clk_div #(.MAX(100_000_000/2-1)) u_clk_div(
        .clk_in(clk),
        .rst(rst),
        .clk_out(clk_1hz)
    );

    // 產生 1Hz 單脈衝
    reg prev_clk_1hz;
    always @(posedge clk or posedge rst) begin
        if(rst) prev_clk_1hz <= 0;
        else    prev_clk_1hz <= clk_1hz;
    end
    wire pulse_1hz = (~prev_clk_1hz) & clk_1hz;

    integer i, found;
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            used <= 8'b0;
            paused <= 8'b0;
            remain <= 8;
            led2 <= 8'b0;
            remain_num <= 8;
            for (i = 0; i < 8; i = i + 1) timers[i] <= 0;
        end else begin
            led2 <= used;
            remain_num <= remain;

            // 計時 (僅在1Hz脈衝時進行BCD遞增)
            if (pulse_1hz) begin
                for (i = 0; i < 8; i = i + 1) begin
                    if (used[i] && !paused[i] && timers[i] < 16'd9999) begin
                        // --- BCD加法 ---
                        if(timers[i][3:0] < 9)
                            timers[i][3:0] <= timers[i][3:0] + 1;
                        else begin
                            timers[i][3:0] <= 0;
                            if(timers[i][7:4] < 9)
                                timers[i][7:4] <= timers[i][7:4] + 1;
                            else begin
                                timers[i][7:4] <= 0;
                                if(timers[i][11:8] < 9)
                                    timers[i][11:8] <= timers[i][11:8] + 1;
                                else begin
                                    timers[i][11:8] <= 0;
                                    if(timers[i][15:12] < 9)
                                        timers[i][15:12] <= timers[i][15:12] + 1;
                                    else
                                        timers[i][15:12] <= 0;
                                end
                            end
                        end
                    end
                end
            end

            // 入場
            if (in_pulse && remain > 0) begin
                found = 0;
                for (i = 0; i < 8; i = i + 1) begin
                    if (!used[i] && !found) begin
                        used[i] <= 1;
                        paused[i] <= 0;
                        timers[i] <= 0;
                        remain <= remain - 1;
                        found = 1;
                    end
                end
            end
            // 出場
            else if (out_pulse) begin
                found = 0;
                for (i = 0; i < 8; i = i + 1) begin
                    if (sw[i] && used[i] && !paused[i] && !found) begin
                        used[i] <= 0;
                        paused[i] <= 1;
                        remain <= remain + 1;
                        found = 1;
                    end
                end
            end
        end
    end

    // 查詢顯示
    always @(*) begin
        bcd_time = 16'd0;
        show_enable = 1'b0;
        query_id = 0;
        for (i = 0; i < 8; i = i + 1) begin
            if (sw[i]) begin
                bcd_time = timers[i];
                show_enable = 1'b1;
                query_id = i[2:0];
            end
        end
    end

endmodule