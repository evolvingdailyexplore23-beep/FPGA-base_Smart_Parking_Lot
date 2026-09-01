// 4位十進制正數計數器（BCD），reset後從0000正數到9999再跳回0000
module bcd_counter(
    input clk,
    input rst,
    input enable,
    output reg [15:0] bcd // [15:12]千 [11:8]百 [7:4]十 [3:0]個
    );
    always@(posedge clk or posedge rst) begin
        if(rst)
            bcd <= 16'd0;   // reset時從0000開始
        else if(!enable) begin
            if(bcd == 16'd9999)
                bcd <= 16'd0;
            else begin
                // BCD遞增
                if(bcd[3:0] < 9) bcd[3:0] <= bcd[3:0] + 1;
                else begin
                    bcd[3:0] <= 0;
                    if(bcd[7:4] < 9) bcd[7:4] <= bcd[7:4] + 1;
                    else begin
                        bcd[7:4] <= 0;
                        if(bcd[11:8] < 9) bcd[11:8] <= bcd[11:8] + 1;
                        else begin
                            bcd[11:8] <= 0;
                            if(bcd[15:12] < 9) bcd[15:12] <= bcd[15:12] + 1;
                            else bcd[15:12] <= 0;
                        end
                    end
                end
            end
        end
    end
endmodule