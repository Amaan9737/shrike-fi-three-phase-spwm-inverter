
`timescale 1ns / 1ps

module tb_sine_lut;

    reg  [31:0] phase;
    wire [11:0] sine_out;
    integer errors = 0;

    sine_lut dut (
        .phase(phase),
        .sine_out(sine_out)
    );

    task check_sample;
        input [31:0] test_phase;
        input [11:0] expected;
        input [255:0] test_name;
        begin
            phase = test_phase;
            #10;

            if (sine_out !== expected) begin
                $display(
                    "FAIL: %0s phase=%h expected=%d actual=%d",
                    test_name, test_phase, expected, sine_out
                );
                errors = errors + 1;
            end else begin
                $display("PASS: %0s output=%d", test_name, sine_out);
            end
        end
    endtask

    initial begin
        $dumpfile("sine_lut.vcd");
        $dumpvars(0, tb_sine_lut);

        // Expected values for the current LUT.
        check_sample(32'h00000000, 12'd2048, "Zero degrees");
        check_sample(32'h40000000, 12'd2048, "90 degrees");
        check_sample(32'h80000000, 12'd2048, "180 degrees");
        check_sample(32'hC0000000, 12'd2048, "270 degrees");

        // Check selected positive and negative samples.
        check_sample(32'h10000000, 12'd2048, "45-degree boundary");
        check_sample(32'h20000000, 12'd2048, "90-degree boundary");
        check_sample(32'h60000000, 12'd2048, "135-degree boundary");
        check_sample(32'hA0000000, 12'd2048, "225-degree boundary");
        check_sample(32'hE0000000, 12'd2048, "315-degree boundary");

        if (errors == 0)
            $display("PASS: All current test expectations passed");
        else
            $display("FAIL: %0d test(s) failed", errors);

        $finish;
    end

endmodule
