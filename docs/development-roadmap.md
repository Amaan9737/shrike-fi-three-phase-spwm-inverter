
# Development Roadmap

## Project Timeline

The project is planned for completion within six months from its official commencement date. The schedule below is a proposed development plan and may be adjusted based on board capabilities, toolchain support, component availability, and validation results.

## Month 1 — Research and System Design

### Planned Activities

- Review the Vicharak Shrike-Fi board documentation.
- Confirm ForgeFPGA capabilities and development-tool support.
- Verify available FPGA GPIO pins and interface constraints.
- Define the SPWM requirements and initial operating limits.
- Prepare the system block diagram and interface plan.
- Identify candidate sensing circuits, gate drivers, and power devices.

### Expected Deliverables

- System requirements document
- Initial architecture diagram
- GPIO and interface budget
- Preliminary component-selection report

## Month 2 — SPWM Logic Design

### Planned Activities

- Design the digital phase accumulator.
- Select an appropriate sinusoidal reference-generation method.
- Develop three references separated by 120 electrical degrees.
- Design the triangular carrier generator.
- Implement carrier-based PWM comparison logic.
- Plan complementary outputs, dead time, and safe reset behavior.

### Expected Deliverables

- Initial Verilog HDL modules
- Initial testbench
- Digital design documentation

## Month 3 — Simulation and FPGA Evaluation

### Planned Activities

- Simulate the three-phase reference generator.
- Verify phase displacement and frequency control.
- Test modulation-amplitude changes.
- Verify PWM generation and switching-signal coordination.
- Review synthesis reports and device-resource utilization, where supported.
- Investigate timing and implementation limitations.

### Expected Deliverables

- Simulation waveforms
- Verification test results
- Initial synthesis and resource reports, if available
- Updated RTL design

## Month 4 — Feedback and Protection Design

### Planned Activities

- Evaluate voltage-sensing options.
- Evaluate current-sensing options.
- Define ADC and signal-conditioning requirements.
- Design fault detection and PWM-disable behavior.
- Review gate-driver compatibility and isolation requirements.
- Prepare schematics and PCB design work, as required.

### Expected Deliverables

- Feedback-interface design
- Protection strategy document
- Preliminary schematics
- Updated system architecture

## Month 5 — Integration and Controlled Testing

### Planned Activities

- Integrate the verified digital controller with available hardware.
- Test logic-level outputs before connecting a power stage.
- Verify feedback interfaces and fault handling independently.
- Review startup, reset, communication-loss, and shutdown behavior.
- Conduct controlled hardware testing only after appropriate safety reviews.

### Expected Deliverables

- Integration documentation
- Test procedures and results
- Updated schematics or PCB files, where applicable
- Recorded observations and identified issues

Hardware integration is conditional on successful design reviews, component availability, and safe test arrangements.

## Month 6 — Validation and Final Documentation

### Planned Activities

- Complete remaining verification tests.
- Review measured frequency and waveform behavior.
- Record FPGA resource usage and timing results where available.
- Document limitations and unresolved issues.
- Organize source code, simulation data, schematics, and test evidence.
- Prepare the final technical report and project demonstration.

### Expected Deliverables

- Final documented RTL implementation, if completed
- Verification and validation report
- Simulation and measurement evidence
- Hardware design files, where completed
- Final project report and demonstration materials

## Milestones

| Milestone | Target |
|---|---|
| Requirements and architecture | End of Month 1 |
| Initial SPWM RTL | End of Month 2 |
| Simulation and FPGA evaluation | End of Month 3 |
| Feedback and protection design | End of Month 4 |
| Integration and controlled testing | End of Month 5 |
| Final validation and documentation | End of Month 6 |

## Risks and Dependencies

- Limited FPGA GPIO availability
- ForgeFPGA resource and timing constraints
- Toolchain compatibility and synthesis limitations
- ADC and feedback-interface requirements
- Gate-driver and power-device availability
- Hardware safety and testing constraints
- Delays in prototype fabrication or component procurement

If a dependency prevents hardware validation, the project will document the verified simulation and digital-design results separately from uncompleted hardware objectives.

## Progress Tracking

Each milestone should be updated with:

- Status: Not started, In progress, Blocked, or Completed
- Actual completion date
- Relevant source files and reports
- Verification evidence
- Outstanding issues

## Current Status

**Status:** Proposed roadmap.

The timeline is a planning target, not a claim that any milestone has already been completed.
