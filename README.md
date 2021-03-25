# FPGA DDS WAVE GENERATE

- **模块说明**

1. mif文件夹中为 sin tri rec三种波形 .mif文件
2. rom_ip存有该工程调用的rom ip核
3. uart_rx 、uart_tx、uart_test为串口通信模块
4. addr_ctrl 相位累加模块
5. key_test 按键模块
6. adda_out 顶层模块

- **调用说明**

1. 芯片型号：ALTERA   Cyclone IV   EP4CE6F17C8  
2. reset复位及初始态默认输出1000HZ正弦波，另三按键对应正弦、方波、三角波，可在三种波形间切换
3. 通过串口设置频率 10HZ-2MHZ可稳定输出
   - 串口设置格式 ‘ ’+所设置频率+‘s’
   - 例：'/n10000s'

