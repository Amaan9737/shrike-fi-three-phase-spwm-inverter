# Project Proposal: FPGA-Based Configurable Three-Phase SPWM Inverter Controller

## 1. Project Overview

This project proposes the development of a configurable three-phase sinusoidal pulse-width modulation (SPWM) inverter controller using the Vicharak Shrike-Fi development board. The proposed architecture uses the ForgeFPGA fabric for deterministic waveform generation and PWM logic, while the ESP32-S3 provides configuration and supervisory control.

The project will begin with RTL design and simulation, followed by FPGA implementation and staged hardware validation, subject to board capabilities, toolchain support, and available hardware.

## 2. Problem Statement

Three-phase inverter systems require coordinated switching signals to synthesize three-phase AC waveforms from a DC source. Their controller must generate appropriately phase-shifted references, regulate modulation parameters, and provide reliable switching logic.

This project will investigate how an FPGA-based implementation can provide deterministic digital waveform generation and configurable SPWM control while keeping timing-critical logic separate from supervisory functions.

## 3. Proposed Solution

The proposed controller will include:

- Three phase-shifted sinusoidal references.
- A digital triangular carrier generator.
- Three SPWM comparators.
- Adjustable fundamental frequency and modulation amplitude.
- ESP32-S3-based parameter configuration and supervisory control.
- A planned feedback interface for voltage and current measurement.
- A planned gate-drive interface with complementary switching and dead-time protection.

The final architecture and interface allocation will be refined after checking the board's available GPIO, FPGA resources, and peripheral capabilities.

## 4. Objectives

1. Develop synthesizable RTL modules for the core SPWM generation logic.
2. Verify individual modules and their integration through simulation.
3. Investigate configurable frequency and modulation amplitude.
4. Evaluate FPGA resource usage and timing constraints.
5. Develop a documented interface between FPGA logic and ESP32-S3 supervisory control.
6. Plan safe integration with sensing, gate drivers, and a three-phase inverter power stage.
7. Document test results, limitations, and future improvements.

## 5. Current Status

The repository currently contains initial RTL prototypes for a sine lookup table, triangular carrier generator, and three-phase SPWM comparator, together with simulation testbenches.

Basic tests for the carrier and comparator have passed. Selected sine lookup table checks have also passed. These tests establish an initial simulation baseline; they do not yet demonstrate complete three-phase waveform correctness, FPGA implementation, closed-loop regulation, or physical inverter operation.

## 6. Development Plan

### Phase 1 — Initial RTL and simulation
Complete and verify the waveform-generation blocks, improve numerical checks, and integrate the modules in simulation.

### Phase 2 — Configurability
Develop parameter control for fundamental frequency and modulation amplitude, and define the FPGA–ESP32-S3 interface.

### Phase 3 — FPGA implementation
Check synthesis support, resource usage, timing, and available I/O against the selected board.

### Phase 4 — Feedback and protection design
Specify voltage/current sensing, signal conditioning, safe switching logic, complementary outputs, dead time, and fault handling.

### Phase 5 — Staged hardware validation
Validate logic-level signals first, then proceed to protected low-voltage hardware testing only after suitable gate-drive, protection, and measurement arrangements are established.

## 7. Expected Outcomes

- A documented and simulated three-phase SPWM controller prototype.
- RTL source code and reproducible testbenches.
- A defined configuration interface and implementation plan.
- FPGA synthesis and timing results, if supported by the available toolchain.
- A hardware-validation plan and, subject to resources and safety requirements, a staged hardware demonstration.

## 8. Scope and Safety

The current work is an early-stage digital design and simulation project. The repository does not yet claim a validated inverter controller or a working power stage. Any future power-stage testing will require suitable isolation, current limiting, overcurrent protection, safe gate-drive design, dead-time verification, and appropriate supervision.

## 9. Repository

Source code, testbenches, architecture documentation, and development progress are maintained in the project GitHub repository:

https://github.com/Amaan9737/shrike-fi-three-phase-spwm-inverter
