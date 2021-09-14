# FPGA DDS HMI

- **模块说明**
  - mif文件夹中为 sin tri rec三种波形 .mif文件
  - rom_ip存有该工程调用的rom ip核
  - uart_rx 、uart_tx、uart_test为串口通信模块
  - addr_ctrl 相位累加模块
  - key_test 按键模块
  - adda_out 顶层模块

- **调用说明**
  - 添加了串口屏，可以通过串口屏设置波形频率，8位DAC产生10hz-1Mhz正弦波、方波、三角波。幅值可调





