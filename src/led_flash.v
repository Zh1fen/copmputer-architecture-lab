// 模块名称：led
// 功能描述：输入时钟信号，计时0.5秒后翻转IO_voltage信号，实现周期为1秒的方波输出-
module led(
    input  Clock,           // 时钟输入
    output IO_voltage       // 方波输出
);

// 参数定义
parameter COUNT_VALUE = 24'd13_499_999;  // 0.5秒计数值（假设时钟为27MHz）

// 内部信号定义
reg [23:0] count_value_reg = 24'd0;      // 计数器寄存器，初始为0
reg        count_value_flag = 1'b0;      // 翻转标志
reg        IO_voltage_reg = 1'b0;        // IO输出寄存器，初始为0

// 计数器逻辑：每到达0.5秒，产生一次翻转标志
always @(posedge Clock) begin
    if (count_value_reg < COUNT_VALUE) begin
        count_value_reg  <= count_value_reg + 1'b1; // 继续计数
        count_value_flag <= 1'b0;                   // 不翻转
    end else begin
        count_value_reg  <= 24'd0;                  // 计数器清零
        count_value_flag <= 1'b1;                   // 产生翻转标志
    end
end


// 输出信号翻转逻辑：收到翻转标志时翻转输出电平
always @(posedge Clock) begin
    if (count_value_flag)
        IO_voltage_reg <= ~IO_voltage_reg;          // 翻转输出
    // else分支可以省略，保持原值
end

// IO端口输出
assign IO_voltage = IO_voltage_reg;

endmodule