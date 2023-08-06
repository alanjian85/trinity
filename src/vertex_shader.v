// Copyright (C) 2023 Alan Jian (alanjian85@outlook.com)
// SPDX-License-Identifier: GPL-3.0

(* use_dsp = "yes" *) module vertex_shader(
        input clk_pix,
        output reg [8:0] rom_addr,
        input signed [11:0] sin,
        input signed [11:0] cos,
        output [9:0] ax,
        output [9:0] ay,
        output [9:0] bx,
        output [9:0] by,
        output [9:0] cx,
        output [9:0] cy
    );

    initial begin
        rom_addr = 0;
    end

    wire signed [18:0] sin120_fixed = 120 * sin;
    wire signed [8:0] sin120 = sin120_fixed[18:10];
    wire signed [18:0] cos120_fixed = 120 * cos;
    wire signed [8:0] cos120 = cos120_fixed[18:10];

    wire signed [19:0] sin140_fixed = 140 * sin;
    wire signed [9:0] sin140 = sin140_fixed[19:10];
    wire signed [19:0] cos140_fixed = 140 * cos;
    wire signed [9:0] cos140 = cos140_fixed[19:10];

    assign ax = 320 - sin120;
    assign ay = 240 + cos120;
    assign bx = 320 - cos140 + sin120;
    assign by = 240 - sin140 - cos120;
    assign cx = 320 + cos140 + sin120;
    assign cy = 240 + sin140 - cos120;

    reg [18:0] cnt = 0;
    always @(posedge clk_pix) begin
        if (cnt == 19'd333333) begin
            cnt <= 0;
            if (rom_addr == 9'd359) begin
                rom_addr <= 0;
            end else
                rom_addr <= rom_addr + 1;
        end else begin
            cnt <= cnt + 1;
        end
    end

endmodule