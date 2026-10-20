
`timescale 1ns / 1ps

module tb_sine_lut;

    reg  [31:0] phase;
    wire [11:0] sine_out;

    integer errors = 0;
    integer i;

    sine_lut dut (
        .phase(phase),
        .sine_out(sine_out)
    );

    task check_range;
        input [31:0] test_phase;
        begin
            phase = test_phase;
            #10;

            if (sine_out < 12'd0 || sine_out > 12'd4095) begin
                $display("FAIL: Output out of range at phase %h", test_phase);
                errors = errors + 1;
            end
        end
    endtask

    task check_sample;
        input [31:0] test_phase;
        input [11:0] expected;
        input [255:0] label;
        begin
            phase = test_phase;
            #10;

            if (sine_out !== expected) begin
                $display(
                    "FAIL: %0s phase=%h expected=%d actual=%d",
                    label, test_phase, expected, sine_out
                );
                errors = errors + 1;
            end
            else begin
                $display("PASS: %0s output=%d", label, sine_out);
            end
        end
    endtask

    initial begin
        $dumpfile("sine_lut.vcd");
        $dumpvars(0, tb_sine_lut);

        // Check cardinal phase points.
        check_sample(32'h00000000, 12'd2048, "Zero degrees");
        check_sample(32'h40000000, 12'd2048, "90 degrees");
        check_sample(32'h80000000, 12'd2048, "180 degrees");
        check_sample(32'hC0000000, 12'd2048, "270 degrees");

        // Check output range over the entire phase space.
        for (i = 0; i < 256; i = i + 1) begin
            check_range(i * 32'h01000000);
        end

        // Basic half-cycle symmetry checks.
        phase = 32'h10000000;
        #10;
        begin : positive_sample
            reg [11:0] positive_value;
            positive_value = sine_out;

            phase = 32'h90000000;
            #10;

            if ((positive_value + sine_out) != 12'd4096) begin
                $display("FAIL: Half-cycle symmetry check");
                errors = errors + 1;
            end
        end

        if (errors == 0)
            $display("PASS: All sine LUT checks passed");
        else
            $display("FAIL: %0d test(s) failed", errors);

        $finish;
    end

endmodule
