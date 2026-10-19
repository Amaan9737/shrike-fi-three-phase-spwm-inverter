
# Control, Feedback and Protection

This directory will document the planned feedback and protection functions for the Vicharak Shrike-Fi three-phase SPWM inverter controller.

## 1. Voltage Feedback

The voltage-feedback subsystem is intended to measure the relevant inverter output voltage and provide measurements for monitoring and regulation.

Planned functions:

- Voltage sensing and signal conditioning.
- ADC interfacing.
- RMS voltage estimation.
- Comparison of measured voltage with the requested setpoint.
- Modulation-amplitude adjustment for voltage regulation.

## 2. Current Feedback

The current-feedback subsystem is intended to measure inverter or load current.

Planned functions:

- Current sensing and signal conditioning.
- Current measurement and monitoring.
- Configurable current limits.
- Detection and reporting of abnormal current conditions.

## 3. Protection

The planned protection system will investigate:

- Safe PWM enable and disable behavior.
- Fault detection and shutdown.
- Complementary switching and dead-time verification.
- Overcurrent protection.
- Safe handling of invalid configuration commands.

Fast hardware protection must not depend solely on the ESP32-S3 software or wireless communication.

## 4. Control Architecture

The final design will determine which functions belong in the FPGA and which belong in the ESP32-S3.

The FPGA is intended to handle deterministic switching logic. The microcontroller may handle supervisory functions and slower monitoring tasks. ADC interfaces, communication timing and control-loop requirements will guide the final allocation.

## Planned Directory Structure

```text
control/
├── README.md
├── voltage-feedback/
├── current-feedback/
└── protection/
```

## Development Status

**Status: Not yet implemented.**

Feedback algorithms, sensing interfaces, protection logic and verification results will be added as the project progresses.

No closed-loop regulation or hardware protection performance is claimed at this stage.
