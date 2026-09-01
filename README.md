# FPGA-Based Smart Parking Lot

本專案使用 FPGA 實作智慧停車場管理系統。

## 📝 檔案清單與功能說明

| 檔案名稱 | 模組層級 | 功能描述 |
|---|---|---|
| `main_top.v` | **Top Module** | 系統頂層檔案，負責整合所有子模組並對接 FPGA 實體腳位。 |
| `clk_div.v` | Sub Module | 除頻器，將板載高頻時脈降至所需頻率。 |
| `debounce_onepulse.v` | Sub Module | 去彈跳與單脈衝產生器，處理感測器或按鈕輸入的雜訊。 |
| `parking_manager.v` | Sub Module | 停車場核心控制單元，負責處理車輛進出的邏輯與狀態。 |
| `space.v` | Sub Module | 停車位狀態管理，紀錄或判斷車位是否已滿。 |
| `counter_decimal_4digit.v` | Sub Module | 4 位數十進位計數器，用於統計總車輛數或剩餘車位。 |
| `bcd_counter.v` | Sub Module | BCD 計數器，將計數數值轉換為易於顯示的 BCD 格式。 |
| `led_decoder.v` | Sub Module | 顯示解碼器，將數值轉譯為七段顯示器所需的輸出訊號。 |
| `led2_ctrl.v` | Sub Module | LED 控制器，用於指示閘門狀態或特定警告燈號。 |

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
