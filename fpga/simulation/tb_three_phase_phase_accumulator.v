
`timescale 1ns / 1ps

module tb_three_phase_phase_accumulator;

    reg clk = 1'b0;
    reg rst_n = 1'b0;
    reg enable = 1'b0;
    reg [31:0] phase_increment = 32'd0;

    wire [31:0] phase_a;
    wire [31:0] phase_b;
    wire [31:0] phase_c;

    integer errors = 0;

    three_phase_phase_accumulator dut (
        .clk(clk),
        .rst_n(rst_n),
        .enable(enable),
        .phase_increment(phase_increment),
        .phase_a(phase_a),
        .phase_b(phase_b),
        .phase_c(phase_c)
    );

    always #5 clk = ~clk;

    initial begin
        $dumpfile("phase_accumulator.vcd");
        $dumpvars(0, tb_three_phase_phase_accumulator);

        // Hold reset for two clock edges.
        repeat (2) @(posedge clk);
        #1;

        if (phase_a !== 32'd0) begin
            $display("FAIL: Phase A did not reset");
            errors = errors + 1;
        end

        // Release reset and enable phase advancement.
        rst_n = 1'b1;
        enable = 1'b1;
        phase_increment = 32'd1000;

        @(posedge clk);
        #1;

        if (phase_a !== 32'd1000) begin
            $display("FAIL: Incorrect phase advancement");
            errors = errors + 1;
        end

        // Check that disabling freezes the accumulator.
        enable = 1'b0;
        @(posedge clk);
        #1;

        if (phase_a !== 32'd1000) begin
            $display("FAIL: Phase advanced while disabled");
            errors = errors + 1;
        end

        // Check phase offsets using modular arithmetic.
        if ((phase_b - phase_a) !== 32'hAAAAAAAB) begin
            $display("FAIL: Incorrect Phase B offset");
            errors = errors + 1;
        end

        if ((phase_c - phase_a) !== 32'h55555555) begin
            $display("FAIL: Incorrect Phase C offset");
            errors = errors + 1;
        end

        if (errors == 0)
            $display("PASS: Phase accumulator basic checks passed");
        else
            $display("FAIL: %0d test(s) failed", errors);

        $finish;
    end

endmodule
