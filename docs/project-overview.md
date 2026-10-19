
# Project Overview

## Project Title

**Configurable Three-Phase SPWM Inverter Controller Using Vicharak Shrike-Fi**

## 1. Introduction

This project proposes the design and validation of a configurable three-phase sinusoidal pulse-width modulation (SPWM) inverter controller using the Vicharak Shrike-Fi development board.

Shrike-Fi combines a Renesas ForgeFPGA device with an ESP32-S3 microcontroller. The FPGA will be used for deterministic, parallel PWM generation, while the ESP32-S3 can provide configuration and supervisory-control functions.

The controller is intended to generate six switching-control signals for a three-phase, two-level inverter. The output frequency and modulation amplitude will be configurable. Feedback sensing, protection logic, simulation, and hardware validation are planned as part of the development process.

## 2. Problem Statement

Three-phase inverter controllers require coordinated switching signals with predictable timing and adjustable output characteristics. A programmable FPGA provides an opportunity to implement parallel timing logic and deterministic PWM generation.

The project will investigate whether the available resources and GPIO interfaces of Shrike-Fi are suitable for this application, including the requirements for feedback signals, control interfaces, and safe integration with external power electronics.

## 3. Project Objectives

The primary objectives are to:

1. Develop a configurable three-phase sinusoidal reference generator.
2. Implement carrier-based SPWM logic in ForgeFPGA using Verilog HDL.
3. Provide adjustable fundamental output frequency and modulation amplitude.
4. Generate six coordinated gate-control signals for three inverter legs.
5. Investigate complementary switching and configurable dead time.
6. Design an interface for voltage and current feedback.
7. Evaluate fault detection and safe shutdown behavior.
8. Simulate and validate the design before considering power-stage testing.
9. Document FPGA resource utilization, timing behavior, and measured results.

## 4. Proposed Hardware Platform

### Vicharak Shrike-Fi

The Shrike-Fi board is the main development platform and contains:

- **Renesas ForgeFPGA:** intended for time-critical waveform generation and PWM logic.
- **ESP32-S3:** intended for configuration, supervisory control, and optional wireless communication.

### External Hardware

The complete inverter system may require:

- Voltage and current sensing circuits
- Suitable signal conditioning and ADC interfaces
- Three-phase gate-driver circuitry
- A three-leg MOSFET or IGBT power stage
- A suitable DC power source
- An output filter, if required by the application
- Isolated measurement and protection interfaces, where appropriate

These components are planned system elements; their final selection will depend on electrical ratings, interface compatibility, safety requirements, and testing.

## 5. Proposed Control Architecture

The planned control flow is:

1. Receive the desired frequency and modulation settings.
2. Generate three sinusoidal references separated by 120 electrical degrees.
3. Compare the references with a triangular carrier to produce SPWM.
4. Coordinate the six gate-control outputs.
5. Apply suitable interlocking and dead-time provisions.
6. Acquire voltage and current feedback through compatible interfaces.
7. Detect configured fault conditions and disable switching when necessary.

The exact division of responsibilities between the FPGA and ESP32-S3 will be finalized during architecture and interface design.

## 6. Scope

### Included

- Digital SPWM generation
- Frequency and modulation control
- Three-phase reference generation
- FPGA RTL development
- Simulation and verification
- Feedback-interface design
- Protection and shutdown design
- Synthesis analysis and hardware validation planning

### Outside the Initial Scope

- A production-certified inverter
- Grid connection or grid synchronization
- Unverified claims of efficiency or power quality
- Operation at high voltage or high power before appropriate safety validation

## 7. Planned Deliverables

- System architecture and interface documentation
- Verilog HDL source code
- Testbenches and simulation waveforms
- Hardware schematics and PCB design, where required
- Feedback and protection design documentation
- Synthesis and timing reports, where supported
- Validation results and a final technical report

## 8. Expected Outcome

The intended outcome is a documented and tested prototype controller demonstrating configurable three-phase SPWM generation on Shrike-Fi, with a defined path toward feedback integration and safe inverter-stage evaluation.

Actual performance, feasibility, resource usage, and supported operating limits will be established through design analysis and testing.

## 9. Current Status

**Status:** Planning and initial design.

Implementation and validation are planned within the six-month project period, beginning from the project's official commencement date.

No completed hardware implementation or measured performance is claimed in this document.
