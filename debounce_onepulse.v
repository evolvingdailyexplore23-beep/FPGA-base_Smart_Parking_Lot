module debounce_onepulse(
    input clk,
    input rst,
    input btn_in,
    output reg btn_pulse
);
    reg btn_sync_0, btn_sync_1, btn_sync_2;
    reg [15:0] cnt;
    reg btn_state, btn_state_d;

    // sync
    always @(posedge clk) begin
        btn_sync_0 <= btn_in;
        btn_sync_1 <= btn_sync_0;
        btn_sync_2 <= btn_sync_1;
    end

    // debounce
    always @(posedge clk or posedge rst) begin
        if(rst) begin
            cnt <= 0;
            btn_state <= 0;
        end else if(btn_sync_2 != btn_state) begin
            cnt <= cnt + 1;
            if(cnt == 16'hffff) begin
                btn_state <= btn_sync_2;
                cnt <= 0;
            end
        end else
            cnt <= 0;
    end

    // one-pulse
    always @(posedge clk) begin
        btn_state_d <= btn_state;
        btn_pulse <= btn_state & ~btn_state_d;
    end
endmodule