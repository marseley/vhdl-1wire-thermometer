# 1-Wire Thermometer Controller for AUP-ZU3 FPGA

## Overview
This repository contains an academic project focused on implementing the **1-Wire communication protocol** in **VHDL**. The design is tailored for the **AUP-ZU3 FPGA development board** and is intended to interface with a digital thermometer. 

The project demonstrates a complete, iterative digital design process—from basic protocol simulation to hardware implementation and final logic refactoring.

## Key Features
* **1-Wire Protocol Implementation:** Custom VHDL modules handling strict timing requirements for 1-Wire communication (reset, read byte, write byte).
* **Hardware Integration:** Configured specifically for the AUP-ZU3 FPGA board with dedicated XDC constraints.
* **Hardware Verification:** Utilizes a university-specific Rotary Encoder extension board to test and verify the physical presence of the thermometer on the 1-Wire bus.
* **Simulation & Testing:** Comprehensive testbenches created for both individual modules and the final top-level controller.

## Project Architecture
The project is built using a modular approach. The core components include:

| Module / File | Description |
| :--- | :--- |
| `Kontroler.vhd` | The top-level state machine and main controller integrating all sub-modules. |
| `onebyte.vhd` | Low-level module handling the fundamental 1-Wire time slots. |
| `readbyte.vhd` / `writeByte.vhd` | Higher-level modules managing full byte transmission and reception over the bus. |
| `RotaryEnc_wrap.vhd` | Wrapper for the university-specific rotary encoder, used exclusively for hardware testing (verifying device presence on the bus). |
| `FinalSim.vhd` | The ultimate testbench used to verify the completely integrated system logic. |
| `*.xdc` | Physical constraint files (`ZU3.xdc`, `ZU3_Exp.xdc`, `OneWire_pinIO.xdc`) mapping the RTL to the AUP-ZU3 board pins. |

## Development History
This project was developed iteratively, which is reflected in the commit history:
1. **Initial Setup:** Basic 1-byte communication implementation and initial behavioral simulations.
2. **Protocol Expansion:** Addition of dedicated `readbyte` and `writeByte` modules for robust data handling.
3. **Hardware Constraints:** Introduction of XDC files for the AUP-ZU3 board, Block Designs, and the integration of the Rotary Encoder for hardware-level bus testing.
4. **Final Refactoring:** Cleanup of test Block Designs, optimization of the project structure, introduction of the top-level `Kontroler.vhd`, and final system simulation.

## Environment & Tools
* **Hardware:** AUP-ZU3 FPGA Development Board, Custom Rotary Encoder Extension, 1-Wire Digital Thermometer.
* **Language:** VHDL
* **IDE:** Xilinx Vivado

## How to Run
1. Clone this repository to your local machine.
2. Open **Xilinx Vivado**.
3. Select **Open Project** and navigate to the `termometr.xpr` file.
4. The project environment will load automatically without generating unnecessary cache files.
5. To run simulations, set `FinalSim.vhd` as the top module in your Simulation Sources.

## License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
