// 七段顯示器譯碼（共陰極，亮為1）
module led_decoder(
    input [3:0] in,
    output reg [7:0] seg_code
    );
    always@(*) begin
        case(in)
            4'h0: seg_code = 8'h3f;
            4'h1: seg_code = 8'h06;
            4'h2: seg_code = 8'h5b;
            4'h3: seg_code = 8'h4f;
            4'h4: seg_code = 8'h66;
            4'h5: seg_code = 8'h6d;
            4'h6: seg_code = 8'h7d;
            4'h7: seg_code = 8'h07;
            4'h8: seg_code = 8'h7f;
            4'h9: seg_code = 8'h6f;
            4'hA: seg_code = 8'h77;
            4'hB: seg_code = 8'h7c;
            4'hC: seg_code = 8'h39;
            4'hD: seg_code = 8'h5e;
            4'hE: seg_code = 8'h79;
            4'hF: seg_code = 8'h71;
            default: seg_code = 8'h3f;
        endcase
    end
endmodule