`timescale 1ns / 1ps

module tb_triangular_carrier;

    reg clk = 0;
    reg reset_n = 0;
    reg enable = 0;

    wire [3:0] carrier;
    integer errors = 0;

    // Small range makes the simulation quick.
    triangular_carrier #(
        .WIDTH(4),
        .MIN_VALUE(0),
        .MAX_VALUE(7)
    ) dut (
        .clk(clk),
        .reset_n(reset_n),
        .enable(enable),
        .carrier(carrier)
    );

    always #5 clk = ~clk;

    task check_value;
        input [3:0] expected;
        input [255:0] label;
        begin
            if (carrier !== expected) begin
                $display(
                    "FAIL: %0s expected=%0d actual=%0d",
                    label, expected, carrier
                );
                errors = errors + 1;
            end else begin
                $display("PASS: %0s carrier=%0d", label, carrier);
            end
        end
    endtask

    initial begin
        $dumpfile("triangular_carrier.vcd");
        $dumpvars(0, tb_triangular_carrier);

        // Apply reset.
        repeat (2) @(posedge clk);
        #1;
        check_value(4'd0, "Reset");

        // Release reset and enable the carrier.
        reset_n = 1;
        enable = 1;

        @(posedge clk); #1; check_value(4'd1, "Count up 1");
        @(posedge clk); #1; check_value(4'd2, "Count up 2");
        @(posedge clk); #1; check_value(4'd3, "Count up 3");
        @(posedge clk); #1; check_value(4'd4, "Count up 4");
        @(posedge clk); #1; check_value(4'd5, "Count up 5");
        @(posedge clk); #1; check_value(4'd6, "Count up 6");
        @(posedge clk); #1; check_value(4'd7, "Reach maximum");

        @(posedge clk); #1; check_value(4'd6, "Count down 6");
        @(posedge clk); #1; check_value(4'd5, "Count down 5");
        @(posedge clk); #1; check_value(4'd4, "Count down 4");
        @(posedge clk); #1; check_value(4'd3, "Count down 3");
        @(posedge clk); #1; check_value(4'd2, "Count down 2");
        @(posedge clk); #1; check_value(4'd1, "Count down 1");
        @(posedge clk); #1; check_value(4'd0, "Reach minimum");

        @(posedge clk); #1; check_value(4'd1, "Restart upward");

        // Check that disabling freezes the carrier.
        enable = 0;
        @(posedge clk); #1;
        check_value(4'd1, "Enable low holds value");

        if (errors == 0)
            $display("PASS: All triangular carrier tests passed");
        else
            $display("FAIL: %0d test(s) failed", errors);

        $finish;
    end

endmodule
