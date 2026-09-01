// 通用分頻器
module clk_div #(parameter MAX=49999)(
    input clk_in,
    input rst,
    output reg clk_out
);
    reg [$clog2(MAX):0] cnt;
    always @(posedge clk_in or posedge rst) begin
        if(rst) begin
            cnt <= 0;
            clk_out <= 0;
        end else if(cnt == MAX) begin
            cnt <= 0;
            clk_out <= ~clk_out;
        end else
            cnt <= cnt + 1;
    end
endmodule