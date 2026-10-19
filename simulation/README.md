
# Simulation and Verification

This directory will contain simulation models, testbenches, waveform captures and verification results for the proposed Vicharak Shrike-Fi three-phase SPWM inverter controller.

## Objectives

- Verify three-phase reference generation with 120° phase displacement.
- Check adjustable fundamental frequency.
- Verify modulation-amplitude control.
- Inspect carrier-based SPWM switching pulses.
- Verify complementary switching and dead-time behavior.
- Investigate expected inverter output-voltage waveforms.
- Test configuration changes and fault-response logic.

## Planned Waveform Outputs

### 1. Reference and Carrier Waveforms

Three sinusoidal reference signals will be compared with a high-frequency triangular carrier.

### 2. SPWM Gate Commands

Simulation will examine the six planned switching commands for a conventional three-leg inverter, including complementary switching and dead time.

### 3. Line-to-Line Voltage

The simulated switching states will be used to examine the expected line-to-line voltage waveform.

### 4. Fundamental Output

The fundamental component and the potential effect of output filtering will be investigated.

## Planned Directory Structure

```text
simulation/
├── README.md
├── waveforms/
│   └── README.md
└── test-results/
    └── README.md
```

## Verification Approach

The simulation workflow will be selected after confirming the supported FPGA design tools and available Verilog simulation tools.

Planned checks include:

- Frequency accuracy.
- Phase displacement.
- PWM switching frequency.
- Modulation-amplitude response.
- Dead-time and complementary-switch behavior.
- Fault-disable behavior.

## Development Status

**Status: Not yet implemented.**

No simulation results or verified waveform captures are claimed at this stage. Testbenches, plots and reports will be added as the project progresses.

Simulation results alone will not establish the safety or performance of the physical inverter.
