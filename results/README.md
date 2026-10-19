
# Project Results and Validation

This directory will contain documented results for the Shrike-Fi three-phase SPWM inverter controller.

## Directory Structure

```text
results/
├── fpga-resource-usage/
└── measurements/
```

## FPGA Resource Usage

The `fpga-resource-usage/` directory will contain synthesis reports and resource-utilization data for the Renesas ForgeFPGA implementation, where supported by the development tools.

Planned records include:

- Logic resource utilization
- Timing and clock-related reports
- Design warnings and synthesis observations
- Implementation revisions associated with each report

## Measurements

The `measurements/` directory will contain verified experimental data collected during hardware testing.

Planned measurements include:

- SPWM output frequency
- Modulation amplitude and modulation index
- Three-phase output voltage
- Output frequency accuracy
- Current-sensing results
- Protection-response observations

## Validation Status

Results will be added after the relevant design, simulation, synthesis, or hardware test has been completed.

Each result should identify the test conditions, configuration, measurement method, and date where practical.

**Important:** No experimental results are claimed at this stage. Simulated, synthesized, and physically measured results must be clearly distinguished.
