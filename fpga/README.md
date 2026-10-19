
# FPGA Design — Renesas ForgeFPGA

This directory will contain the FPGA-side digital logic for the proposed three-phase SPWM inverter controller on the Vicharak Shrike-Fi platform.

## Planned Responsibilities

- Three-phase sine-reference generation with 120° phase displacement.
- Configurable fundamental output frequency.
- Adjustable modulation amplitude for voltage-command control.
- Carrier-based SPWM generation.
- Six switching commands for a conventional three-leg inverter.
- Complementary switching logic and dead-time insertion.
- Configuration interface with the onboard ESP32-S3.
- Digital fault-response and PWM-disable logic.

## Planned Directory Structure

```text
fpga/
├── README.md
├── rtl/          # Verilog RTL source files
├── constraints/  # Pin assignments and timing constraints
├── simulation/   # Testbenches and simulation files
└── synthesis/    # Synthesis reports and implementation notes
```

## Development Status

**Status: Not yet implemented.**

The Verilog HDL source, simulation testbenches, FPGA constraints and synthesis reports will be added during the planned six-month development period.

No FPGA implementation or hardware validation is claimed at this stage.

## Design Considerations

- Confirm the exact ForgeFPGA device and supported toolchain.
- Verify available FPGA I/O pins and the Shrike-Fi pin mapping.
- Establish the clock frequency and timing requirements.
- Verify phase accuracy, switching frequency and modulation range.
- Test complementary switching and dead time before connecting a power stage.

All switching outputs must be verified before being connected to external gate-driver circuitry.
