module glitch_free_aclock_mux (
    input wire clk1,
    input wire clk2,
    input wire rst,
    input wire select,       // asynchronous select
    output reg clk_out
);// Flip-flops for clk1 domain
    reg sel_clk1_ff1, sel_clk1_ff2;
    // Flip-flops for clk2 domain
    reg sel_clk2_ff1, sel_clk2_ff2;

    // Synchronize select to clk1
    always @(posedge clk1 or posedge rst) begin
        if (rst) begin
            sel_clk1_ff1 <= 0;
            sel_clk1_ff2 <= 0;
        end else begin
            sel_clk1_ff1 <= select;
            sel_clk1_ff2 <= sel_clk1_ff1;
        end
    end// Synchronize select to clk2
    always @(posedge clk2 or posedge rst) begin
        if (rst) begin
            sel_clk2_ff1 <= 0;
            sel_clk2_ff2 <= 0;
        end else begin
            sel_clk2_ff1 <= select;
            sel_clk2_ff2 <= sel_clk2_ff1;
        end
    end

   always @(*) begin
        if (sel_clk2_ff2)
            clk_out = clk2;
        else
            clk_out = clk1;
    end
endmodule

