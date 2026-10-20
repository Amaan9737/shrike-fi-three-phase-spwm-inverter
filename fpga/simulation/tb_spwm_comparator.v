`timescale 1ns / 1ps

module tb_spwm_comparator;

    reg [11:0] sine_a;
    reg [11:0] sine_b;
    reg [11:0] sine_c;
    reg [11:0] carrier;

    wire pwm_a;
    wire pwm_b;
    wire pwm_c;

    integer errors = 0;

    spwm_comparator #(
        .WIDTH(12)
    ) dut (
        .sine_a(sine_a),
        .sine_b(sine_b),
        .sine_c(sine_c),
        .carrier(carrier),
        .pwm_a(pwm_a),
        .pwm_b(pwm_b),
        .pwm_c(pwm_c)
    );

    task check_outputs;
        input expected_a;
        input expected_b;
        input expected_c;
        input [255:0] label;
        begin
            #1;
            if ((pwm_a !== expected_a) ||
                (pwm_b !== expected_b) ||
                (pwm_c !== expected_c)) begin
                $display(
                    "FAIL: %0s expected=%b%b%b actual=%b%b%b",
                    label, expected_a, expected_b, expected_c,
                    pwm_a, pwm_b, pwm_c
                );
                errors = errors + 1;
            end else begin
                $display(
                    "PASS: %0s PWM=%b%b%b",
                    label, pwm_a, pwm_b, pwm_c
                );
            end
        end
    endtask

    initial begin
        $dumpfile("spwm_comparator.vcd");
        $dumpvars(0, tb_spwm_comparator);

        // All references above the carrier.
        carrier = 12'd1000;
        sine_a  = 12'd2000;
        sine_b  = 12'd1500;
        sine_c  = 12'd1001;
        check_outputs(1'b1, 1'b1, 1'b1, "All above carrier");

        // All references below the carrier.
        carrier = 12'd2000;
        sine_a  = 12'd1000;
        sine_b  = 12'd1500;
        sine_c  = 12'd1999;
        check_outputs(1'b0, 1'b0, 1'b0, "All below carrier");

        // Mixed comparisons.
        carrier = 12'd2000;
        sine_a  = 12'd2001;
        sine_b  = 12'd2000;
        sine_c  = 12'd1999;
        check_outputs(1'b1, 1'b0, 1'b0, "Above, equal, below");

        // Equality must produce logic low because comparison is strict >.
        carrier = 12'd2048;
        sine_a  = 12'd2048;
        sine_b  = 12'd2048;
        sine_c  = 12'd2048;
        check_outputs(1'b0, 1'b0, 1'b0, "All equal");

        if (errors == 0)
            $display("PASS: All SPWM comparator tests passed");
        else
            $display("FAIL: %0d test(s) failed", errors);

        $finish;
    end

endmodule
