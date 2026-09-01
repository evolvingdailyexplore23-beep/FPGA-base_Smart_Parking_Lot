# FPGA-Based Smart Parking Lot

Design and implement a smart parking lot management system using an FPGA board. The system includes the following features:
1. Vehicle entry and exit control
2. Parking time calculation and display
3. Parking space occupancy status and remaining space display
4. Parking space occupancy time inquiry

## 📝 檔案清單與功能說明

| File Name | Module Level | Description |
|---|---|---|
| `main_top.v` | **Top Module** | System top-level file, responsible for integrating all sub-modules and interfacing with physical FPGA pins. |
| `clk_div.v` | Sub Module | Clock divider, stepping down the high-frequency on-board clock to the required frequency. |
| `debounce_onepulse.v` | Sub Module | Debouncer and one-pulse generator, handling noise from sensor or button inputs. |
| `parking_manager.v` | Sub Module | Parking lot core control unit, responsible for handling the logic and states of vehicle entry and exit. |
| `space.v` | Sub Module |Parking space state management, recording or determining whether parking spaces are full. |
| `counter_decimal_4digit.v` | Sub Module | 4-digit decimal counter, used to count the total number of vehicles or remaining parking spaces. |
| `bcd_counter.v` | Sub Module | BCD counter, converting count values into an easily displayable BCD format. |
| `led_decoder.v` | Sub Module | Display decoder, translating numerical values into the output signals required for the seven-segment display. |
| `led2_ctrl.v` | Sub Module | LED controller, used to indicate gate status or specific warning lights. |

## 🌳 模組階層圖 (RTL Hierarchy)
```text
main_top
 ├── clk_div
 ├── debounce_onepulse
 ├── parking_manager
 │    └── space
 ├── counter_decimal_4digit
 │    └── bcd_counter
 ├── led2_ctrl
 └── led_decoder
