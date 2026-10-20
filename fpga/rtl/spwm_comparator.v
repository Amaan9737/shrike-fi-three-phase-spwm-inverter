`timescale 1ns / 1ps

// SPWM comparator for three-phase sine references.
// Simulation prototype only.
// Outputs are logic-level PWM signals, not gate-driver signals.

module spwm_comparator #(
    parameter WIDTH = 12
) (
    input  wire [WIDTH-1:0] sine_a,
    input  wire [WIDTH-1:0] sine_b,
    input  wire [WIDTH-1:0] sine_c,
    input  wire [WIDTH-1:0] carrier,

    output wire pwm_a,
    output wire pwm_b,
    output wire pwm_c
);

    assign pwm_a = (sine_a > carrier);
    assign pwm_b = (sine_b > carrier);
    assign pwm_c = (sine_c > carrier);

endmodule
