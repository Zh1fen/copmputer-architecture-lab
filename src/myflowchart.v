// 功能描述：6路流水灯，27MHz时钟
module led_flow(
    input  Clock,         // 时钟输入，27MHz，建议接RPIN04_SYS_CLK
    output [5:0] LED      // 6路LED输出，高电平点亮
);

// 参数定义
parameter COUNT_VALUE = 24'd13_499_999;  // 0.5秒计数值（27MHz）

// 内部信号定义
reg [23:0] count_value_reg = 24'd0;      // 计数器寄存器
reg        count_value_flag = 1'b0;      // 翻转标志
reg [2:0]  led_index = 3'd0;             // 当前点亮LED编号（0~5）
reg [5:0]  LED_reg = 6'b000001;          // LED输出寄存器，初始点亮LED0

// 计数器逻辑：每到达0.5秒，产生一次翻转标志
always @(posedge Clock) begin
    if (count_value_reg < COUNT_VALUE) begin
        count_value_reg  <= count_value_reg + 1'b1;
        count_value_flag <= 1'b0;
    end else begin
        count_value_reg  <= 24'd0;
        count_value_flag <= 1'b1;
    end
end

// LED流水逻辑：收到翻转标志时移动点亮的LED
always @(posedge Clock) begin
    if (count_value_flag) begin
        if (led_index < 5)
            led_index <= led_index + 1'b1;
        else
            led_index <= 3'd0;
    end
end

// 根据led_index生成LED输出
always @(*) begin
    LED_reg = 6'b000001 << led_index;
end

// 端口输出
assign LED = LED_reg;

endmodule