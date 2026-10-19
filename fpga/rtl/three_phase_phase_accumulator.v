
`timescale 1ns / 1ps

// Three-phase digital phase accumulator
// Project: Shrike-Fi Three-Phase SPWM Inverter
//
// This module generates three phase positions separated
// by approximately 120 electrical degrees.
//
// This is a phase-generation module only.
// It does not generate sine amplitudes or PWM gate signals.

module three_phase_phase_accumulator (
    input  wire        clk,
    input  wire        rst_n,
    input  wire        enable,

    // Phase increment per clock cycle.
    // Calculated from the desired frequency and update clock.
    input  wire [31:0] phase_increment,

    output wire [31:0] phase_a,
    output wire [31:0] phase_b,
    output wire [31:0] phase_c
);

    // Unsigned 32-bit phase accumulator.
    // Overflow naturally wraps the phase back to zero.
    reg [31:0] phase_accumulator;

    // 120 degrees represented in a 32-bit phase circle.
    localparam [31:0] PHASE_120 = 32'h55555555;

    // Update phase once per enabled clock cycle.
    always @(posedge clk) begin
        if (!rst_n) begin
            phase_accumulator <= 32'd0;
        end
        else if (enable) begin
            phase_accumulator <=
                phase_accumulator + phase_increment;
        end
    end

    // Three phase positions.
    assign phase_a = phase_accumulator;
    assign phase_b = phase_accumulator - PHASE_120;
    assign phase_c = phase_accumulator + PHASE_120;

endmodule
