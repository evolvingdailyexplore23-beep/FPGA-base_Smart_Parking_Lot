module led2_ctrl(
    input clk,
    input rst,
    input btn_r11,       // R11(S0)
    input btn_v1,        // V1(S3)
    input [7:0] sw,      // SW7~SW0
    output [7:0] led2    // D7~D0
);
    wire r11_pulse, v1_pulse;
    debounce_onepulse u_db_r11(.clk(clk), .rst(rst), .btn_in(btn_r11), .btn_pulse(r11_pulse));
    debounce_onepulse u_db_v1(.clk(clk), .rst(rst), .btn_in(btn_v1), .btn_pulse(v1_pulse));

    reg [7:0] led2_r;
    assign led2 = led2_r;

    integer i;
    reg found;

    always @(posedge clk or posedge rst) begin
        if(rst)
            led2_r <= 8'b0000_0000;
        else if(r11_pulse) begin
            found = 0;
            for(i=0;i<8;i=i+1) begin
                if(!led2_r[i] && !found) begin
                    led2_r[i] <= 1'b1;
                    found = 1;
                end
            end
        end else if(v1_pulse) begin
            for(i=0;i<8;i=i+1)
                if(sw[i]) led2_r[i] <= 1'b0;
        end
    end
endmodule