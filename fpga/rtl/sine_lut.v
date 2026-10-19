
`timescale 1ns / 1ps

// Quarter-wave sine lookup table.
// Input: 32-bit phase accumulator value.
// Output: 12-bit unsigned offset-binary sine sample.
//
// Output range is approximately 11 to 4085.
// Midpoint (zero crossing) is 2048.
// This LUT is an initial low-resource implementation.

module sine_lut (
    input  wire [31:0] phase,
    output reg  [11:0] sine_out
);

    wire [1:0] quadrant;
    wire [3:0] index;
    reg  [3:0] lut_index;
    reg  [11:0] amplitude;

    assign quadrant = phase[31:30];
    assign index    = phase[29:26];

    // Reflect the index in the second and fourth quadrants.
    always @(*) begin
        if (quadrant == 2'b01 || quadrant == 2'b11)
            lut_index = 4'd15 - index;
        else
            lut_index = index;
    end

    // Quarter-wave ROM: 16 samples.
    always @(*) begin
        case (lut_index)
            4'd0:  amplitude = 12'd0;
            4'd1:  amplitude = 12'd201;
            4'd2:  amplitude = 12'd400;
            4'd3:  amplitude = 12'd594;
            4'd4:  amplitude = 12'd783;
            4'd5:  amplitude = 12'd964;
            4'd6:  amplitude = 12'd1137;
            4'd7:  amplitude = 12'd1299;
            4'd8:  amplitude = 12'd1447;
            4'd9:  amplitude = 12'd1581;
            4'd10: amplitude = 12'd1697;
            4'd11: amplitude = 12'd1795;
            4'd12: amplitude = 12'd1874;
            4'd13: amplitude = 12'd1931;
            4'd14: amplitude = 12'd1967;
            4'd15: amplitude = 12'd2037;
            default: amplitude = 12'd0;
        endcase
    end

    // Convert the sine wave to unsigned offset-binary format.
    always @(*) begin
        case (quadrant)
            2'b00: sine_out = 12'd2048 + amplitude;
            2'b01: sine_out = 12'd2048 + amplitude;
            2'b10: sine_out = 12'd2048 - amplitude;
            2'b11: sine_out = 12'd2048 - amplitude;
            default: sine_out = 12'd2048;
        endcase
    end

endmodule
