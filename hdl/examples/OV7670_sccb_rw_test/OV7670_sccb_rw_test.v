/*  ------------------------------------------------
    Module:     OV7670_sccb_rw_test
    Developer:  Jacob Bobson
    Date:       8/30/2024
    ------------------------------------------------
    Description:
    Top level design to test reading and writing to the OV7670 camera
    registers over the SCCB protocol using an I2C master core.

    Read from register, then right to it (A1), then read from it again
    Displays register read value on the BASYS3 7-Segment display
*/

module OV7670_sccb_rw_test (
    input wire        i_clk,
    input wire        i_rst,
    input wire        i_btn,
    output wire [3:0] o_anodes,
    output wire [7:0] o_cathodes
    inout wire siod,
    inout wire sioc
);


/* Debouncers */
localparam CLK_FREQ = 100_000_000;
wire rst_sync, btn_sync;
debouncer #(.CLK_FREQ(CLK_FREQ)) reset_debouncer 
    (.clk(i_clk), .rst(1'b0), .btn_in(i_rst), .btn_out(rst_sync));
debouncer #(.CLK_FREQ(CLK_FREQ)) btn_debouncer 
    (.clk(i_clk), .rst(1'b0), .btn_in(i_btn), .btn_out(btn_sync));

/* 7-Segment Display */
reg [13:0] disp_val = 14'd0;
quad_display disp(
    .clk_i(i_clk), 
    .rst_i(i_rst), 
    .disp_en_i(1'b1),
    .dot_enables_i(4'b0000),
    .disp_num_i(disp_val),
    .anodes_o(o_anodes),
    .cathodes_o(o_cathodes)
);

/* I2C Master */
reg [9:0] i2c_slave_addr;
reg [7:0] i2c_byte_cnt;
reg [3:0] i2c_control_reg;
reg [3:0] i2c_mode_reg;
reg [7:0] i2c_tx_data;
reg i2c_rx_data_valid;
reg i2c_tx_data_needed;
reg [7:0] i2c_rx_data;
reg [4:0] i2c_status_reg;
i2c_master i2c(
    .i_clk(i_clk),
    .i_rst(i_rst),
    .i_slave_addr(i2c_slave_addr),
    .i_byte_cnt(i2c_byte_cnt),
    .i_control_reg(i2c_control_reg),
    .i_mode_reg(i2c_mode_reg),
    .i_tx_data(i2c_tx_data),
    .o_rx_data_valid(i2c_rx_data_valid),
    .o_tx_data_needed(i2c_tx_data_needed),
    .o_rx_data(i2c_rx_data),
    .o_status_reg(i2c_status_reg),
    .io_sda(siod),
    .io_scl(sioc)
);





reg [2:0] state;
/* 
    To communicate with the OV7670:

    SIOC => SCL (pulled up to 3.3V)
    SIOD => SDA (pulled up to 3.3V)
    RESET => 3.3V
    PWDN => GND
    XCLK => Clock signal is necessary (at least 10 Mhz)
    Vcc => 3.3V
    GND => GND

    The XCLK needs at least 10 MHz according to the datasheet, 
    but from other accounts, it seems that's not a hard limit.
*/

//Camera sensor's product ID is 0x7673
// address = 0x42 for write 0x43 for read
// so raw address is 0x21 (USE THIS) 7'b0100001
















endmodule
