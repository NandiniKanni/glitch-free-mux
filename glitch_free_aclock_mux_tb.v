module glitch_free_aclock_mux_tb;

    reg clk1 = 0, clk2 = 0, rst = 1, select = 0;
    wire clk_out;

    glitch_free_aclock_mux uut (
        .clk1(clk1),
        .clk2(clk2),
        .rst(rst),
        .select(select),
        .clk_out(clk_out)
    );

    // clk1: 10ns period
    always #5 clk1 = ~clk1;

    // clk2: 6ns period
    always #3 clk2 = ~clk2;

    initial begin
        #10;
        rst = 1;
        #20;
        rst = 0;
        #20;
        select = 0;
        #50;

        select = 1;        // select clk2
        #50;

        select = 0;        // back to clk1
        #100;
        $finish;
    end

endmodule

