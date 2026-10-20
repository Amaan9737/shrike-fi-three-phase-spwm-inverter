`timescale 1ns / 1ps

// Coarse quarter-wave sine LUT.
// 32-bit phase input, 12-bit unsigned offset-binary output.
// Midpoint = 2048; approximate peak = 4085.
// This is a simulation prototype, not hardware-validated.

module sine_lut (
    input  wire [31:0] phase,
    output reg  [11:0] sine_out
);

    wire [1:0] quadrant;
    wire [3:0] index;

    reg [3:0] lut_index;
    reg [11:0] amplitude;

    assign quadrant = phase[31:30];
    assign index    = phase[29:26];

    // Reflect the quarter-wave index in quadrants 1 and 3.
    always @(*) begin
        if (quadrant[0])
            lut_index = 4'd15 - index;
        else
            lut_index = index;
    end

    // Samples of sin(index * 90 degrees / 16) * 2047.
    always @(*) begin
        case (lut_index)
            4'd0:  amplitude = 12'd0;
            4'd1:  amplitude = 12'd201;
            4'd2:  amplitude = 12'd399;
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

    // Quadrants 0 and 1 are positive; 2 and 3 are negative.
    always @(*) begin
        if (!quadrant[1])
            sine_out = 12'd2048 + amplitude;
        else
            sine_out = 12'd2048 - amplitude;
    end

endmodule
