
`timescale 1ns / 1ps

// Initial quarter-wave sine LUT.
// 32-bit phase input; 12-bit unsigned offset-binary output.
// Midpoint = 2048; nominal output range = 11 to 4085.
//
// This is a coarse prototype. Its phase resolution and
// numerical accuracy must be evaluated in simulation.

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

    // Reflect the index in quadrants 1 and 3.
    always @(*) begin
        if (quadrant[0])
            lut_index = 4'd15 - index;
        else
            lut_index = index;
    end

    // Quarter-wave samples.
    always @(*) begin
        case (lut_index)
            4'd0:  amplitude = 12'd0;
            4'd1:  amplitude = 12'd214;
            4'd2:  amplitude = 12'd427;
            4'd3:  amplitude = 12'd637;
            4'd4:  amplitude = 12'd845;
            4'd5:  amplitude = 12'd1048;
            4'd6:  amplitude = 12'd1246;
            4'd7:  amplitude = 12'd1437;
            4'd8:  amplitude = 12'd1621;
            4'd9:  amplitude = 12'd1796;
            4'd10: amplitude = 12'd1961;
            4'd11: amplitude = 12'd2115;
            4'd12: amplitude = 12'd2257;
            4'd13: amplitude = 12'd2386;
            4'd14: amplitude = 12'd2501;
            4'd15: amplitude = 12'd2601;
            default: amplitude = 12'd0;
        endcase
    end

    // Positive half-cycle: quadrants 0 and 1.
    // Negative half-cycle: quadrants 2 and 3.
    always @(*) begin
        if (!quadrant[1])
            sine_out = 12'd2048 + amplitude;
        else
            sine_out = 12'd2048 - amplitude;
    end

endmodule
