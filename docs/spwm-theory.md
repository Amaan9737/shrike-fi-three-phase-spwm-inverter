
# Three-Phase Sinusoidal PWM Theory

## 1. Introduction

Sinusoidal pulse-width modulation (SPWM) is a technique used to control the switching of a voltage-source inverter. It compares sinusoidal reference signals with a high-frequency triangular carrier to produce pulse-width-modulated switching signals.

In this project, SPWM generation is planned for the Renesas ForgeFPGA on the Vicharak Shrike-Fi development board.

The objective is to generate three references separated by 120 electrical degrees and use them to control a three-phase, two-level inverter.

## 2. Three-Phase Reference Signals

The three normalized sinusoidal references are:

```math
v_a^*(t)=M\sin(2\pi f_1t)
```

```math
v_b^*(t)=M\sin(2\pi f_1t-2\pi/3)
```

```math
v_c^*(t)=M\sin(2\pi f_1t+2\pi/3)
```

Where:

- `M` is the modulation amplitude.
- `f_1` is the fundamental reference frequency.
- `t` is time.
- The phase displacement between adjacent references is 120 electrical degrees.

The references are normalized for comparison with a normalized carrier. Actual output voltage depends on the DC bus voltage, modulation method, inverter topology, and operating conditions.

## 3. Modulation Index

For a normalized reference and carrier, the modulation index can be represented by:

```math
m_a=\frac{V_{\mathrm{ref,peak}}}{V_{\mathrm{carrier,peak}}}
```

The permitted range and linearity depend on the modulation method and implementation. The controller should enforce a validated range rather than accepting arbitrary values.

Changing the modulation index changes the fundamental component of the inverter output voltage. It does not directly guarantee a specific load voltage because the power stage, DC bus, and load also affect the result.

## 4. Carrier-Based PWM

A triangular carrier is compared with each sinusoidal reference.

For phase A, the switching command is defined as:

```math
S_a(t)=1 \quad \text{when } v_a^*(t)\geq v_{\mathrm{carrier}}(t)
```

```math
S_a(t)=0 \quad \text{when } v_a^*(t)<v_{\mathrm{carrier}}(t)
```

Equivalent comparisons generate the phase B and phase C switching commands.

The resulting pulses vary in width over the fundamental cycle. Their switching pattern approximates the desired sinusoidal fundamental after the inverter switching process and any appropriate output filtering.

The exact carrier frequency, counter resolution, and comparison convention will be determined during implementation.

## 5. Fundamental Frequency

The fundamental frequency is controlled by the rate at which the sinusoidal phase advances.

```math
\theta(t)=2\pi f_1t
```

For a digital phase accumulator, the phase increment is determined by the requested frequency and the update clock.

For a phase accumulator with `N` bits and update frequency `f_clk`:

```math
\Delta\phi=\frac{f_1\,2^N}{f_{\mathrm{clk}}}
```

The implementation must account for the supported accumulator width, numeric representation, clock frequency, and rounding. The phase increment will be updated when the configured fundamental frequency changes.

## 6. Switching Frequency Ratio

The frequency ratio is commonly defined as:

```math
m_f=\frac{f_c}{f_1}
```

Where:

- `f_c` is the triangular carrier frequency.
- `f_1` is the fundamental frequency.

The ratio influences the harmonic spectrum and the number of PWM switching cycles per fundamental cycle. The selected carrier frequency must also satisfy FPGA timing, gate-driver, switching-device, and thermal constraints.

## 7. Six Gate-Control Signals

A three-phase, two-level inverter has three switching legs. Each leg contains an upper and a lower switching device.

The controller therefore needs six gate-control signals:

- Phase A: upper and lower commands
- Phase B: upper and lower commands
- Phase C: upper and lower commands

The lower command must not simply be an unrestricted logical inversion of the upper command. Appropriate dead time and interlocking are required to prevent simultaneous conduction in the same leg.

Dead time must be selected based on the actual gate driver and power-device characteristics and verified through testing.

## 8. FPGA Implementation Approach

The planned ForgeFPGA design may contain the following functional blocks:

1. Phase accumulator
2. Sinusoidal lookup table or another suitable reference-generation method
3. Three-phase reference offset logic
4. Triangular carrier generator
5. PWM comparison logic
6. Complementary output and dead-time logic
7. Configuration and fault-handling interface

The final implementation depends on the ForgeFPGA device resources and the supported development toolchain.

## 9. Simulation and Verification

The design should be verified incrementally before connecting a power stage.

Planned checks include:

- Correct 120-degree phase separation
- Correct fundamental frequency
- Correct PWM response to modulation-index changes
- Expected carrier frequency and PWM timing
- Correct operation of all six switching commands
- Dead-time and interlocking behavior
- Safe outputs during reset, startup, and fault conditions
- Behavior at supported parameter limits

Simulation results must be distinguished from physical measurements. Logic-level output verification should precede power-stage testing.

## 10. Limitations

This document describes the proposed digital modulation method. It does not establish a validated switching frequency, DC bus voltage, output voltage, efficiency, harmonic distortion, or power rating.

Those values must be determined through design analysis, component specifications, simulation, and appropriately controlled testing.

## 11. Current Status

**Status:** Theory and implementation planning.

The equations and architecture provide the basis for the planned SPWM implementation. RTL development and verification results will be added as the project progresses.
