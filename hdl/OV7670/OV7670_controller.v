/*  ------------------------------------------------
    Module:     OV7670_controller
    Developer:  Jacob Bobson
    Date:       8/30/2024
    ------------------------------------------------
    Description:
    Handle configuration, reset, and power down control for


    // TODO: need to set this up to use RGB 444 mode, see documentation
*/

module OV7670_controller (
    input wire i_clk,
    input wire i_rst,
    input wire i_valid,
    input wire [1:0] i_cmd,
    output reg o_ready,
    output reg o_cam_pwdn,
    output reg o_cam_rst,
    inout wire cam_siod,
    inout wire cam_sioc
);













endmodule