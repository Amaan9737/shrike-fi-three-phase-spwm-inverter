`timescale 1ns / 1ps

// Digital triangular carrier generator.
// Simulation prototype for the Shrike-Fi SPWM project.
// The counter runs between MIN_VALUE and MAX_VALUE.
// This module generates a digital triangle, not an analog waveform.

module triangular_carrier #(
    parameter WIDTH = 12,
    parameter MIN_VALUE = 0,
    parameter MAX_VALUE = 4095
) (
    input  wire             clk,
    input  wire             reset_n,
    input  wire             enable,
    output reg  [WIDTH-1:0] carrier
);

    reg direction_up;

    always @(posedge clk) begin
        if (!reset_n) begin
            carrier     <= MIN_VALUE;
            direction_up <= 1'b1;
        end else if (enable) begin
            if (direction_up) begin
                if (carrier >= MAX_VALUE) begin
                    direction_up <= 1'b0;
                    carrier <= MAX_VALUE - 1;
                end else begin
                    carrier <= carrier + 1'b1;
                end
            end else begin
                if (carrier <= MIN_VALUE) begin
                    direction_up <= 1'b1;
                    carrier <= MIN_VALUE + 1;
                end else begin
                    carrier <= carrier - 1'b1;
                end
            end
        end
    end

endmodule
