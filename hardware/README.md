
# Hardware Design — Inverter Power Stage

This directory will contain the proposed hardware design for the three-phase SPWM inverter controlled by the Vicharak Shrike-Fi development board.

## Planned Hardware

### 1. Circuit Schematic

The schematic will document the connections between the control platform, sensing circuits, gate drivers, power switches and supporting circuitry.

### 2. Voltage and Current Sensing

The planned sensing subsystem will investigate:

- Output-voltage measurement.
- Current measurement for monitoring and current limiting.
- Signal conditioning and suitable ADC interfaces.
- Electrical isolation where required by the final design.

### 3. Gate-Driver Circuitry

The gate-driver design will interface the FPGA-generated switching commands with the selected MOSFETs or IGBTs.

The final design must account for gate-drive voltage, switching speed, dead time, isolation requirements and protection against shoot-through.

### 4. Inverter Power Stage

The proposed inverter will use three switching legs, each containing an upper and lower power switch.

The final choice of MOSFETs or IGBTs will depend on the intended DC-link voltage, output voltage, current, switching frequency and thermal requirements.

### 5. PCB Design

PCB files will be developed after the circuit schematic and component selection have been reviewed.

The layout will consider switching-current paths, grounding, gate-drive routing, thermal management, clearances and separation between control and power circuitry.

## Planned Directory Structure

```text
hardware/
├── README.md
├── schematics/   # Circuit diagrams and schematic source files
├── pcb/          # PCB layout and manufacturing outputs
├── bom/          # Bill of materials
└── datasheets/   # Relevant component datasheets
```

## Development Status

**Status: Not yet implemented.**

The circuit schematic, component selections, PCB layout, bill of materials and hardware validation results will be added during the planned six-month development period.

No completed hardware design or operational inverter is claimed at this stage.

## Safety

The FPGA and microcontroller GPIOs must not drive power switches directly. Appropriate gate drivers, dead-time control, current limiting and effective hardware fault protection will be required.

Initial work will prioritize simulation and low-voltage testing. Any power-stage testing will require a reviewed design and a suitably protected test environment.
