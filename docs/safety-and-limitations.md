
# Safety and Design Limitations

## 1. Purpose

This document describes the safety considerations and known design limitations for the proposed three-phase SPWM inverter controller using the Vicharak Shrike-Fi development board.

The project is currently in the planning and initial design stage. All hardware interfaces, protection mechanisms, and operating limits must be verified before power-stage testing.

## 2. Electrical Safety

A three-phase inverter can contain hazardous DC bus voltages, high currents, stored electrical energy, and rapidly switching power devices.

The following precautions are required:

- Begin development with simulation and low-voltage logic testing.
- Do not connect an unverified FPGA design directly to a power stage.
- Use appropriately rated gate drivers and power devices.
- Provide suitable current limiting, overcurrent protection, and emergency shutdown.
- Discharge DC bus capacitors safely before handling the circuit.
- Use appropriate insulation, clearances, creepage distances, and protective enclosures.
- Use suitable measurement equipment and probes rated for the circuit.
- Perform high-energy testing only with appropriate supervision, equipment, and safety procedures.

## 3. FPGA and GPIO Limitations

The available FPGA GPIO count is a significant architectural constraint. The preliminary estimate is approximately 14 available pins, but the exact count and pin assignments must be confirmed using official Shrike-Fi documentation.

The design must account for:

- Six gate-control logic outputs
- Enable and fault signals
- Configuration and status communication
- Voltage and current feedback interfaces
- Clock, reset, and other required connections

GPIO voltage levels, pin capabilities, timing requirements, and interface compatibility must be checked before connecting external circuits.

FPGA logic outputs must not be assumed to provide sufficient voltage or current to drive MOSFET or IGBT gates directly.

## 4. PWM and Switching Safety

The three inverter legs require coordinated switching signals.

The design should include:

- Complementary switching control
- Suitable dead time between switching transitions
- Interlocking to prevent simultaneous activation of both devices in a leg
- Defined output states during reset and startup
- A reliable method to disable switching after a fault
- Verification of switching timing before power-stage integration

Dead time must be determined from the selected gate driver and power-device characteristics. A simulated or synthesized design alone does not establish that the physical switching circuit is safe.

## 5. Feedback and Fault Detection

Voltage and current feedback require suitable sensing and signal-conditioning circuits.

The design must establish:

- Sensor measurement ranges
- ADC input ranges and sampling requirements
- Calibration and filtering methods
- Isolation and common-mode requirements
- Overcurrent and overvoltage thresholds
- Fault response times and recovery behavior

Protection must not rely solely on ESP32-S3 firmware or a wireless communication link. Where required by the power-stage design, an independent hardware shutdown path should disable the gate drivers.

## 6. Communication and Supervisory Control

The ESP32-S3 may provide configuration and supervisory functions. Communication between the ESP32-S3 and ForgeFPGA must be designed with defined command ranges, startup behavior, and fault handling.

The system should consider:

- Invalid or out-of-range configuration values
- Communication loss
- FPGA reset or configuration failure
- Unexpected controller startup
- Fault reporting and recovery

Loss of supervisory communication must not leave the power stage in an uncontrolled switching state.

## 7. Technical Limitations

The following parameters have not yet been established through implementation and testing:

- Maximum supported fundamental frequency
- Selected PWM carrier frequency
- Maximum validated modulation index
- FPGA resource utilization and timing margin
- Feedback sampling rate and accuracy
- DC bus voltage and power rating
- Output voltage and harmonic performance
- Thermal performance and efficiency

These values will depend on the final architecture, device resources, component specifications, and validation results.

## 8. Validation Requirements

Before power-stage operation, the project should complete the following checks:

1. Review the system architecture and pin assignments.
2. Simulate the SPWM logic and relevant boundary conditions.
3. Review synthesis and timing reports where available.
4. Verify logic-level outputs with appropriate instruments.
5. Test fault handling and shutdown behavior independently.
6. Review gate-driver interfaces and protection circuits.
7. Conduct controlled hardware testing only after a documented safety review.

Simulation results, FPGA implementation results, and physical measurements must be reported separately.

## 9. Project Status and Limitations

This repository documents a proposed engineering project. Planned features are not claims of completed implementation.

Any known limitations, unresolved issues, and deviations from the original plan should be recorded as the project progresses.

## 10. Safety Statement

This project is an educational development effort and is not a certified inverter or safety-rated control system.

No high-voltage or high-power operating capability is implied until the design has been appropriately reviewed and validated.
