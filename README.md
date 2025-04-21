Summary
This README describes the Assembly_BareMetal_Pico project, which provides two core examples—blink and uart—written in ARM Cortex‑M0+ assembler for the RP2040 microcontroller on the Raspberry Pi Pico. The blink example directly toggles the on‑board LED (connected to GP25), while the uart example demonstrates basic serial I/O over UART0. Detailed build instructions use the GNU Arm Embedded toolchain and the UF2 converter for flashing. Hardware setup notes and memory‑mapped register addresses are called out for clarity.
Repository Structure

Assembly_BareMetal_Pico/
├── blink/
│   ├── blink.s        ← ARM assembly for LED blink :contentReference[oaicite:0]{index=0}  
│   └── blink.c        ← Optional C wrapper/demo :contentReference[oaicite:1]{index=1}  
└── uart/
    ├── uart.s         ← ARM assembly UART driver :contentReference[oaicite:2]{index=2}  
    ├── raw_uart.s     ← Low‑level UART routines :contentReference[oaicite:3]{index=3}  
    └── uart.c         ← C demo using above drivers :contentReference[oaicite:4]{index=4}  

Prerequisites

    GNU Arm Embedded Toolchain (arm‑none‑eabi‑gcc, as, ld, objcopy)
    GitHub

    Python 3 (for uf2conv.py utility)
    GitHub

    RP2040 Linker Script (e.g. from Raspberry Pi Pico SDK)
    GitHub

Hardware Requirements

    Raspberry Pi Pico (RP2040) board

    On‑board LED: connected to GP25
    Keyestudio Docs
    Adafruit Learning System

    USB‑Micro cable and host computer

Building and Flashing

    Assemble

arm-none-eabi-as -mcpu=cortex-m0plus -mthumb blink/blink.s -o blink.o

(Assemble ARM Thumb code for Cortex‑M0+)
smittytone messes with micros

Link

arm-none-eabi-ld blink.o -T rp2040.ld -o blink.elf

(Use RP2040 linker script to set vector table & memory map)
GitHub

Convert to UF2

    arm-none-eabi-objcopy -O binary blink.elf blink.bin
    python3 uf2conv.py blink.bin blink.uf2 --base 0x10000000

    (UF2 converter to produce drag‑and‑drop file)
    GitHub

    Flash

        Hold BOOTSEL and plug Pico into USB; release when it mounts as RPI‑RP2.

        Copy blink.uf2 onto the drive. Pico reboots and runs your code.

    Tip: you can also script these steps in a Makefile or CMakeLists using the Pico SDK build system
    Raspberry Pi
    .

Examples
Blink (blink/)

    blink.s uses the RP2040’s SIO (Single‑Cycle I/O) registers to:

        Enable GPIO25 output via the GPIO_OE_SET register
        cow-pi.readthedocs.io

        Toggle the LED on/off by writing to GPIO_OUT_SET and GPIO_OUT_CLR
        GitHub

        Insert a simple software delay loop.

UART (uart/)

    uart.s / raw_uart.s configure UART0 registers at 0x40034000 base to:

        Set baud rate (using UARTIBRD/UARTFBRD)
        Raspberry Pi Datasheets

        Enable TX/RX in UART_CR

        Provide blocking putc/getc routines.

    uart.c demonstrates sending a string and echoing received characters over USB‑Serial (UART0).

RP2040 Microcontroller Features

    Dual-core ARM Cortex‑M0+ @ 133 MHz
    smittytone messes with micros

    264 KB SRAM, external QSPI flash (2 MB)
    CircuitPython

    Memory‑mapped peripherals: GPIO, UART, Timers, PIO
    cow-pi.readthedocs.io

License
This project is released under the MIT License. Feel free to reuse and adapt for your own bare‑metal explorations!
