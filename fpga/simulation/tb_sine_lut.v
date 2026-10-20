`timescale 1ns / 1ps

module tb_sine_lut;

    reg [31:0] phase;
    wire [11:0] sine_out;
    integer errors = 0;
    integer i;
    integer positive_sample;
    integer negative_sample;

    sine_lut dut (
        .phase(phase),
        .sine_out(sine_out)
    );

    task check_sample;
        input [31:0] test_phase;
        input [11:0] expected;
        input [255:0] label;
        begin
            phase = test_phase;
            #10;

            if (sine_out !== expected) begin
                $display("FAIL: %0s expected=%0d actual=%0d",
                         label, expected, sine_out);
                errors = errors + 1;
            end else begin
                $display("PASS: %0s output=%0d", label, sine_out);
            end
        end
    endtask

    initial begin
        $dumpfile("sine_lut.vcd");
        $dumpvars(0, tb_sine_lut);

        check_sample(32'h00000000, 12'd2048, "0 degrees");
        check_sample(32'h40000000, 12'd4085, "90 degrees");
        check_sample(32'h80000000, 12'd2048, "180 degrees");
        check_sample(32'hC0000000, 12'd11,   "270 degrees");

        // Check that output stays within the 12-bit range.
        for (i = 0; i < 256; i = i + 1) begin
            phase = i * 32'h01000000;
            #1;
            if (sine_out > 12'd4095) begin
                $display("FAIL: Output range at phase=%h", phase);
                errors = errors + 1;
            end
        end

        // Check approximate half-cycle symmetry.
        phase = 32'h10000000;
        #10;
        positive_sample = sine_out;

        phase = 32'h90000000;
        #10;
        negative_sample = sine_out;

        if ((positive_sample + negative_sample) != 4096) begin
            $display("FAIL: Half-cycle symmetry");
            errors = errors + 1;
        end else begin
            $display("PASS: Half-cycle symmetry");
        end

        if (errors == 0)
            $display("PASS: All sine LUT tests passed");
        else
            $display("FAIL: %0d test(s) failed", errors);

        $finish;
    end

endmodule
