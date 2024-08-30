/*  ------------------------------------------------
    Module:     OV7670_cmd_ram
    Developer:  Jacob Bobson
    Date:       8/30/2024
    ------------------------------------------------
    Description:
    Configuration values for the OV7670 camera. Values borrowed from
    https://github.com/AngeloJacobo/FPGA_OV7670_Camera_Interface/blob/main/src/camera_interface.v


    // TODO: need to set this up to use RGB 444 mode, see documentation
*/

module OV7670_cmd_ram (
    input wire        i_clk,
    input wire [7:0]  i_addr,
    output reg [15:0] o_data
);

always @(posedge i_clk) begin
    case(addr)
        /* Data Val = {address,data} */
	    8'd0:  o_data <= 16'h12_80;    // reset all register to default values
	    8'd1:  o_data <= 16'h12_04;    // set output format to RGB
	    8'd2:  o_data <= 16'h15_20;    // pclk will not toggle during horizontal blank
	    8'd3:  o_data <= 16'h40_d0;    // RGB565
        8'd4:  o_data <= 16'h12_04;    // COM7,      set RGB color output
        8'd5:  o_data <= 16'h11_80;    // CLKRC      internal PLL matches input clock
        8'd6:  o_data <= 16'h0C_00;    // COM3,      default settings
        8'd7:  o_data <= 16'h3E_00;    // COM14,     no scaling, normal pclock
        8'd8:  o_data <= 16'h04_00;    // COM1,      disable CCIR656
        8'd9:  o_data <= 16'h40_d0;    // COM15,     RGB565, full output range
        8'd10: o_data <= 16'h3a_04;    // TSLB       set correct output data sequence (magic)
	    8'd11: o_data <= 16'h14_18;    // COM9       MAX AGC value x4 0001_1000
        8'd12: o_data <= 16'h4F_B3;    // MTX1       all of these are magical matrix coefficients
        8'd13: o_data <= 16'h50_B3;    // MTX2
        8'd14: o_data <= 16'h51_00;    // MTX3
        8'd15: o_data <= 16'h52_3d;    // MTX4
        8'd16: o_data <= 16'h53_A7;    // MTX5
        8'd17: o_data <= 16'h54_E4;    // MTX6
        8'd18: o_data <= 16'h58_9E;    // MTXS
        8'd19: o_data <= 16'h3D_C0;    // COM13      sets gamma enable, does not preserve reserved bits, may be wrong?
        8'd20: o_data <= 16'h17_14;    // HSTART     start high 8 bits
        8'd21: o_data <= 16'h18_02;    // HSTOP      stop high 8 bits //these kill the odd colored line
        8'd22: o_data <= 16'h32_80;    // HREF       edge offset
        8'd23: o_data <= 16'h19_03;    // VSTART     start high 8 bits
        8'd24: o_data <= 16'h1A_7B;    // VSTOP      stop high 8 bits
        8'd25: o_data <= 16'h03_0A;    // VREF       vsync edge offset
        8'd26: o_data <= 16'h0F_41;    // COM6       reset timings
        8'd27: o_data <= 16'h1E_00;    // MVFP       disable mirror / flip //might have magic value of 03
        8'd28: o_data <= 16'h33_0B;    // CHLF       //magic value from the internet
        8'd29: o_data <= 16'h3C_78;    // COM12      no HREF when VSYNC low
        8'd30: o_data <= 16'h69_00;    // GFIX       fix gain control
        8'd31: o_data <= 16'h74_00;    // REG74      Digital gain control
        8'd32: o_data <= 16'hB0_84;    // RSVD       magic value from the internet *required* for good color
        8'd33: o_data <= 16'hB1_0c;    // ABLC1
        8'd34: o_data <= 16'hB2_0e;    // RSVD       more magic internet values
        8'd35: o_data <= 16'hB3_80;    // THL_ST
        /* begin mystery scaling numbers */
        8'd36: o_data <= 16'h70_3a;
        8'd37: o_data <= 16'h71_35;
        8'd38: o_data <= 16'h72_11;
        8'd39: o_data <= 16'h73_f0;
        8'd40: o_data <= 16'ha2_02;
        /* gamma curve values */
        8'd41: o_data <= 16'h7a_20;
        8'd42: o_data <= 16'h7b_10;
        8'd43: o_data <= 16'h7c_1e;
        8'd44: o_data <= 16'h7d_35;
        8'd45: o_data <= 16'h7e_5a;
        8'd46: o_data <= 16'h7f_69;
        8'd47: o_data <= 16'h80_76;
        8'd48: o_data <= 16'h81_80;
        8'd49: o_data <= 16'h82_88;
        8'd50: o_data <= 16'h83_8f;
        8'd51: o_data <= 16'h84_96;
        8'd52: o_data <= 16'h85_a3;
        8'd53: o_data <= 16'h86_af;
        8'd54: o_data <= 16'h87_c4;
        8'd55: o_data <= 16'h88_d7;
        8'd56: o_data <= 16'h89_e8;
        /* AGC and AEC */
        8'd57: o_data <= 16'h13_e0;    // COM8, disable AGC / AEC
        8'd58: o_data <= 16'h00_00;    // set gain reg to 0 for AGC
        8'd59: o_data <= 16'h10_00;    // set ARCJ reg to 0
        8'd60: o_data <= 16'h0d_40;    // magic reserved bit for COM4
        8'd61: o_data <= 16'h14_18;    // COM9, 4x gain + magic bit
        8'd62: o_data <= 16'ha5_05;    // BD50MAX
        8'd63: o_data <= 16'hab_07;    // DB60MAX
        8'd64: o_data <= 16'h24_95;    // AGC upper limit
        8'd65: o_data <= 16'h25_33;    // AGC lower limit
        8'd66: o_data <= 16'h26_e3;    // AGC/AEC fast mode op region
        8'd67: o_data <= 16'h9f_78;    // HAECC1
        8'd68: o_data <= 16'ha0_68;    // HAECC2
        8'd69: o_data <= 16'ha1_03;    // magic
        8'd70: o_data <= 16'ha6_d8;    // HAECC3
        8'd71: o_data <= 16'ha7_d8;    // HAECC4
        8'd72: o_data <= 16'ha8_f0;    // HAECC5
        8'd73: o_data <= 16'ha9_90;    // HAECC6
        8'd74: o_data <= 16'haa_94;    // HAECC7
        8'd75: o_data <= 16'h13_e5;    // COM8, enable AGC / AEC
	    8'd76: o_data <= 16'h1E_23;    // Mirror Image
	    8'd77: o_data <= 16'h69_06;    // gain of RGB(manually adjusted)
        default: o_data <= 16'h00_00
    endcase
end

endmodule