/*
 * Copyright (c) 2020-2021 Wuklab, UC San Diego. All rights reserved.
 *
 * This is the top-level design for the 2x100G @ VCU118 design.
 */

`timescale 1ns / 1ps

module fpga (
    /*
     * Clock: 125MHz LVDS
     * Reset: Push button, active low
     */
    input  wire         clk_125mhz_p,
    input  wire         clk_125mhz_n,
    input  wire         reset,

    /*
     * GPIO
     */
    output wire [7:0]   led,
    output wire [7:0]   pmod0,
    output wire [7:0]   pmod1,

    /*
     * I2C for board management
     */
    inout  wire         i2c_scl,
    inout  wire         i2c_sda,
    output wire         i2c_mux_reset,

    /*
     * Ethernet: QSFP28
     * QSFP1
     */
    output wire         qsfp1_tx1_p,
    output wire         qsfp1_tx1_n,
    input  wire         qsfp1_rx1_p,
    input  wire         qsfp1_rx1_n,
    output wire         qsfp1_tx2_p,
    output wire         qsfp1_tx2_n,
    input  wire         qsfp1_rx2_p,
    input  wire         qsfp1_rx2_n,
    output wire         qsfp1_tx3_p,
    output wire         qsfp1_tx3_n,
    input  wire         qsfp1_rx3_p,
    input  wire         qsfp1_rx3_n,
    output wire         qsfp1_tx4_p,
    output wire         qsfp1_tx4_n,
    input  wire         qsfp1_rx4_p,
    input  wire         qsfp1_rx4_n,
    input  wire         qsfp1_mgt_refclk_0_p,
    input  wire         qsfp1_mgt_refclk_0_n,
    // input  wire         qsfp1_mgt_refclk_1_p,
    // input  wire         qsfp1_mgt_refclk_1_n,
    // output wire         qsfp1_recclk_p,
    // output wire         qsfp1_recclk_n,
    output wire         qsfp1_modsell,
    output wire         qsfp1_resetl,
    input  wire         qsfp1_modprsl,
    input  wire         qsfp1_intl,
    output wire         qsfp1_lpmode,

    /*
     * Ethernet: QSFP28
     * QSFP2
     */
    output wire         qsfp2_tx1_p,
    output wire         qsfp2_tx1_n,
    input  wire         qsfp2_rx1_p,
    input  wire         qsfp2_rx1_n,
    output wire         qsfp2_tx2_p,
    output wire         qsfp2_tx2_n,
    input  wire         qsfp2_rx2_p,
    input  wire         qsfp2_rx2_n,
    output wire         qsfp2_tx3_p,
    output wire         qsfp2_tx3_n,
    input  wire         qsfp2_rx3_p,
    input  wire         qsfp2_rx3_n,
    output wire         qsfp2_tx4_p,
    output wire         qsfp2_tx4_n,
    input  wire         qsfp2_rx4_p,
    input  wire         qsfp2_rx4_n,
    input  wire         qsfp2_mgt_refclk_0_p,
    input  wire         qsfp2_mgt_refclk_0_n,
    // input  wire         qsfp2_mgt_refclk_1_p,
    // input  wire         qsfp2_mgt_refclk_1_n,
    // output wire         qsfp2_recclk_p,
    // output wire         qsfp2_recclk_n,
    output wire         qsfp2_modsell,
    output wire         qsfp2_resetl,
    input  wire         qsfp2_modprsl,
    input  wire         qsfp2_intl,
    output wire         qsfp2_lpmode,

    input wire          clk_lol,

    /*
     * FMC+: QSFP28
     * QSFP3
     * Bank 120 DP20-DP23
     *
     * This is the QSFP2 in the HTG board schematic.
     */
    output wire         qsfp3_tx1_p,
    output wire         qsfp3_tx1_n,
    input  wire         qsfp3_rx1_p,
    input  wire         qsfp3_rx1_n,
    output wire         qsfp3_tx2_p,
    output wire         qsfp3_tx2_n,
    input  wire         qsfp3_rx2_p,
    input  wire         qsfp3_rx2_n,
    output wire         qsfp3_tx3_p,
    output wire         qsfp3_tx3_n,
    input  wire         qsfp3_rx3_p,
    input  wire         qsfp3_rx3_n,
    output wire         qsfp3_tx4_p,
    output wire         qsfp3_tx4_n,
    input  wire         qsfp3_rx4_p,
    input  wire         qsfp3_rx4_n,
    input  wire         qsfp3_mgt_refclk_0_p,
    input  wire         qsfp3_mgt_refclk_0_n,
    // input  wire         qsfp3_mgt_refclk_1_p,
    // input  wire         qsfp3_mgt_refclk_1_n,
    // output wire         qsfp3_recclk_p,
    // output wire         qsfp3_recclk_n,
    output wire         qsfp3_modsell,
    output wire         qsfp3_resetl,
    input  wire         qsfp3_modprsl,
    input  wire         qsfp3_intl,
    output wire         qsfp3_lpmode,

    /*
     * FMC+: QSFP28
     * QSFP4
     * Bank 121 DP0-DP3
     */
    output wire         qsfp4_tx1_p,
    output wire         qsfp4_tx1_n,
    input  wire         qsfp4_rx1_p,
    input  wire         qsfp4_rx1_n,
    output wire         qsfp4_tx2_p,
    output wire         qsfp4_tx2_n,
    input  wire         qsfp4_rx2_p,
    input  wire         qsfp4_rx2_n,
    output wire         qsfp4_tx3_p,
    output wire         qsfp4_tx3_n,
    input  wire         qsfp4_rx3_p,
    input  wire         qsfp4_rx3_n,
    output wire         qsfp4_tx4_p,
    output wire         qsfp4_tx4_n,
    input  wire         qsfp4_rx4_p,
    input  wire         qsfp4_rx4_n,
    input  wire         qsfp4_mgt_refclk_0_p,
    input  wire         qsfp4_mgt_refclk_0_n,
    // input  wire         qsfp4_mgt_refclk_1_p,
    // input  wire         qsfp4_mgt_refclk_1_n,
    // output wire         qsfp4_recclk_p,
    // output wire         qsfp4_recclk_n,
    output wire         qsfp4_modsell,
    output wire         qsfp4_resetl,
    input  wire         qsfp4_modprsl,
    input  wire         qsfp4_intl,
    output wire         qsfp4_lpmode,

    /*
     * QSFP5
     */
    output wire         qsfp5_tx1_p,
    output wire         qsfp5_tx1_n,
    input  wire         qsfp5_rx1_p,
    input  wire         qsfp5_rx1_n,
    output wire         qsfp5_tx2_p,
    output wire         qsfp5_tx2_n,
    input  wire         qsfp5_rx2_p,
    input  wire         qsfp5_rx2_n,
    output wire         qsfp5_tx3_p,
    output wire         qsfp5_tx3_n,
    input  wire         qsfp5_rx3_p,
    input  wire         qsfp5_rx3_n,
    output wire         qsfp5_tx4_p,
    output wire         qsfp5_tx4_n,
    input  wire         qsfp5_rx4_p,
    input  wire         qsfp5_rx4_n,
    input  wire         qsfp5_mgt_refclk_0_p,
    input  wire         qsfp5_mgt_refclk_0_n,
    // input  wire         qsfp5_mgt_refclk_1_p,
    // input  wire         qsfp5_mgt_refclk_1_n,
    // output wire         qsfp5_recclk_p,
    // output wire         qsfp5_recclk_n,
    output wire         qsfp5_modsell,
    output wire         qsfp5_resetl,
    input  wire         qsfp5_modprsl,
    input  wire         qsfp5_intl,
    output wire         qsfp5_lpmode,

    /*
     * QSFP6
     */
    output wire         qsfp6_tx1_p,
    output wire         qsfp6_tx1_n,
    input  wire         qsfp6_rx1_p,
    input  wire         qsfp6_rx1_n,
    output wire         qsfp6_tx2_p,
    output wire         qsfp6_tx2_n,
    input  wire         qsfp6_rx2_p,
    input  wire         qsfp6_rx2_n,
    output wire         qsfp6_tx3_p,
    output wire         qsfp6_tx3_n,
    input  wire         qsfp6_rx3_p,
    input  wire         qsfp6_rx3_n,
    output wire         qsfp6_tx4_p,
    output wire         qsfp6_tx4_n,
    input  wire         qsfp6_rx4_p,
    input  wire         qsfp6_rx4_n,
    input  wire         qsfp6_mgt_refclk_0_p,
    input  wire         qsfp6_mgt_refclk_0_n,
    // input  wire         qsfp6_mgt_refclk_1_p,
    // input  wire         qsfp6_mgt_refclk_1_n,
    // output wire         qsfp6_recclk_p,
    // output wire         qsfp6_recclk_n,
    output wire         qsfp6_modsell,
    output wire         qsfp6_resetl,
    input  wire         qsfp6_modprsl,
    input  wire         qsfp6_intl,
    output wire         qsfp6_lpmode,

    /*
     * QSFP7
     */
    output wire         qsfp7_tx1_p,
    output wire         qsfp7_tx1_n,
    input  wire         qsfp7_rx1_p,
    input  wire         qsfp7_rx1_n,
    output wire         qsfp7_tx2_p,
    output wire         qsfp7_tx2_n,
    input  wire         qsfp7_rx2_p,
    input  wire         qsfp7_rx2_n,
    output wire         qsfp7_tx3_p,
    output wire         qsfp7_tx3_n,
    input  wire         qsfp7_rx3_p,
    input  wire         qsfp7_rx3_n,
    output wire         qsfp7_tx4_p,
    output wire         qsfp7_tx4_n,
    input  wire         qsfp7_rx4_p,
    input  wire         qsfp7_rx4_n,
    input  wire         qsfp7_mgt_refclk_0_p,
    input  wire         qsfp7_mgt_refclk_0_n,
    // input  wire         qsfp7_mgt_refclk_1_p,
    // input  wire         qsfp7_mgt_refclk_1_n,
    // output wire         qsfp7_recclk_p,
    // output wire         qsfp7_recclk_n,
    output wire         qsfp7_modsell,
    output wire         qsfp7_resetl,
    input  wire         qsfp7_modprsl,
    input  wire         qsfp7_intl,
    output wire         qsfp7_lpmode,

    /*
     * QSFP8
     */
    output wire         qsfp8_tx1_p,
    output wire         qsfp8_tx1_n,
    input  wire         qsfp8_rx1_p,
    input  wire         qsfp8_rx1_n,
    output wire         qsfp8_tx2_p,
    output wire         qsfp8_tx2_n,
    input  wire         qsfp8_rx2_p,
    input  wire         qsfp8_rx2_n,
    output wire         qsfp8_tx3_p,
    output wire         qsfp8_tx3_n,
    input  wire         qsfp8_rx3_p,
    input  wire         qsfp8_rx3_n,
    output wire         qsfp8_tx4_p,
    output wire         qsfp8_tx4_n,
    input  wire         qsfp8_rx4_p,
    input  wire         qsfp8_rx4_n,
    input  wire         qsfp8_mgt_refclk_0_p,
    input  wire         qsfp8_mgt_refclk_0_n,
    // input  wire         qsfp8_mgt_refclk_1_p,
    // input  wire         qsfp8_mgt_refclk_1_n,
    // output wire         qsfp8_recclk_p,
    // output wire         qsfp8_recclk_n,
    output wire         qsfp8_modsell,
    output wire         qsfp8_resetl,
    input  wire         qsfp8_modprsl,
    input  wire         qsfp8_intl,
    output wire         qsfp8_lpmode
);

parameter AXIS_ETH_DATA_WIDTH = 512;
parameter AXIS_ETH_KEEP_WIDTH = AXIS_ETH_DATA_WIDTH/8;

wire clk_250mhz;
wire clk_250mhz_rst;
wire clk_125mhz;
wire clk_125mhz_rst;
wire clk_locked;

wire mmcm_rst = reset;

sysclk_bd sysclk_bd_inst (
        .clk_125mhz (clk_125mhz),
        .clk_250mhz (clk_250mhz),
        .clk_locked (clk_locked),

        .reset_0 (mmcm_rst),
        .sysclk_125_clk_n (clk_125mhz_n),
        .sysclk_125_clk_p (clk_125mhz_p)
);

sync_reset #(
    .N(4)
)
sync_reset_125mhz_inst (
    .clk(clk_125mhz),
    .rst(~clk_locked),
    .out(clk_125mhz_rst)
);

sync_reset #(
    .N(4)
)
sync_reset_125mhz_qsfp_inst (
    .clk(clk_125mhz),
    .rst(clk_125mhz_rst | ~clk_lol),
    .out(clk_125mhz_rst_qsfp)
);

sync_reset #(
    .N(4)
)
sync_reset_250mhz_inst (
    .clk(clk_250mhz),
    .rst(~clk_locked),
    .out(clk_250mhz_rst)
);

/*
 * NOTE CHECK
 * The following I2C code was used when I was just using 2 built-in QSFP
 * Since we now need to use I2C mux, I comment out this code.
 */
/* reg i2c_scl_o_reg = 1'b1; */
/* reg i2c_sda_o_reg = 1'b1; */
/*  */
/* wire i2c_scl_i; */
/* wire i2c_scl_o; */
/* wire i2c_scl_t; */
/* wire i2c_sda_i; */
/* wire i2c_sda_o; */
/* wire i2c_sda_t; */
/*  */
/* assign i2c_scl_o = i2c_scl_o_reg; */
/* assign i2c_scl_t = i2c_scl_o_reg; */
/* assign i2c_sda_o = i2c_sda_o_reg; */
/* assign i2c_sda_t = i2c_sda_o_reg; */

// I2C
assign i2c_scl_i = i2c_scl;
assign i2c_scl = i2c_scl_t ? 1'bz : i2c_scl_o;
assign i2c_sda_i = i2c_sda;
assign i2c_sda = i2c_sda_t ? 1'bz : i2c_sda_o;

wire [6:0] si5341_i2c_cmd_address;
wire si5341_i2c_cmd_start;
wire si5341_i2c_cmd_read;
wire si5341_i2c_cmd_write;
wire si5341_i2c_cmd_write_multiple;
wire si5341_i2c_cmd_stop;
wire si5341_i2c_cmd_valid;
wire si5341_i2c_cmd_ready;

wire [7:0] si5341_i2c_data;
wire si5341_i2c_data_valid;
wire si5341_i2c_data_ready;
wire si5341_i2c_data_last;

wire si5341_i2c_init_busy;

assign i2c_mux_reset = clk_125mhz_rst;

// delay start by ~10 ms
reg [20:0] si5341_i2c_init_start_delay = 21'd0;

always @(posedge clk_125mhz) begin
    if (clk_125mhz_rst) begin
        si5341_i2c_init_start_delay <= 21'd0;
    end else begin
        if (!si5341_i2c_init_start_delay[20]) begin
            si5341_i2c_init_start_delay <= si5341_i2c_init_start_delay + 21'd1;
        end
    end
end

si5341_i2c_init
si5341_i2c_init_inst (
    .clk(clk_125mhz),
    .rst(clk_125mhz_rst),
    .cmd_address(si5341_i2c_cmd_address),
    .cmd_start(si5341_i2c_cmd_start),
    .cmd_read(si5341_i2c_cmd_read),
    .cmd_write(si5341_i2c_cmd_write),
    .cmd_write_multiple(si5341_i2c_cmd_write_multiple),
    .cmd_stop(si5341_i2c_cmd_stop),
    .cmd_valid(si5341_i2c_cmd_valid),
    .cmd_ready(si5341_i2c_cmd_ready),
    .data_out(si5341_i2c_data),
    .data_out_valid(si5341_i2c_data_valid),
    .data_out_ready(si5341_i2c_data_ready),
    .data_out_last(si5341_i2c_data_last),
    .busy(si5341_i2c_init_busy),
    .start(si5341_i2c_init_start_delay[20])
);

i2c_master
si5341_i2c_master_inst (
    .clk(clk_125mhz),
    .rst(clk_125mhz_rst),
    .cmd_address(si5341_i2c_cmd_address),
    .cmd_start(si5341_i2c_cmd_start),
    .cmd_read(si5341_i2c_cmd_read),
    .cmd_write(si5341_i2c_cmd_write),
    .cmd_write_multiple(si5341_i2c_cmd_write_multiple),
    .cmd_stop(si5341_i2c_cmd_stop),
    .cmd_valid(si5341_i2c_cmd_valid),
    .cmd_ready(si5341_i2c_cmd_ready),
    .data_in(si5341_i2c_data),
    .data_in_valid(si5341_i2c_data_valid),
    .data_in_ready(si5341_i2c_data_ready),
    .data_in_last(si5341_i2c_data_last),
    .data_out(),
    .data_out_valid(),
    .data_out_ready(1),
    .data_out_last(),
    .scl_i(i2c_scl_i),
    .scl_o(i2c_scl_o),
    .scl_t(i2c_scl_t),
    .sda_i(i2c_sda_i),
    .sda_o(i2c_sda_o),
    .sda_t(i2c_sda_t),
    .busy(),
    .bus_control(),
    .bus_active(),
    .missed_ack(),
    .prescale(312),
    .stop_on_idle(1)
);

// GPIO
wire qsfp1_modprsl_int;
wire qsfp2_modprsl_int;
wire qsfp3_modprsl_int;
wire qsfp4_modprsl_int;
wire qsfp5_modprsl_int;
wire qsfp6_modprsl_int;
wire qsfp7_modprsl_int;
wire qsfp8_modprsl_int;
wire qsfp1_intl_int;
wire qsfp2_intl_int;
wire qsfp3_intl_int;
wire qsfp4_intl_int;
wire qsfp5_intl_int;
wire qsfp6_intl_int;
wire qsfp7_intl_int;
wire qsfp8_intl_int;

sync_signal #(
    .WIDTH(18),
    .N(2)
)
sync_signal_inst (
    .clk(clk_250mhz),
    .in({
        qsfp1_modprsl,
        qsfp2_modprsl,
        qsfp3_modprsl,
        qsfp4_modprsl,
        qsfp5_modprsl,
        qsfp6_modprsl,
        qsfp7_modprsl,
        qsfp8_modprsl,
        qsfp1_intl,
        qsfp2_intl,
        qsfp3_intl,
        qsfp4_intl,
        qsfp5_intl,
        qsfp6_intl,
        qsfp7_intl,
        qsfp8_intl
        /* i2c_scl, */
        /* i2c_sda */
    }),
    .out({
        qsfp1_modprsl_int,
        qsfp2_modprsl_int,
        qsfp3_modprsl_int,
        qsfp4_modprsl_int,
        qsfp5_modprsl_int,
        qsfp6_modprsl_int,
        qsfp7_modprsl_int,
        qsfp8_modprsl_int,
        qsfp1_intl_int,
        qsfp2_intl_int,
        qsfp3_intl_int,
        qsfp4_intl_int,
        qsfp5_intl_int,
        qsfp6_intl_int,
        qsfp7_intl_int,
        qsfp8_intl_int
        /* i2c_scl_i, */
        /* i2c_sda_i */
    })
);

/* assign i2c_scl = i2c_scl_t ? 1'bz : i2c_scl_o; */
/* assign i2c_sda = i2c_sda_t ? 1'bz : i2c_sda_o; */

// CMAC
wire                           qsfp1_tx_clk_int;
wire                           qsfp1_tx_rst_int;

wire [AXIS_ETH_DATA_WIDTH-1:0] qsfp1_tx_axis_tdata_int;
wire [AXIS_ETH_KEEP_WIDTH-1:0] qsfp1_tx_axis_tkeep_int;
wire                           qsfp1_tx_axis_tvalid_int;
wire                           qsfp1_tx_axis_tready_int;
wire                           qsfp1_tx_axis_tlast_int;
wire                           qsfp1_tx_axis_tuser_int;

wire [AXIS_ETH_DATA_WIDTH-1:0] qsfp1_mac_tx_axis_tdata;
wire [AXIS_ETH_KEEP_WIDTH-1:0] qsfp1_mac_tx_axis_tkeep;
wire                           qsfp1_mac_tx_axis_tvalid;
wire                           qsfp1_mac_tx_axis_tready;
wire                           qsfp1_mac_tx_axis_tlast;
wire                           qsfp1_mac_tx_axis_tuser;

wire                           qsfp1_rx_clk_int;
wire                           qsfp1_rx_rst_int;

wire [AXIS_ETH_DATA_WIDTH-1:0] qsfp1_rx_axis_tdata_int;
wire [AXIS_ETH_KEEP_WIDTH-1:0] qsfp1_rx_axis_tkeep_int;
wire                           qsfp1_rx_axis_tvalid_int;
wire                           qsfp1_rx_axis_tlast_int;
wire                           qsfp1_rx_axis_tuser_int;

// CMAC
wire                           qsfp2_tx_clk_int;
wire                           qsfp2_tx_rst_int;

wire [AXIS_ETH_DATA_WIDTH-1:0] qsfp2_tx_axis_tdata_int;
wire [AXIS_ETH_KEEP_WIDTH-1:0] qsfp2_tx_axis_tkeep_int;
wire                           qsfp2_tx_axis_tvalid_int;
wire                           qsfp2_tx_axis_tready_int;
wire                           qsfp2_tx_axis_tlast_int;
wire                           qsfp2_tx_axis_tuser_int;

wire [AXIS_ETH_DATA_WIDTH-1:0] qsfp2_mac_tx_axis_tdata;
wire [AXIS_ETH_KEEP_WIDTH-1:0] qsfp2_mac_tx_axis_tkeep;
wire                           qsfp2_mac_tx_axis_tvalid;
wire                           qsfp2_mac_tx_axis_tready;
wire                           qsfp2_mac_tx_axis_tlast;
wire                           qsfp2_mac_tx_axis_tuser;

wire                           qsfp2_rx_clk_int;
wire                           qsfp2_rx_rst_int;

wire [AXIS_ETH_DATA_WIDTH-1:0] qsfp2_rx_axis_tdata_int;
wire [AXIS_ETH_KEEP_WIDTH-1:0] qsfp2_rx_axis_tkeep_int;
wire                           qsfp2_rx_axis_tvalid_int;
wire                           qsfp2_rx_axis_tlast_int;
wire                           qsfp2_rx_axis_tuser_int;

// CMAC
wire                           qsfp3_tx_clk_int;
wire                           qsfp3_tx_rst_int;

wire [AXIS_ETH_DATA_WIDTH-1:0] qsfp3_tx_axis_tdata_int;
wire [AXIS_ETH_KEEP_WIDTH-1:0] qsfp3_tx_axis_tkeep_int;
wire                           qsfp3_tx_axis_tvalid_int;
wire                           qsfp3_tx_axis_tready_int;
wire                           qsfp3_tx_axis_tlast_int;
wire                           qsfp3_tx_axis_tuser_int;

wire [AXIS_ETH_DATA_WIDTH-1:0] qsfp3_mac_tx_axis_tdata;
wire [AXIS_ETH_KEEP_WIDTH-1:0] qsfp3_mac_tx_axis_tkeep;
wire                           qsfp3_mac_tx_axis_tvalid;
wire                           qsfp3_mac_tx_axis_tready;
wire                           qsfp3_mac_tx_axis_tlast;
wire                           qsfp3_mac_tx_axis_tuser;

wire                           qsfp3_rx_clk_int;
wire                           qsfp3_rx_rst_int;

wire [AXIS_ETH_DATA_WIDTH-1:0] qsfp3_rx_axis_tdata_int;
wire [AXIS_ETH_KEEP_WIDTH-1:0] qsfp3_rx_axis_tkeep_int;
wire                           qsfp3_rx_axis_tvalid_int;
wire                           qsfp3_rx_axis_tlast_int;
wire                           qsfp3_rx_axis_tuser_int;

// CMAC
wire                           qsfp4_tx_clk_int;
wire                           qsfp4_tx_rst_int;

wire [AXIS_ETH_DATA_WIDTH-1:0] qsfp4_tx_axis_tdata_int;
wire [AXIS_ETH_KEEP_WIDTH-1:0] qsfp4_tx_axis_tkeep_int;
wire                           qsfp4_tx_axis_tvalid_int;
wire                           qsfp4_tx_axis_tready_int;
wire                           qsfp4_tx_axis_tlast_int;
wire                           qsfp4_tx_axis_tuser_int;

wire [AXIS_ETH_DATA_WIDTH-1:0] qsfp4_mac_tx_axis_tdata;
wire [AXIS_ETH_KEEP_WIDTH-1:0] qsfp4_mac_tx_axis_tkeep;
wire                           qsfp4_mac_tx_axis_tvalid;
wire                           qsfp4_mac_tx_axis_tready;
wire                           qsfp4_mac_tx_axis_tlast;
wire                           qsfp4_mac_tx_axis_tuser;

wire                           qsfp4_rx_clk_int;
wire                           qsfp4_rx_rst_int;

wire [AXIS_ETH_DATA_WIDTH-1:0] qsfp4_rx_axis_tdata_int;
wire [AXIS_ETH_KEEP_WIDTH-1:0] qsfp4_rx_axis_tkeep_int;
wire                           qsfp4_rx_axis_tvalid_int;
wire                           qsfp4_rx_axis_tlast_int;
wire                           qsfp4_rx_axis_tuser_int;

// CMAC
wire                           qsfp5_tx_clk_int;
wire                           qsfp5_tx_rst_int;

wire [AXIS_ETH_DATA_WIDTH-1:0] qsfp5_tx_axis_tdata_int;
wire [AXIS_ETH_KEEP_WIDTH-1:0] qsfp5_tx_axis_tkeep_int;
wire                           qsfp5_tx_axis_tvalid_int;
wire                           qsfp5_tx_axis_tready_int;
wire                           qsfp5_tx_axis_tlast_int;
wire                           qsfp5_tx_axis_tuser_int;

wire [AXIS_ETH_DATA_WIDTH-1:0] qsfp5_mac_tx_axis_tdata;
wire [AXIS_ETH_KEEP_WIDTH-1:0] qsfp5_mac_tx_axis_tkeep;
wire                           qsfp5_mac_tx_axis_tvalid;
wire                           qsfp5_mac_tx_axis_tready;
wire                           qsfp5_mac_tx_axis_tlast;
wire                           qsfp5_mac_tx_axis_tuser;

wire                           qsfp5_rx_clk_int;
wire                           qsfp5_rx_rst_int;

wire [AXIS_ETH_DATA_WIDTH-1:0] qsfp5_rx_axis_tdata_int;
wire [AXIS_ETH_KEEP_WIDTH-1:0] qsfp5_rx_axis_tkeep_int;
wire                           qsfp5_rx_axis_tvalid_int;
wire                           qsfp5_rx_axis_tlast_int;
wire                           qsfp5_rx_axis_tuser_int;

// CMAC
wire                           qsfp6_tx_clk_int;
wire                           qsfp6_tx_rst_int;

wire [AXIS_ETH_DATA_WIDTH-1:0] qsfp6_tx_axis_tdata_int;
wire [AXIS_ETH_KEEP_WIDTH-1:0] qsfp6_tx_axis_tkeep_int;
wire                           qsfp6_tx_axis_tvalid_int;
wire                           qsfp6_tx_axis_tready_int;
wire                           qsfp6_tx_axis_tlast_int;
wire                           qsfp6_tx_axis_tuser_int;

wire [AXIS_ETH_DATA_WIDTH-1:0] qsfp6_mac_tx_axis_tdata;
wire [AXIS_ETH_KEEP_WIDTH-1:0] qsfp6_mac_tx_axis_tkeep;
wire                           qsfp6_mac_tx_axis_tvalid;
wire                           qsfp6_mac_tx_axis_tready;
wire                           qsfp6_mac_tx_axis_tlast;
wire                           qsfp6_mac_tx_axis_tuser;

wire                           qsfp6_rx_clk_int;
wire                           qsfp6_rx_rst_int;

wire [AXIS_ETH_DATA_WIDTH-1:0] qsfp6_rx_axis_tdata_int;
wire [AXIS_ETH_KEEP_WIDTH-1:0] qsfp6_rx_axis_tkeep_int;
wire                           qsfp6_rx_axis_tvalid_int;
wire                           qsfp6_rx_axis_tlast_int;
wire                           qsfp6_rx_axis_tuser_int;

// CMAC
wire                           qsfp7_tx_clk_int;
wire                           qsfp7_tx_rst_int;

wire [AXIS_ETH_DATA_WIDTH-1:0] qsfp7_tx_axis_tdata_int;
wire [AXIS_ETH_KEEP_WIDTH-1:0] qsfp7_tx_axis_tkeep_int;
wire                           qsfp7_tx_axis_tvalid_int;
wire                           qsfp7_tx_axis_tready_int;
wire                           qsfp7_tx_axis_tlast_int;
wire                           qsfp7_tx_axis_tuser_int;

wire [AXIS_ETH_DATA_WIDTH-1:0] qsfp7_mac_tx_axis_tdata;
wire [AXIS_ETH_KEEP_WIDTH-1:0] qsfp7_mac_tx_axis_tkeep;
wire                           qsfp7_mac_tx_axis_tvalid;
wire                           qsfp7_mac_tx_axis_tready;
wire                           qsfp7_mac_tx_axis_tlast;
wire                           qsfp7_mac_tx_axis_tuser;

wire                           qsfp7_rx_clk_int;
wire                           qsfp7_rx_rst_int;

wire [AXIS_ETH_DATA_WIDTH-1:0] qsfp7_rx_axis_tdata_int;
wire [AXIS_ETH_KEEP_WIDTH-1:0] qsfp7_rx_axis_tkeep_int;
wire                           qsfp7_rx_axis_tvalid_int;
wire                           qsfp7_rx_axis_tlast_int;
wire                           qsfp7_rx_axis_tuser_int;

// CMAC
wire                           qsfp8_tx_clk_int;
wire                           qsfp8_tx_rst_int;

wire [AXIS_ETH_DATA_WIDTH-1:0] qsfp8_tx_axis_tdata_int;
wire [AXIS_ETH_KEEP_WIDTH-1:0] qsfp8_tx_axis_tkeep_int;
wire                           qsfp8_tx_axis_tvalid_int;
wire                           qsfp8_tx_axis_tready_int;
wire                           qsfp8_tx_axis_tlast_int;
wire                           qsfp8_tx_axis_tuser_int;

wire [AXIS_ETH_DATA_WIDTH-1:0] qsfp8_mac_tx_axis_tdata;
wire [AXIS_ETH_KEEP_WIDTH-1:0] qsfp8_mac_tx_axis_tkeep;
wire                           qsfp8_mac_tx_axis_tvalid;
wire                           qsfp8_mac_tx_axis_tready;
wire                           qsfp8_mac_tx_axis_tlast;
wire                           qsfp8_mac_tx_axis_tuser;

wire                           qsfp8_rx_clk_int;
wire                           qsfp8_rx_rst_int;

wire [AXIS_ETH_DATA_WIDTH-1:0] qsfp8_rx_axis_tdata_int;
wire [AXIS_ETH_KEEP_WIDTH-1:0] qsfp8_rx_axis_tkeep_int;
wire                           qsfp8_rx_axis_tvalid_int;
wire                           qsfp8_rx_axis_tlast_int;
wire                           qsfp8_rx_axis_tuser_int;

/*
 * Board IDs
 */ 
parameter BOARD_ID = {16'h10ee, 16'h9076};
parameter FPGA_ID = 32'h4B31093;

/*
 * Setup those QSFP configuration registers
 * Those default values are adopted from Corundum.
 */
reg qsfp1_reset_reg = 1'b0;
reg qsfp2_reset_reg = 1'b0;
reg qsfp3_reset_reg = 1'b0;
reg qsfp4_reset_reg = 1'b0;
reg qsfp5_reset_reg = 1'b0;
reg qsfp6_reset_reg = 1'b0;
reg qsfp7_reset_reg = 1'b0;
reg qsfp8_reset_reg = 1'b0;

reg qsfp1_lpmode_reg = 1'b0;
reg qsfp2_lpmode_reg = 1'b0;
reg qsfp3_lpmode_reg = 1'b0;
reg qsfp4_lpmode_reg = 1'b0;
reg qsfp5_lpmode_reg = 1'b0;
reg qsfp6_lpmode_reg = 1'b0;
reg qsfp7_lpmode_reg = 1'b0;
reg qsfp8_lpmode_reg = 1'b0;

assign qsfp1_modsell = 1'b0;
assign qsfp2_modsell = 1'b0;
assign qsfp3_modsell = 1'b0;
assign qsfp4_modsell = 1'b0;
assign qsfp5_modsell = 1'b0;
assign qsfp6_modsell = 1'b0;
assign qsfp7_modsell = 1'b0;
assign qsfp8_modsell = 1'b0;

assign qsfp1_resetl = !qsfp1_reset_reg;
assign qsfp2_resetl = !qsfp2_reset_reg;
assign qsfp3_resetl = !qsfp3_reset_reg;
assign qsfp4_resetl = !qsfp4_reset_reg;
assign qsfp5_resetl = !qsfp5_reset_reg;
assign qsfp6_resetl = !qsfp6_reset_reg;
assign qsfp7_resetl = !qsfp7_reset_reg;
assign qsfp8_resetl = !qsfp8_reset_reg;

assign qsfp1_lpmode = qsfp1_lpmode_reg;
assign qsfp2_lpmode = qsfp2_lpmode_reg;
assign qsfp3_lpmode = qsfp3_lpmode_reg;
assign qsfp4_lpmode = qsfp4_lpmode_reg;
assign qsfp5_lpmode = qsfp5_lpmode_reg;
assign qsfp6_lpmode = qsfp6_lpmode_reg;
assign qsfp7_lpmode = qsfp7_lpmode_reg;
assign qsfp8_lpmode = qsfp8_lpmode_reg;


/*
 * Setup QSFP clocks
 */
wire qsfp1_txuserclk2;
assign qsfp1_tx_clk_int = qsfp1_txuserclk2;
assign qsfp1_rx_clk_int = qsfp1_txuserclk2;

wire qsfp2_txuserclk2;
assign qsfp2_tx_clk_int = qsfp2_txuserclk2;
assign qsfp2_rx_clk_int = qsfp2_txuserclk2;

wire qsfp3_txuserclk2;
assign qsfp3_tx_clk_int = qsfp3_txuserclk2;
assign qsfp3_rx_clk_int = qsfp3_txuserclk2;

wire qsfp4_txuserclk2;
assign qsfp4_tx_clk_int = qsfp4_txuserclk2;
assign qsfp4_rx_clk_int = qsfp4_txuserclk2;

wire qsfp5_txuserclk2;
assign qsfp5_tx_clk_int = qsfp5_txuserclk2;
assign qsfp5_rx_clk_int = qsfp5_txuserclk2;

wire qsfp6_txuserclk2;
assign qsfp6_tx_clk_int = qsfp6_txuserclk2;
assign qsfp6_rx_clk_int = qsfp6_txuserclk2;

wire qsfp7_txuserclk2;
assign qsfp7_tx_clk_int = qsfp7_txuserclk2;
assign qsfp7_rx_clk_int = qsfp7_txuserclk2;

wire qsfp8_txuserclk2;
assign qsfp8_tx_clk_int = qsfp8_txuserclk2;
assign qsfp8_rx_clk_int = qsfp8_txuserclk2;

wire [15:0] vector_signals;

cmac_pad #(
    .DATA_WIDTH(AXIS_ETH_DATA_WIDTH),
    .KEEP_WIDTH(AXIS_ETH_KEEP_WIDTH),
    .USER_WIDTH(1)
)
qsfp1_cmac_pad_inst (
    .clk(qsfp1_tx_clk_int),
    .rst(qsfp1_tx_rst_int),

    .s_axis_tdata(qsfp1_tx_axis_tdata_int),
    .s_axis_tkeep(qsfp1_tx_axis_tkeep_int),
    .s_axis_tvalid(qsfp1_tx_axis_tvalid_int),
    .s_axis_tready(qsfp1_tx_axis_tready_int),
    .s_axis_tlast(qsfp1_tx_axis_tlast_int),
    .s_axis_tuser(qsfp1_tx_axis_tuser_int),

    .m_axis_tdata(qsfp1_mac_tx_axis_tdata),
    .m_axis_tkeep(qsfp1_mac_tx_axis_tkeep),
    .m_axis_tvalid(qsfp1_mac_tx_axis_tvalid),
    .m_axis_tready(qsfp1_mac_tx_axis_tready),
    .m_axis_tlast(qsfp1_mac_tx_axis_tlast),
    .m_axis_tuser(qsfp1_mac_tx_axis_tuser)
);

cmac_usplus_0
qsfp1_cmac_inst (
    .gt_rxp_in({qsfp1_rx4_p, qsfp1_rx3_p, qsfp1_rx2_p, qsfp1_rx1_p}),  // input
    .gt_rxn_in({qsfp1_rx4_n, qsfp1_rx3_n, qsfp1_rx2_n, qsfp1_rx1_n}),  // input
    .gt_txp_out({qsfp1_tx4_p, qsfp1_tx3_p, qsfp1_tx2_p, qsfp1_tx1_p}), // output
    .gt_txn_out({qsfp1_tx4_n, qsfp1_tx3_n, qsfp1_tx2_n, qsfp1_tx1_n}), // output

    .gt_txusrclk2(qsfp1_txuserclk2),	// output

    .gt_loopback_in(12'd0),		// input [11:0]
    .gt_rxrecclkout(),			// output [3:0]
    .gt_powergoodout(),			// output [3:0]
    .gt_ref_clk_out(),			// output
    .gtwiz_reset_tx_datapath(1'b0),	// input
    .gtwiz_reset_rx_datapath(1'b0),	// input

    .gt_ref_clk_p(qsfp1_mgt_refclk_0_p),// input
    .gt_ref_clk_n(qsfp1_mgt_refclk_0_n),// input

    .init_clk(clk_125mhz),		// input
    .sys_reset(clk_125mhz_rst),		// input

    .rx_axis_tvalid(qsfp1_rx_axis_tvalid_int),	// output
    .rx_axis_tdata(qsfp1_rx_axis_tdata_int),	// output [511:0]
    .rx_axis_tlast(qsfp1_rx_axis_tlast_int),	// output
    .rx_axis_tkeep(qsfp1_rx_axis_tkeep_int),	// output [63:0]
    .rx_axis_tuser(qsfp1_rx_axis_tuser_int),	// output

    .rx_otn_bip8_0(), // output [7:0]
    .rx_otn_bip8_1(), // output [7:0]
    .rx_otn_bip8_2(), // output [7:0]
    .rx_otn_bip8_3(), // output [7:0]
    .rx_otn_bip8_4(), // output [7:0]
    .rx_otn_data_0(), // output [65:0]
    .rx_otn_data_1(), // output [65:0]
    .rx_otn_data_2(), // output [65:0]
    .rx_otn_data_3(), // output [65:0]
    .rx_otn_data_4(), // output [65:0]
    .rx_otn_ena(), // output
    .rx_otn_lane0(), // output
    .rx_otn_vlmarker(), // output
    .rx_preambleout(), // output [55:0]

    .usr_rx_reset(qsfp1_rx_rst_int),	// output
    .gt_rxusrclk2(),			// output

    .stat_rx_aligned(vector_signals[0]), // output
    .stat_rx_aligned_err(), // output
    .stat_rx_bad_code(), // output [2:0]
    .stat_rx_bad_fcs(), // output [2:0]
    .stat_rx_bad_preamble(), // output
    .stat_rx_bad_sfd(), // output
    .stat_rx_bip_err_0(), // output
    .stat_rx_bip_err_1(), // output
    .stat_rx_bip_err_10(), // output
    .stat_rx_bip_err_11(), // output
    .stat_rx_bip_err_12(), // output
    .stat_rx_bip_err_13(), // output
    .stat_rx_bip_err_14(), // output
    .stat_rx_bip_err_15(), // output
    .stat_rx_bip_err_16(), // output
    .stat_rx_bip_err_17(), // output
    .stat_rx_bip_err_18(), // output
    .stat_rx_bip_err_19(), // output
    .stat_rx_bip_err_2(), // output
    .stat_rx_bip_err_3(), // output
    .stat_rx_bip_err_4(), // output
    .stat_rx_bip_err_5(), // output
    .stat_rx_bip_err_6(), // output
    .stat_rx_bip_err_7(), // output
    .stat_rx_bip_err_8(), // output
    .stat_rx_bip_err_9(), // output
    .stat_rx_block_lock(), // output [19:0]
    .stat_rx_broadcast(), // output
    .stat_rx_fragment(), // output [2:0]
    .stat_rx_framing_err_0(), // output [1:0]
    .stat_rx_framing_err_1(), // output [1:0]
    .stat_rx_framing_err_10(), // output [1:0]
    .stat_rx_framing_err_11(), // output [1:0]
    .stat_rx_framing_err_12(), // output [1:0]
    .stat_rx_framing_err_13(), // output [1:0]
    .stat_rx_framing_err_14(), // output [1:0]
    .stat_rx_framing_err_15(), // output [1:0]
    .stat_rx_framing_err_16(), // output [1:0]
    .stat_rx_framing_err_17(), // output [1:0]
    .stat_rx_framing_err_18(), // output [1:0]
    .stat_rx_framing_err_19(), // output [1:0]
    .stat_rx_framing_err_2(), // output [1:0]
    .stat_rx_framing_err_3(), // output [1:0]
    .stat_rx_framing_err_4(), // output [1:0]
    .stat_rx_framing_err_5(), // output [1:0]
    .stat_rx_framing_err_6(), // output [1:0]
    .stat_rx_framing_err_7(), // output [1:0]
    .stat_rx_framing_err_8(), // output [1:0]
    .stat_rx_framing_err_9(), // output [1:0]
    .stat_rx_framing_err_valid_0(), // output
    .stat_rx_framing_err_valid_1(), // output
    .stat_rx_framing_err_valid_10(), // output
    .stat_rx_framing_err_valid_11(), // output
    .stat_rx_framing_err_valid_12(), // output
    .stat_rx_framing_err_valid_13(), // output
    .stat_rx_framing_err_valid_14(), // output
    .stat_rx_framing_err_valid_15(), // output
    .stat_rx_framing_err_valid_16(), // output
    .stat_rx_framing_err_valid_17(), // output
    .stat_rx_framing_err_valid_18(), // output
    .stat_rx_framing_err_valid_19(), // output
    .stat_rx_framing_err_valid_2(), // output
    .stat_rx_framing_err_valid_3(), // output
    .stat_rx_framing_err_valid_4(), // output
    .stat_rx_framing_err_valid_5(), // output
    .stat_rx_framing_err_valid_6(), // output
    .stat_rx_framing_err_valid_7(), // output
    .stat_rx_framing_err_valid_8(), // output
    .stat_rx_framing_err_valid_9(), // output
    .stat_rx_got_signal_os(), // output
    .stat_rx_hi_ber(), // output
    .stat_rx_inrangeerr(), // output
    .stat_rx_internal_local_fault(), // output
    .stat_rx_jabber(), // output
    .stat_rx_local_fault(), // output
    .stat_rx_mf_err(), // output [19:0]
    .stat_rx_mf_len_err(), // output [19:0]
    .stat_rx_mf_repeat_err(), // output [19:0]
    .stat_rx_misaligned(), // output
    .stat_rx_multicast(), // output
    .stat_rx_oversize(), // output
    .stat_rx_packet_1024_1518_bytes(), // output
    .stat_rx_packet_128_255_bytes(), // output
    .stat_rx_packet_1519_1522_bytes(), // output
    .stat_rx_packet_1523_1548_bytes(), // output
    .stat_rx_packet_1549_2047_bytes(), // output
    .stat_rx_packet_2048_4095_bytes(), // output
    .stat_rx_packet_256_511_bytes(), // output
    .stat_rx_packet_4096_8191_bytes(), // output
    .stat_rx_packet_512_1023_bytes(), // output
    .stat_rx_packet_64_bytes(), // output
    .stat_rx_packet_65_127_bytes(), // output
    .stat_rx_packet_8192_9215_bytes(), // output
    .stat_rx_packet_bad_fcs(), // output
    .stat_rx_packet_large(), // output
    .stat_rx_packet_small(), // output [2:0]

    /*
     * TODO
     * The RS-FEC is enabled by default
     * Can we disable this?
     */
    .ctl_rx_enable(1'b1), // input
    .ctl_rx_force_resync(1'b0), // input
    .ctl_rx_test_pattern(1'b0), // input
    .ctl_rsfec_ieee_error_indication_mode(1'b0), // input
    .ctl_rx_rsfec_enable(1'b1), // input
    .ctl_rx_rsfec_enable_correction(1'b1), // input
    .ctl_rx_rsfec_enable_indication(1'b1), // input
    .core_rx_reset(1'b0), // input
    .rx_clk(qsfp1_rx_clk_int), // input

    .stat_rx_received_local_fault(), // output
    .stat_rx_remote_fault(), // output
    .stat_rx_status(vector_signals[1]), // output
    .stat_rx_stomped_fcs(), // output [2:0]
    .stat_rx_synced(), // output [19:0]
    .stat_rx_synced_err(), // output [19:0]
    .stat_rx_test_pattern_mismatch(), // output [2:0]
    .stat_rx_toolong(), // output
    .stat_rx_total_bytes(), // output [6:0]
    .stat_rx_total_good_bytes(), // output [13:0]
    .stat_rx_total_good_packets(), // output
    .stat_rx_total_packets(), // output [2:0]
    .stat_rx_truncated(), // output
    .stat_rx_undersize(), // output [2:0]
    .stat_rx_unicast(), // output
    .stat_rx_vlan(), // output
    .stat_rx_pcsl_demuxed(), // output [19:0]
    .stat_rx_pcsl_number_0(), // output [4:0]
    .stat_rx_pcsl_number_1(), // output [4:0]
    .stat_rx_pcsl_number_10(), // output [4:0]
    .stat_rx_pcsl_number_11(), // output [4:0]
    .stat_rx_pcsl_number_12(), // output [4:0]
    .stat_rx_pcsl_number_13(), // output [4:0]
    .stat_rx_pcsl_number_14(), // output [4:0]
    .stat_rx_pcsl_number_15(), // output [4:0]
    .stat_rx_pcsl_number_16(), // output [4:0]
    .stat_rx_pcsl_number_17(), // output [4:0]
    .stat_rx_pcsl_number_18(), // output [4:0]
    .stat_rx_pcsl_number_19(), // output [4:0]
    .stat_rx_pcsl_number_2(), // output [4:0]
    .stat_rx_pcsl_number_3(), // output [4:0]
    .stat_rx_pcsl_number_4(), // output [4:0]
    .stat_rx_pcsl_number_5(), // output [4:0]
    .stat_rx_pcsl_number_6(), // output [4:0]
    .stat_rx_pcsl_number_7(), // output [4:0]
    .stat_rx_pcsl_number_8(), // output [4:0]
    .stat_rx_pcsl_number_9(), // output [4:0]
    .stat_rx_rsfec_am_lock0(), // output
    .stat_rx_rsfec_am_lock1(), // output
    .stat_rx_rsfec_am_lock2(), // output
    .stat_rx_rsfec_am_lock3(), // output
    .stat_rx_rsfec_corrected_cw_inc(), // output
    .stat_rx_rsfec_cw_inc(), // output
    .stat_rx_rsfec_err_count0_inc(), // output [2:0]
    .stat_rx_rsfec_err_count1_inc(), // output [2:0]
    .stat_rx_rsfec_err_count2_inc(), // output [2:0]
    .stat_rx_rsfec_err_count3_inc(), // output [2:0]
    .stat_rx_rsfec_hi_ser(), // output
    .stat_rx_rsfec_lane_alignment_status(), // output
    .stat_rx_rsfec_lane_fill_0(), // output [13:0]
    .stat_rx_rsfec_lane_fill_1(), // output [13:0]
    .stat_rx_rsfec_lane_fill_2(), // output [13:0]
    .stat_rx_rsfec_lane_fill_3(), // output [13:0]
    .stat_rx_rsfec_lane_mapping(), // output [7:0]
    .stat_rx_rsfec_uncorrected_cw_inc(), // output

    .stat_tx_bad_fcs(), // output
    .stat_tx_broadcast(), // output
    .stat_tx_frame_error(), // output
    .stat_tx_local_fault(), // output
    .stat_tx_multicast(), // output
    .stat_tx_packet_1024_1518_bytes(), // output
    .stat_tx_packet_128_255_bytes(), // output
    .stat_tx_packet_1519_1522_bytes(), // output
    .stat_tx_packet_1523_1548_bytes(), // output
    .stat_tx_packet_1549_2047_bytes(), // output
    .stat_tx_packet_2048_4095_bytes(), // output
    .stat_tx_packet_256_511_bytes(), // output
    .stat_tx_packet_4096_8191_bytes(), // output
    .stat_tx_packet_512_1023_bytes(), // output
    .stat_tx_packet_64_bytes(), // output
    .stat_tx_packet_65_127_bytes(), // output
    .stat_tx_packet_8192_9215_bytes(), // output
    .stat_tx_packet_large(), // output
    .stat_tx_packet_small(), // output
    .stat_tx_total_bytes(), // output [5:0]
    .stat_tx_total_good_bytes(), // output [13:0]
    .stat_tx_total_good_packets(), // output
    .stat_tx_total_packets(), // output
    .stat_tx_unicast(), // output
    .stat_tx_vlan(), // output

    .ctl_tx_enable(1'b1), // input
    .ctl_tx_test_pattern(1'b0), // input
    .ctl_tx_rsfec_enable(1'b1), // input
    .ctl_tx_send_idle(1'b0), // input
    .ctl_tx_send_rfi(1'b0), // input
    .ctl_tx_send_lfi(1'b0), // input
    .core_tx_reset(1'b0), // input

    .tx_axis_tready(qsfp1_mac_tx_axis_tready), // output
    .tx_axis_tvalid(qsfp1_mac_tx_axis_tvalid), // input
    .tx_axis_tdata(qsfp1_mac_tx_axis_tdata), // input [511:0]
    .tx_axis_tlast(qsfp1_mac_tx_axis_tlast), // input
    .tx_axis_tkeep(qsfp1_mac_tx_axis_tkeep), // input [63:0]
    .tx_axis_tuser(qsfp1_mac_tx_axis_tuser), // input

    .tx_ovfout(), // output
    .tx_unfout(), // output
    .tx_preamblein(56'd0), // input [55:0]

    .usr_tx_reset(qsfp1_tx_rst_int), // output

    .core_drp_reset(1'b0), // input
    .drp_clk(1'b0), // input
    .drp_addr(10'd0), // input [9:0]
    .drp_di(16'd0), // input [15:0]
    .drp_en(1'b0), // input
    .drp_do(), // output [15:0]
    .drp_rdy(), // output
    .drp_we(1'b0) // input
);

cmac_pad #(
    .DATA_WIDTH(AXIS_ETH_DATA_WIDTH),
    .KEEP_WIDTH(AXIS_ETH_KEEP_WIDTH),
    .USER_WIDTH(1)
)
qsfp2_cmac_pad_inst (
    .clk(qsfp2_tx_clk_int),
    .rst(qsfp2_tx_rst_int),

    .s_axis_tdata(qsfp2_tx_axis_tdata_int),
    .s_axis_tkeep(qsfp2_tx_axis_tkeep_int),
    .s_axis_tvalid(qsfp2_tx_axis_tvalid_int),
    .s_axis_tready(qsfp2_tx_axis_tready_int),
    .s_axis_tlast(qsfp2_tx_axis_tlast_int),
    .s_axis_tuser(qsfp2_tx_axis_tuser_int),

    .m_axis_tdata(qsfp2_mac_tx_axis_tdata),
    .m_axis_tkeep(qsfp2_mac_tx_axis_tkeep),
    .m_axis_tvalid(qsfp2_mac_tx_axis_tvalid),
    .m_axis_tready(qsfp2_mac_tx_axis_tready),
    .m_axis_tlast(qsfp2_mac_tx_axis_tlast),
    .m_axis_tuser(qsfp2_mac_tx_axis_tuser)
);

cmac_usplus_1
qsfp2_cmac_inst (
    .gt_rxp_in({qsfp2_rx4_p, qsfp2_rx3_p, qsfp2_rx2_p, qsfp2_rx1_p}), // input
    .gt_rxn_in({qsfp2_rx4_n, qsfp2_rx3_n, qsfp2_rx2_n, qsfp2_rx1_n}), // input
    .gt_txp_out({qsfp2_tx4_p, qsfp2_tx3_p, qsfp2_tx2_p, qsfp2_tx1_p}), // output
    .gt_txn_out({qsfp2_tx4_n, qsfp2_tx3_n, qsfp2_tx2_n, qsfp2_tx1_n}), // output
    .gt_txusrclk2(qsfp2_txuserclk2), // output
    .gt_loopback_in(12'd0), // input [11:0]
    .gt_rxrecclkout(), // output [3:0]
    .gt_powergoodout(), // output [3:0]
    .gt_ref_clk_out(), // output
    .gtwiz_reset_tx_datapath(1'b0), // input
    .gtwiz_reset_rx_datapath(1'b0), // input

    .gt_ref_clk_p(qsfp2_mgt_refclk_0_p), // input
    .gt_ref_clk_n(qsfp2_mgt_refclk_0_n), // input

    .init_clk(clk_125mhz), // input
    .sys_reset(clk_125mhz_rst), // input

    .rx_axis_tvalid(qsfp2_rx_axis_tvalid_int), // output
    .rx_axis_tdata(qsfp2_rx_axis_tdata_int), // output [511:0]
    .rx_axis_tlast(qsfp2_rx_axis_tlast_int), // output
    .rx_axis_tkeep(qsfp2_rx_axis_tkeep_int), // output [63:0]
    .rx_axis_tuser(qsfp2_rx_axis_tuser_int), // output

    .rx_otn_bip8_0(), // output [7:0]
    .rx_otn_bip8_1(), // output [7:0]
    .rx_otn_bip8_2(), // output [7:0]
    .rx_otn_bip8_3(), // output [7:0]
    .rx_otn_bip8_4(), // output [7:0]
    .rx_otn_data_0(), // output [65:0]
    .rx_otn_data_1(), // output [65:0]
    .rx_otn_data_2(), // output [65:0]
    .rx_otn_data_3(), // output [65:0]
    .rx_otn_data_4(), // output [65:0]
    .rx_otn_ena(), // output
    .rx_otn_lane0(), // output
    .rx_otn_vlmarker(), // output
    .rx_preambleout(), // output [55:0]
    .usr_rx_reset(qsfp2_rx_rst_int), // output
    .gt_rxusrclk2(), // output

    .stat_rx_aligned(vector_signals[2]), // output
    .stat_rx_aligned_err(), // output
    .stat_rx_bad_code(), // output [2:0]
    .stat_rx_bad_fcs(), // output [2:0]
    .stat_rx_bad_preamble(), // output
    .stat_rx_bad_sfd(), // output
    .stat_rx_bip_err_0(), // output
    .stat_rx_bip_err_1(), // output
    .stat_rx_bip_err_10(), // output
    .stat_rx_bip_err_11(), // output
    .stat_rx_bip_err_12(), // output
    .stat_rx_bip_err_13(), // output
    .stat_rx_bip_err_14(), // output
    .stat_rx_bip_err_15(), // output
    .stat_rx_bip_err_16(), // output
    .stat_rx_bip_err_17(), // output
    .stat_rx_bip_err_18(), // output
    .stat_rx_bip_err_19(), // output
    .stat_rx_bip_err_2(), // output
    .stat_rx_bip_err_3(), // output
    .stat_rx_bip_err_4(), // output
    .stat_rx_bip_err_5(), // output
    .stat_rx_bip_err_6(), // output
    .stat_rx_bip_err_7(), // output
    .stat_rx_bip_err_8(), // output
    .stat_rx_bip_err_9(), // output
    .stat_rx_block_lock(), // output [19:0]
    .stat_rx_broadcast(), // output
    .stat_rx_fragment(), // output [2:0]
    .stat_rx_framing_err_0(), // output [1:0]
    .stat_rx_framing_err_1(), // output [1:0]
    .stat_rx_framing_err_10(), // output [1:0]
    .stat_rx_framing_err_11(), // output [1:0]
    .stat_rx_framing_err_12(), // output [1:0]
    .stat_rx_framing_err_13(), // output [1:0]
    .stat_rx_framing_err_14(), // output [1:0]
    .stat_rx_framing_err_15(), // output [1:0]
    .stat_rx_framing_err_16(), // output [1:0]
    .stat_rx_framing_err_17(), // output [1:0]
    .stat_rx_framing_err_18(), // output [1:0]
    .stat_rx_framing_err_19(), // output [1:0]
    .stat_rx_framing_err_2(), // output [1:0]
    .stat_rx_framing_err_3(), // output [1:0]
    .stat_rx_framing_err_4(), // output [1:0]
    .stat_rx_framing_err_5(), // output [1:0]
    .stat_rx_framing_err_6(), // output [1:0]
    .stat_rx_framing_err_7(), // output [1:0]
    .stat_rx_framing_err_8(), // output [1:0]
    .stat_rx_framing_err_9(), // output [1:0]
    .stat_rx_framing_err_valid_0(), // output
    .stat_rx_framing_err_valid_1(), // output
    .stat_rx_framing_err_valid_10(), // output
    .stat_rx_framing_err_valid_11(), // output
    .stat_rx_framing_err_valid_12(), // output
    .stat_rx_framing_err_valid_13(), // output
    .stat_rx_framing_err_valid_14(), // output
    .stat_rx_framing_err_valid_15(), // output
    .stat_rx_framing_err_valid_16(), // output
    .stat_rx_framing_err_valid_17(), // output
    .stat_rx_framing_err_valid_18(), // output
    .stat_rx_framing_err_valid_19(), // output
    .stat_rx_framing_err_valid_2(), // output
    .stat_rx_framing_err_valid_3(), // output
    .stat_rx_framing_err_valid_4(), // output
    .stat_rx_framing_err_valid_5(), // output
    .stat_rx_framing_err_valid_6(), // output
    .stat_rx_framing_err_valid_7(), // output
    .stat_rx_framing_err_valid_8(), // output
    .stat_rx_framing_err_valid_9(), // output
    .stat_rx_got_signal_os(), // output
    .stat_rx_hi_ber(), // output
    .stat_rx_inrangeerr(), // output
    .stat_rx_internal_local_fault(), // output
    .stat_rx_jabber(), // output
    .stat_rx_local_fault(), // output
    .stat_rx_mf_err(), // output [19:0]
    .stat_rx_mf_len_err(), // output [19:0]
    .stat_rx_mf_repeat_err(), // output [19:0]
    .stat_rx_misaligned(), // output
    .stat_rx_multicast(), // output
    .stat_rx_oversize(), // output
    .stat_rx_packet_1024_1518_bytes(), // output
    .stat_rx_packet_128_255_bytes(), // output
    .stat_rx_packet_1519_1522_bytes(), // output
    .stat_rx_packet_1523_1548_bytes(), // output
    .stat_rx_packet_1549_2047_bytes(), // output
    .stat_rx_packet_2048_4095_bytes(), // output
    .stat_rx_packet_256_511_bytes(), // output
    .stat_rx_packet_4096_8191_bytes(), // output
    .stat_rx_packet_512_1023_bytes(), // output
    .stat_rx_packet_64_bytes(), // output
    .stat_rx_packet_65_127_bytes(), // output
    .stat_rx_packet_8192_9215_bytes(), // output
    .stat_rx_packet_bad_fcs(), // output
    .stat_rx_packet_large(), // output
    .stat_rx_packet_small(), // output [2:0]

    .ctl_rx_enable(1'b1), // input
    .ctl_rx_force_resync(1'b0), // input
    .ctl_rx_test_pattern(1'b0), // input
    .ctl_rsfec_ieee_error_indication_mode(1'b0), // input
    .ctl_rx_rsfec_enable(1'b1), // input
    .ctl_rx_rsfec_enable_correction(1'b1), // input
    .ctl_rx_rsfec_enable_indication(1'b1), // input
    .core_rx_reset(1'b0), // input
    .rx_clk(qsfp2_rx_clk_int), // input

    .stat_rx_received_local_fault(), // output
    .stat_rx_remote_fault(), // output
    .stat_rx_status(vector_signals[3]), // output
    .stat_rx_stomped_fcs(), // output [2:0]
    .stat_rx_synced(), // output [19:0]
    .stat_rx_synced_err(), // output [19:0]
    .stat_rx_test_pattern_mismatch(), // output [2:0]
    .stat_rx_toolong(), // output
    .stat_rx_total_bytes(), // output [6:0]
    .stat_rx_total_good_bytes(), // output [13:0]
    .stat_rx_total_good_packets(), // output
    .stat_rx_total_packets(), // output [2:0]
    .stat_rx_truncated(), // output
    .stat_rx_undersize(), // output [2:0]
    .stat_rx_unicast(), // output
    .stat_rx_vlan(), // output
    .stat_rx_pcsl_demuxed(), // output [19:0]
    .stat_rx_pcsl_number_0(), // output [4:0]
    .stat_rx_pcsl_number_1(), // output [4:0]
    .stat_rx_pcsl_number_10(), // output [4:0]
    .stat_rx_pcsl_number_11(), // output [4:0]
    .stat_rx_pcsl_number_12(), // output [4:0]
    .stat_rx_pcsl_number_13(), // output [4:0]
    .stat_rx_pcsl_number_14(), // output [4:0]
    .stat_rx_pcsl_number_15(), // output [4:0]
    .stat_rx_pcsl_number_16(), // output [4:0]
    .stat_rx_pcsl_number_17(), // output [4:0]
    .stat_rx_pcsl_number_18(), // output [4:0]
    .stat_rx_pcsl_number_19(), // output [4:0]
    .stat_rx_pcsl_number_2(), // output [4:0]
    .stat_rx_pcsl_number_3(), // output [4:0]
    .stat_rx_pcsl_number_4(), // output [4:0]
    .stat_rx_pcsl_number_5(), // output [4:0]
    .stat_rx_pcsl_number_6(), // output [4:0]
    .stat_rx_pcsl_number_7(), // output [4:0]
    .stat_rx_pcsl_number_8(), // output [4:0]
    .stat_rx_pcsl_number_9(), // output [4:0]
    .stat_rx_rsfec_am_lock0(), // output
    .stat_rx_rsfec_am_lock1(), // output
    .stat_rx_rsfec_am_lock2(), // output
    .stat_rx_rsfec_am_lock3(), // output
    .stat_rx_rsfec_corrected_cw_inc(), // output
    .stat_rx_rsfec_cw_inc(), // output
    .stat_rx_rsfec_err_count0_inc(), // output [2:0]
    .stat_rx_rsfec_err_count1_inc(), // output [2:0]
    .stat_rx_rsfec_err_count2_inc(), // output [2:0]
    .stat_rx_rsfec_err_count3_inc(), // output [2:0]
    .stat_rx_rsfec_hi_ser(), // output
    .stat_rx_rsfec_lane_alignment_status(), // output
    .stat_rx_rsfec_lane_fill_0(), // output [13:0]
    .stat_rx_rsfec_lane_fill_1(), // output [13:0]
    .stat_rx_rsfec_lane_fill_2(), // output [13:0]
    .stat_rx_rsfec_lane_fill_3(), // output [13:0]
    .stat_rx_rsfec_lane_mapping(), // output [7:0]
    .stat_rx_rsfec_uncorrected_cw_inc(), // output

    .stat_tx_bad_fcs(), // output
    .stat_tx_broadcast(), // output
    .stat_tx_frame_error(), // output
    .stat_tx_local_fault(), // output
    .stat_tx_multicast(), // output
    .stat_tx_packet_1024_1518_bytes(), // output
    .stat_tx_packet_128_255_bytes(), // output
    .stat_tx_packet_1519_1522_bytes(), // output
    .stat_tx_packet_1523_1548_bytes(), // output
    .stat_tx_packet_1549_2047_bytes(), // output
    .stat_tx_packet_2048_4095_bytes(), // output
    .stat_tx_packet_256_511_bytes(), // output
    .stat_tx_packet_4096_8191_bytes(), // output
    .stat_tx_packet_512_1023_bytes(), // output
    .stat_tx_packet_64_bytes(), // output
    .stat_tx_packet_65_127_bytes(), // output
    .stat_tx_packet_8192_9215_bytes(), // output
    .stat_tx_packet_large(), // output
    .stat_tx_packet_small(), // output
    .stat_tx_total_bytes(), // output [5:0]
    .stat_tx_total_good_bytes(), // output [13:0]
    .stat_tx_total_good_packets(), // output
    .stat_tx_total_packets(), // output
    .stat_tx_unicast(), // output
    .stat_tx_vlan(), // output

    .ctl_tx_enable(1'b1), // input
    .ctl_tx_test_pattern(1'b0), // input
    .ctl_tx_rsfec_enable(1'b1), // input
    .ctl_tx_send_idle(1'b0), // input
    .ctl_tx_send_rfi(1'b0), // input
    .ctl_tx_send_lfi(1'b0), // input
    .core_tx_reset(1'b0), // input

    .tx_axis_tready(qsfp2_mac_tx_axis_tready), // output
    .tx_axis_tvalid(qsfp2_mac_tx_axis_tvalid), // input
    .tx_axis_tdata(qsfp2_mac_tx_axis_tdata), // input [511:0]
    .tx_axis_tlast(qsfp2_mac_tx_axis_tlast), // input
    .tx_axis_tkeep(qsfp2_mac_tx_axis_tkeep), // input [63:0]
    .tx_axis_tuser(qsfp2_mac_tx_axis_tuser), // input

    .tx_ovfout(), // output
    .tx_unfout(), // output
    .tx_preamblein(56'd0), // input [55:0]
    .usr_tx_reset(qsfp2_tx_rst_int), // output

    .core_drp_reset(1'b0), // input
    .drp_clk(1'b0), // input
    .drp_addr(10'd0), // input [9:0]
    .drp_di(16'd0), // input [15:0]
    .drp_en(1'b0), // input
    .drp_do(), // output [15:0]
    .drp_rdy(), // output
    .drp_we(1'b0) // input
);

cmac_pad #(
    .DATA_WIDTH(AXIS_ETH_DATA_WIDTH),
    .KEEP_WIDTH(AXIS_ETH_KEEP_WIDTH),
    .USER_WIDTH(1)
)
qsfp3_cmac_pad_inst (
    .clk(qsfp3_tx_clk_int),
    .rst(qsfp3_tx_rst_int),

    .s_axis_tdata(qsfp3_tx_axis_tdata_int),
    .s_axis_tkeep(qsfp3_tx_axis_tkeep_int),
    .s_axis_tvalid(qsfp3_tx_axis_tvalid_int),
    .s_axis_tready(qsfp3_tx_axis_tready_int),
    .s_axis_tlast(qsfp3_tx_axis_tlast_int),
    .s_axis_tuser(qsfp3_tx_axis_tuser_int),

    .m_axis_tdata(qsfp3_mac_tx_axis_tdata),
    .m_axis_tkeep(qsfp3_mac_tx_axis_tkeep),
    .m_axis_tvalid(qsfp3_mac_tx_axis_tvalid),
    .m_axis_tready(qsfp3_mac_tx_axis_tready),
    .m_axis_tlast(qsfp3_mac_tx_axis_tlast),
    .m_axis_tuser(qsfp3_mac_tx_axis_tuser)
);

cmac_usplus_2
qsfp3_cmac_inst (
    .gt_rxp_in({qsfp3_rx4_p, qsfp3_rx3_p, qsfp3_rx2_p, qsfp3_rx1_p}), // input
    .gt_rxn_in({qsfp3_rx4_n, qsfp3_rx3_n, qsfp3_rx2_n, qsfp3_rx1_n}), // input
    .gt_txp_out({qsfp3_tx4_p, qsfp3_tx3_p, qsfp3_tx2_p, qsfp3_tx1_p}), // output
    .gt_txn_out({qsfp3_tx4_n, qsfp3_tx3_n, qsfp3_tx2_n, qsfp3_tx1_n}), // output
    .gt_txusrclk2(qsfp3_txuserclk2), // output
    .gt_loopback_in(12'd0), // input [11:0]
    .gt_rxrecclkout(), // output [3:0]
    .gt_powergoodout(), // output [3:0]
    .gt_ref_clk_out(), // output
    .gtwiz_reset_tx_datapath(1'b0), // input
    .gtwiz_reset_rx_datapath(1'b0), // input

    .gt_ref_clk_p(qsfp3_mgt_refclk_0_p), // input
    .gt_ref_clk_n(qsfp3_mgt_refclk_0_n), // input

    .init_clk(clk_125mhz), // input
    .sys_reset(clk_125mhz_rst_qsfp), // input

    .rx_axis_tvalid(qsfp3_rx_axis_tvalid_int), // output
    .rx_axis_tdata(qsfp3_rx_axis_tdata_int), // output [511:0]
    .rx_axis_tlast(qsfp3_rx_axis_tlast_int), // output
    .rx_axis_tkeep(qsfp3_rx_axis_tkeep_int), // output [63:0]
    .rx_axis_tuser(qsfp3_rx_axis_tuser_int), // output

    .rx_otn_bip8_0(), // output [7:0]
    .rx_otn_bip8_1(), // output [7:0]
    .rx_otn_bip8_2(), // output [7:0]
    .rx_otn_bip8_3(), // output [7:0]
    .rx_otn_bip8_4(), // output [7:0]
    .rx_otn_data_0(), // output [65:0]
    .rx_otn_data_1(), // output [65:0]
    .rx_otn_data_2(), // output [65:0]
    .rx_otn_data_3(), // output [65:0]
    .rx_otn_data_4(), // output [65:0]
    .rx_otn_ena(), // output
    .rx_otn_lane0(), // output
    .rx_otn_vlmarker(), // output
    .rx_preambleout(), // output [55:0]
    .usr_rx_reset(qsfp3_rx_rst_int), // output
    .gt_rxusrclk2(), // output

    .stat_rx_aligned(vector_signals[4]), // output
    .stat_rx_aligned_err(), // output
    .stat_rx_bad_code(), // output [2:0]
    .stat_rx_bad_fcs(), // output [2:0]
    .stat_rx_bad_preamble(), // output
    .stat_rx_bad_sfd(), // output
    .stat_rx_bip_err_0(), // output
    .stat_rx_bip_err_1(), // output
    .stat_rx_bip_err_10(), // output
    .stat_rx_bip_err_11(), // output
    .stat_rx_bip_err_12(), // output
    .stat_rx_bip_err_13(), // output
    .stat_rx_bip_err_14(), // output
    .stat_rx_bip_err_15(), // output
    .stat_rx_bip_err_16(), // output
    .stat_rx_bip_err_17(), // output
    .stat_rx_bip_err_18(), // output
    .stat_rx_bip_err_19(), // output
    .stat_rx_bip_err_2(), // output
    .stat_rx_bip_err_3(), // output
    .stat_rx_bip_err_4(), // output
    .stat_rx_bip_err_5(), // output
    .stat_rx_bip_err_6(), // output
    .stat_rx_bip_err_7(), // output
    .stat_rx_bip_err_8(), // output
    .stat_rx_bip_err_9(), // output
    .stat_rx_block_lock(), // output [19:0]
    .stat_rx_broadcast(), // output
    .stat_rx_fragment(), // output [2:0]
    .stat_rx_framing_err_0(), // output [1:0]
    .stat_rx_framing_err_1(), // output [1:0]
    .stat_rx_framing_err_10(), // output [1:0]
    .stat_rx_framing_err_11(), // output [1:0]
    .stat_rx_framing_err_12(), // output [1:0]
    .stat_rx_framing_err_13(), // output [1:0]
    .stat_rx_framing_err_14(), // output [1:0]
    .stat_rx_framing_err_15(), // output [1:0]
    .stat_rx_framing_err_16(), // output [1:0]
    .stat_rx_framing_err_17(), // output [1:0]
    .stat_rx_framing_err_18(), // output [1:0]
    .stat_rx_framing_err_19(), // output [1:0]
    .stat_rx_framing_err_2(), // output [1:0]
    .stat_rx_framing_err_3(), // output [1:0]
    .stat_rx_framing_err_4(), // output [1:0]
    .stat_rx_framing_err_5(), // output [1:0]
    .stat_rx_framing_err_6(), // output [1:0]
    .stat_rx_framing_err_7(), // output [1:0]
    .stat_rx_framing_err_8(), // output [1:0]
    .stat_rx_framing_err_9(), // output [1:0]
    .stat_rx_framing_err_valid_0(), // output
    .stat_rx_framing_err_valid_1(), // output
    .stat_rx_framing_err_valid_10(), // output
    .stat_rx_framing_err_valid_11(), // output
    .stat_rx_framing_err_valid_12(), // output
    .stat_rx_framing_err_valid_13(), // output
    .stat_rx_framing_err_valid_14(), // output
    .stat_rx_framing_err_valid_15(), // output
    .stat_rx_framing_err_valid_16(), // output
    .stat_rx_framing_err_valid_17(), // output
    .stat_rx_framing_err_valid_18(), // output
    .stat_rx_framing_err_valid_19(), // output
    .stat_rx_framing_err_valid_2(), // output
    .stat_rx_framing_err_valid_3(), // output
    .stat_rx_framing_err_valid_4(), // output
    .stat_rx_framing_err_valid_5(), // output
    .stat_rx_framing_err_valid_6(), // output
    .stat_rx_framing_err_valid_7(), // output
    .stat_rx_framing_err_valid_8(), // output
    .stat_rx_framing_err_valid_9(), // output
    .stat_rx_got_signal_os(), // output
    .stat_rx_hi_ber(), // output
    .stat_rx_inrangeerr(), // output
    .stat_rx_internal_local_fault(), // output
    .stat_rx_jabber(), // output
    .stat_rx_local_fault(), // output
    .stat_rx_mf_err(), // output [19:0]
    .stat_rx_mf_len_err(), // output [19:0]
    .stat_rx_mf_repeat_err(), // output [19:0]
    .stat_rx_misaligned(), // output
    .stat_rx_multicast(), // output
    .stat_rx_oversize(), // output
    .stat_rx_packet_1024_1518_bytes(), // output
    .stat_rx_packet_128_255_bytes(), // output
    .stat_rx_packet_1519_1522_bytes(), // output
    .stat_rx_packet_1523_1548_bytes(), // output
    .stat_rx_packet_1549_2047_bytes(), // output
    .stat_rx_packet_2048_4095_bytes(), // output
    .stat_rx_packet_256_511_bytes(), // output
    .stat_rx_packet_4096_8191_bytes(), // output
    .stat_rx_packet_512_1023_bytes(), // output
    .stat_rx_packet_64_bytes(), // output
    .stat_rx_packet_65_127_bytes(), // output
    .stat_rx_packet_8192_9215_bytes(), // output
    .stat_rx_packet_bad_fcs(), // output
    .stat_rx_packet_large(), // output
    .stat_rx_packet_small(), // output [2:0]

    .ctl_rx_enable(1'b1), // input
    .ctl_rx_force_resync(1'b0), // input
    .ctl_rx_test_pattern(1'b0), // input
    .ctl_rsfec_ieee_error_indication_mode(1'b0), // input
    .ctl_rx_rsfec_enable(1'b1), // input
    .ctl_rx_rsfec_enable_correction(1'b1), // input
    .ctl_rx_rsfec_enable_indication(1'b1), // input
    .core_rx_reset(1'b0), // input
    .rx_clk(qsfp3_rx_clk_int), // input

    .stat_rx_received_local_fault(), // output
    .stat_rx_remote_fault(), // output
    .stat_rx_status(vector_signals[5]), // output
    .stat_rx_stomped_fcs(), // output [2:0]
    .stat_rx_synced(), // output [19:0]
    .stat_rx_synced_err(), // output [19:0]
    .stat_rx_test_pattern_mismatch(), // output [2:0]
    .stat_rx_toolong(), // output
    .stat_rx_total_bytes(), // output [6:0]
    .stat_rx_total_good_bytes(), // output [13:0]
    .stat_rx_total_good_packets(), // output
    .stat_rx_total_packets(), // output [2:0]
    .stat_rx_truncated(), // output
    .stat_rx_undersize(), // output [2:0]
    .stat_rx_unicast(), // output
    .stat_rx_vlan(), // output
    .stat_rx_pcsl_demuxed(), // output [19:0]
    .stat_rx_pcsl_number_0(), // output [4:0]
    .stat_rx_pcsl_number_1(), // output [4:0]
    .stat_rx_pcsl_number_10(), // output [4:0]
    .stat_rx_pcsl_number_11(), // output [4:0]
    .stat_rx_pcsl_number_12(), // output [4:0]
    .stat_rx_pcsl_number_13(), // output [4:0]
    .stat_rx_pcsl_number_14(), // output [4:0]
    .stat_rx_pcsl_number_15(), // output [4:0]
    .stat_rx_pcsl_number_16(), // output [4:0]
    .stat_rx_pcsl_number_17(), // output [4:0]
    .stat_rx_pcsl_number_18(), // output [4:0]
    .stat_rx_pcsl_number_19(), // output [4:0]
    .stat_rx_pcsl_number_2(), // output [4:0]
    .stat_rx_pcsl_number_3(), // output [4:0]
    .stat_rx_pcsl_number_4(), // output [4:0]
    .stat_rx_pcsl_number_5(), // output [4:0]
    .stat_rx_pcsl_number_6(), // output [4:0]
    .stat_rx_pcsl_number_7(), // output [4:0]
    .stat_rx_pcsl_number_8(), // output [4:0]
    .stat_rx_pcsl_number_9(), // output [4:0]
    .stat_rx_rsfec_am_lock0(), // output
    .stat_rx_rsfec_am_lock1(), // output
    .stat_rx_rsfec_am_lock2(), // output
    .stat_rx_rsfec_am_lock3(), // output
    .stat_rx_rsfec_corrected_cw_inc(), // output
    .stat_rx_rsfec_cw_inc(), // output
    .stat_rx_rsfec_err_count0_inc(), // output [2:0]
    .stat_rx_rsfec_err_count1_inc(), // output [2:0]
    .stat_rx_rsfec_err_count2_inc(), // output [2:0]
    .stat_rx_rsfec_err_count3_inc(), // output [2:0]
    .stat_rx_rsfec_hi_ser(), // output
    .stat_rx_rsfec_lane_alignment_status(), // output
    .stat_rx_rsfec_lane_fill_0(), // output [13:0]
    .stat_rx_rsfec_lane_fill_1(), // output [13:0]
    .stat_rx_rsfec_lane_fill_2(), // output [13:0]
    .stat_rx_rsfec_lane_fill_3(), // output [13:0]
    .stat_rx_rsfec_lane_mapping(), // output [7:0]
    .stat_rx_rsfec_uncorrected_cw_inc(), // output

    .stat_tx_bad_fcs(), // output
    .stat_tx_broadcast(), // output
    .stat_tx_frame_error(), // output
    .stat_tx_local_fault(), // output
    .stat_tx_multicast(), // output
    .stat_tx_packet_1024_1518_bytes(), // output
    .stat_tx_packet_128_255_bytes(), // output
    .stat_tx_packet_1519_1522_bytes(), // output
    .stat_tx_packet_1523_1548_bytes(), // output
    .stat_tx_packet_1549_2047_bytes(), // output
    .stat_tx_packet_2048_4095_bytes(), // output
    .stat_tx_packet_256_511_bytes(), // output
    .stat_tx_packet_4096_8191_bytes(), // output
    .stat_tx_packet_512_1023_bytes(), // output
    .stat_tx_packet_64_bytes(), // output
    .stat_tx_packet_65_127_bytes(), // output
    .stat_tx_packet_8192_9215_bytes(), // output
    .stat_tx_packet_large(), // output
    .stat_tx_packet_small(), // output
    .stat_tx_total_bytes(), // output [5:0]
    .stat_tx_total_good_bytes(), // output [13:0]
    .stat_tx_total_good_packets(), // output
    .stat_tx_total_packets(), // output
    .stat_tx_unicast(), // output
    .stat_tx_vlan(), // output

    .ctl_tx_enable(1'b1), // input
    .ctl_tx_test_pattern(1'b0), // input
    .ctl_tx_rsfec_enable(1'b1), // input
    .ctl_tx_send_idle(1'b0), // input
    .ctl_tx_send_rfi(1'b0), // input
    .ctl_tx_send_lfi(1'b0), // input
    .core_tx_reset(1'b0), // input

    .tx_axis_tready(qsfp3_mac_tx_axis_tready), // output
    .tx_axis_tvalid(qsfp3_mac_tx_axis_tvalid), // input
    .tx_axis_tdata(qsfp3_mac_tx_axis_tdata), // input [511:0]
    .tx_axis_tlast(qsfp3_mac_tx_axis_tlast), // input
    .tx_axis_tkeep(qsfp3_mac_tx_axis_tkeep), // input [63:0]
    .tx_axis_tuser(qsfp3_mac_tx_axis_tuser), // input

    .tx_ovfout(), // output
    .tx_unfout(), // output
    .tx_preamblein(56'd0), // input [55:0]
    .usr_tx_reset(qsfp3_tx_rst_int), // output

    .core_drp_reset(1'b0), // input
    .drp_clk(1'b0), // input
    .drp_addr(10'd0), // input [9:0]
    .drp_di(16'd0), // input [15:0]
    .drp_en(1'b0), // input
    .drp_do(), // output [15:0]
    .drp_rdy(), // output
    .drp_we(1'b0) // input
);

/*
 * qsfp4
 */
cmac_pad #(
    .DATA_WIDTH(AXIS_ETH_DATA_WIDTH),
    .KEEP_WIDTH(AXIS_ETH_KEEP_WIDTH),
    .USER_WIDTH(1)
)
qsfp4_cmac_pad_inst (
    .clk(qsfp4_tx_clk_int),
    .rst(qsfp4_tx_rst_int),

    .s_axis_tdata(qsfp4_tx_axis_tdata_int),
    .s_axis_tkeep(qsfp4_tx_axis_tkeep_int),
    .s_axis_tvalid(qsfp4_tx_axis_tvalid_int),
    .s_axis_tready(qsfp4_tx_axis_tready_int),
    .s_axis_tlast(qsfp4_tx_axis_tlast_int),
    .s_axis_tuser(qsfp4_tx_axis_tuser_int),

    .m_axis_tdata(qsfp4_mac_tx_axis_tdata),
    .m_axis_tkeep(qsfp4_mac_tx_axis_tkeep),
    .m_axis_tvalid(qsfp4_mac_tx_axis_tvalid),
    .m_axis_tready(qsfp4_mac_tx_axis_tready),
    .m_axis_tlast(qsfp4_mac_tx_axis_tlast),
    .m_axis_tuser(qsfp4_mac_tx_axis_tuser)
);

cmac_usplus_3
qsfp4_cmac_inst (
    .gt_rxp_in({qsfp4_rx4_p, qsfp4_rx3_p, qsfp4_rx2_p, qsfp4_rx1_p}), // input
    .gt_rxn_in({qsfp4_rx4_n, qsfp4_rx3_n, qsfp4_rx2_n, qsfp4_rx1_n}), // input
    .gt_txp_out({qsfp4_tx4_p, qsfp4_tx3_p, qsfp4_tx2_p, qsfp4_tx1_p}), // output
    .gt_txn_out({qsfp4_tx4_n, qsfp4_tx3_n, qsfp4_tx2_n, qsfp4_tx1_n}), // output
    .gt_txusrclk2(qsfp4_txuserclk2), // output
    .gt_loopback_in(12'd0), // input [11:0]
    .gt_rxrecclkout(), // output [3:0]
    .gt_powergoodout(), // output [3:0]
    .gt_ref_clk_out(), // output
    .gtwiz_reset_tx_datapath(1'b0), // input
    .gtwiz_reset_rx_datapath(1'b0), // input

    .gt_ref_clk_p(qsfp4_mgt_refclk_0_p), // input
    .gt_ref_clk_n(qsfp4_mgt_refclk_0_n), // input

    .init_clk(clk_125mhz), // input
    .sys_reset(clk_125mhz_rst_qsfp), // input

    .rx_axis_tvalid(qsfp4_rx_axis_tvalid_int), // output
    .rx_axis_tdata(qsfp4_rx_axis_tdata_int), // output [511:0]
    .rx_axis_tlast(qsfp4_rx_axis_tlast_int), // output
    .rx_axis_tkeep(qsfp4_rx_axis_tkeep_int), // output [63:0]
    .rx_axis_tuser(qsfp4_rx_axis_tuser_int), // output

    .rx_otn_bip8_0(), // output [7:0]
    .rx_otn_bip8_1(), // output [7:0]
    .rx_otn_bip8_2(), // output [7:0]
    .rx_otn_bip8_3(), // output [7:0]
    .rx_otn_bip8_4(), // output [7:0]
    .rx_otn_data_0(), // output [65:0]
    .rx_otn_data_1(), // output [65:0]
    .rx_otn_data_2(), // output [65:0]
    .rx_otn_data_3(), // output [65:0]
    .rx_otn_data_4(), // output [65:0]
    .rx_otn_ena(), // output
    .rx_otn_lane0(), // output
    .rx_otn_vlmarker(), // output
    .rx_preambleout(), // output [55:0]
    .usr_rx_reset(qsfp4_rx_rst_int), // output
    .gt_rxusrclk2(), // output

    .stat_rx_aligned(vector_signals[6]), // output
    .stat_rx_aligned_err(), // output
    .stat_rx_bad_code(), // output [2:0]
    .stat_rx_bad_fcs(), // output [2:0]
    .stat_rx_bad_preamble(), // output
    .stat_rx_bad_sfd(), // output
    .stat_rx_bip_err_0(), // output
    .stat_rx_bip_err_1(), // output
    .stat_rx_bip_err_10(), // output
    .stat_rx_bip_err_11(), // output
    .stat_rx_bip_err_12(), // output
    .stat_rx_bip_err_13(), // output
    .stat_rx_bip_err_14(), // output
    .stat_rx_bip_err_15(), // output
    .stat_rx_bip_err_16(), // output
    .stat_rx_bip_err_17(), // output
    .stat_rx_bip_err_18(), // output
    .stat_rx_bip_err_19(), // output
    .stat_rx_bip_err_2(), // output
    .stat_rx_bip_err_3(), // output
    .stat_rx_bip_err_4(), // output
    .stat_rx_bip_err_5(), // output
    .stat_rx_bip_err_6(), // output
    .stat_rx_bip_err_7(), // output
    .stat_rx_bip_err_8(), // output
    .stat_rx_bip_err_9(), // output
    .stat_rx_block_lock(), // output [19:0]
    .stat_rx_broadcast(), // output
    .stat_rx_fragment(), // output [2:0]
    .stat_rx_framing_err_0(), // output [1:0]
    .stat_rx_framing_err_1(), // output [1:0]
    .stat_rx_framing_err_10(), // output [1:0]
    .stat_rx_framing_err_11(), // output [1:0]
    .stat_rx_framing_err_12(), // output [1:0]
    .stat_rx_framing_err_13(), // output [1:0]
    .stat_rx_framing_err_14(), // output [1:0]
    .stat_rx_framing_err_15(), // output [1:0]
    .stat_rx_framing_err_16(), // output [1:0]
    .stat_rx_framing_err_17(), // output [1:0]
    .stat_rx_framing_err_18(), // output [1:0]
    .stat_rx_framing_err_19(), // output [1:0]
    .stat_rx_framing_err_2(), // output [1:0]
    .stat_rx_framing_err_3(), // output [1:0]
    .stat_rx_framing_err_4(), // output [1:0]
    .stat_rx_framing_err_5(), // output [1:0]
    .stat_rx_framing_err_6(), // output [1:0]
    .stat_rx_framing_err_7(), // output [1:0]
    .stat_rx_framing_err_8(), // output [1:0]
    .stat_rx_framing_err_9(), // output [1:0]
    .stat_rx_framing_err_valid_0(), // output
    .stat_rx_framing_err_valid_1(), // output
    .stat_rx_framing_err_valid_10(), // output
    .stat_rx_framing_err_valid_11(), // output
    .stat_rx_framing_err_valid_12(), // output
    .stat_rx_framing_err_valid_13(), // output
    .stat_rx_framing_err_valid_14(), // output
    .stat_rx_framing_err_valid_15(), // output
    .stat_rx_framing_err_valid_16(), // output
    .stat_rx_framing_err_valid_17(), // output
    .stat_rx_framing_err_valid_18(), // output
    .stat_rx_framing_err_valid_19(), // output
    .stat_rx_framing_err_valid_2(), // output
    .stat_rx_framing_err_valid_3(), // output
    .stat_rx_framing_err_valid_4(), // output
    .stat_rx_framing_err_valid_5(), // output
    .stat_rx_framing_err_valid_6(), // output
    .stat_rx_framing_err_valid_7(), // output
    .stat_rx_framing_err_valid_8(), // output
    .stat_rx_framing_err_valid_9(), // output
    .stat_rx_got_signal_os(), // output
    .stat_rx_hi_ber(), // output
    .stat_rx_inrangeerr(), // output
    .stat_rx_internal_local_fault(), // output
    .stat_rx_jabber(), // output
    .stat_rx_local_fault(), // output
    .stat_rx_mf_err(), // output [19:0]
    .stat_rx_mf_len_err(), // output [19:0]
    .stat_rx_mf_repeat_err(), // output [19:0]
    .stat_rx_misaligned(), // output
    .stat_rx_multicast(), // output
    .stat_rx_oversize(), // output
    .stat_rx_packet_1024_1518_bytes(), // output
    .stat_rx_packet_128_255_bytes(), // output
    .stat_rx_packet_1519_1522_bytes(), // output
    .stat_rx_packet_1523_1548_bytes(), // output
    .stat_rx_packet_1549_2047_bytes(), // output
    .stat_rx_packet_2048_4095_bytes(), // output
    .stat_rx_packet_256_511_bytes(), // output
    .stat_rx_packet_4096_8191_bytes(), // output
    .stat_rx_packet_512_1023_bytes(), // output
    .stat_rx_packet_64_bytes(), // output
    .stat_rx_packet_65_127_bytes(), // output
    .stat_rx_packet_8192_9215_bytes(), // output
    .stat_rx_packet_bad_fcs(), // output
    .stat_rx_packet_large(), // output
    .stat_rx_packet_small(), // output [2:0]

    .ctl_rx_enable(1'b1), // input
    .ctl_rx_force_resync(1'b0), // input
    .ctl_rx_test_pattern(1'b0), // input
    .ctl_rsfec_ieee_error_indication_mode(1'b0), // input
    .ctl_rx_rsfec_enable(1'b1), // input
    .ctl_rx_rsfec_enable_correction(1'b1), // input
    .ctl_rx_rsfec_enable_indication(1'b1), // input
    .core_rx_reset(1'b0), // input
    .rx_clk(qsfp4_rx_clk_int), // input

    .stat_rx_received_local_fault(), // output
    .stat_rx_remote_fault(), // output
    .stat_rx_status(vector_signals[7]), // output
    .stat_rx_stomped_fcs(), // output [2:0]
    .stat_rx_synced(), // output [19:0]
    .stat_rx_synced_err(), // output [19:0]
    .stat_rx_test_pattern_mismatch(), // output [2:0]
    .stat_rx_toolong(), // output
    .stat_rx_total_bytes(), // output [6:0]
    .stat_rx_total_good_bytes(), // output [13:0]
    .stat_rx_total_good_packets(), // output
    .stat_rx_total_packets(), // output [2:0]
    .stat_rx_truncated(), // output
    .stat_rx_undersize(), // output [2:0]
    .stat_rx_unicast(), // output
    .stat_rx_vlan(), // output
    .stat_rx_pcsl_demuxed(), // output [19:0]
    .stat_rx_pcsl_number_0(), // output [4:0]
    .stat_rx_pcsl_number_1(), // output [4:0]
    .stat_rx_pcsl_number_10(), // output [4:0]
    .stat_rx_pcsl_number_11(), // output [4:0]
    .stat_rx_pcsl_number_12(), // output [4:0]
    .stat_rx_pcsl_number_13(), // output [4:0]
    .stat_rx_pcsl_number_14(), // output [4:0]
    .stat_rx_pcsl_number_15(), // output [4:0]
    .stat_rx_pcsl_number_16(), // output [4:0]
    .stat_rx_pcsl_number_17(), // output [4:0]
    .stat_rx_pcsl_number_18(), // output [4:0]
    .stat_rx_pcsl_number_19(), // output [4:0]
    .stat_rx_pcsl_number_2(), // output [4:0]
    .stat_rx_pcsl_number_3(), // output [4:0]
    .stat_rx_pcsl_number_4(), // output [4:0]
    .stat_rx_pcsl_number_5(), // output [4:0]
    .stat_rx_pcsl_number_6(), // output [4:0]
    .stat_rx_pcsl_number_7(), // output [4:0]
    .stat_rx_pcsl_number_8(), // output [4:0]
    .stat_rx_pcsl_number_9(), // output [4:0]
    .stat_rx_rsfec_am_lock0(), // output
    .stat_rx_rsfec_am_lock1(), // output
    .stat_rx_rsfec_am_lock2(), // output
    .stat_rx_rsfec_am_lock3(), // output
    .stat_rx_rsfec_corrected_cw_inc(), // output
    .stat_rx_rsfec_cw_inc(), // output
    .stat_rx_rsfec_err_count0_inc(), // output [2:0]
    .stat_rx_rsfec_err_count1_inc(), // output [2:0]
    .stat_rx_rsfec_err_count2_inc(), // output [2:0]
    .stat_rx_rsfec_err_count3_inc(), // output [2:0]
    .stat_rx_rsfec_hi_ser(), // output
    .stat_rx_rsfec_lane_alignment_status(), // output
    .stat_rx_rsfec_lane_fill_0(), // output [13:0]
    .stat_rx_rsfec_lane_fill_1(), // output [13:0]
    .stat_rx_rsfec_lane_fill_2(), // output [13:0]
    .stat_rx_rsfec_lane_fill_3(), // output [13:0]
    .stat_rx_rsfec_lane_mapping(), // output [7:0]
    .stat_rx_rsfec_uncorrected_cw_inc(), // output

    .stat_tx_bad_fcs(), // output
    .stat_tx_broadcast(), // output
    .stat_tx_frame_error(), // output
    .stat_tx_local_fault(), // output
    .stat_tx_multicast(), // output
    .stat_tx_packet_1024_1518_bytes(), // output
    .stat_tx_packet_128_255_bytes(), // output
    .stat_tx_packet_1519_1522_bytes(), // output
    .stat_tx_packet_1523_1548_bytes(), // output
    .stat_tx_packet_1549_2047_bytes(), // output
    .stat_tx_packet_2048_4095_bytes(), // output
    .stat_tx_packet_256_511_bytes(), // output
    .stat_tx_packet_4096_8191_bytes(), // output
    .stat_tx_packet_512_1023_bytes(), // output
    .stat_tx_packet_64_bytes(), // output
    .stat_tx_packet_65_127_bytes(), // output
    .stat_tx_packet_8192_9215_bytes(), // output
    .stat_tx_packet_large(), // output
    .stat_tx_packet_small(), // output
    .stat_tx_total_bytes(), // output [5:0]
    .stat_tx_total_good_bytes(), // output [13:0]
    .stat_tx_total_good_packets(), // output
    .stat_tx_total_packets(), // output
    .stat_tx_unicast(), // output
    .stat_tx_vlan(), // output

    .ctl_tx_enable(1'b1), // input
    .ctl_tx_test_pattern(1'b0), // input
    .ctl_tx_rsfec_enable(1'b1), // input
    .ctl_tx_send_idle(1'b0), // input
    .ctl_tx_send_rfi(1'b0), // input
    .ctl_tx_send_lfi(1'b0), // input
    .core_tx_reset(1'b0), // input

    .tx_axis_tready(qsfp4_mac_tx_axis_tready), // output
    .tx_axis_tvalid(qsfp4_mac_tx_axis_tvalid), // input
    .tx_axis_tdata(qsfp4_mac_tx_axis_tdata), // input [511:0]
    .tx_axis_tlast(qsfp4_mac_tx_axis_tlast), // input
    .tx_axis_tkeep(qsfp4_mac_tx_axis_tkeep), // input [63:0]
    .tx_axis_tuser(qsfp4_mac_tx_axis_tuser), // input

    .tx_ovfout(), // output
    .tx_unfout(), // output
    .tx_preamblein(56'd0), // input [55:0]
    .usr_tx_reset(qsfp4_tx_rst_int), // output

    .core_drp_reset(1'b0), // input
    .drp_clk(1'b0), // input
    .drp_addr(10'd0), // input [9:0]
    .drp_di(16'd0), // input [15:0]
    .drp_en(1'b0), // input
    .drp_do(), // output [15:0]
    .drp_rdy(), // output
    .drp_we(1'b0) // input
);


/*
 * qsfp5
 */
cmac_pad #(
    .DATA_WIDTH(AXIS_ETH_DATA_WIDTH),
    .KEEP_WIDTH(AXIS_ETH_KEEP_WIDTH),
    .USER_WIDTH(1)
)
qsfp5_cmac_pad_inst (
    .clk(qsfp5_tx_clk_int),
    .rst(qsfp5_tx_rst_int),

    .s_axis_tdata(qsfp5_tx_axis_tdata_int),
    .s_axis_tkeep(qsfp5_tx_axis_tkeep_int),
    .s_axis_tvalid(qsfp5_tx_axis_tvalid_int),
    .s_axis_tready(qsfp5_tx_axis_tready_int),
    .s_axis_tlast(qsfp5_tx_axis_tlast_int),
    .s_axis_tuser(qsfp5_tx_axis_tuser_int),

    .m_axis_tdata(qsfp5_mac_tx_axis_tdata),
    .m_axis_tkeep(qsfp5_mac_tx_axis_tkeep),
    .m_axis_tvalid(qsfp5_mac_tx_axis_tvalid),
    .m_axis_tready(qsfp5_mac_tx_axis_tready),
    .m_axis_tlast(qsfp5_mac_tx_axis_tlast),
    .m_axis_tuser(qsfp5_mac_tx_axis_tuser)
);

cmac_usplus_4
qsfp5_cmac_inst (
    .gt_rxp_in({qsfp5_rx4_p, qsfp5_rx3_p, qsfp5_rx2_p, qsfp5_rx1_p}), // input
    .gt_rxn_in({qsfp5_rx4_n, qsfp5_rx3_n, qsfp5_rx2_n, qsfp5_rx1_n}), // input
    .gt_txp_out({qsfp5_tx4_p, qsfp5_tx3_p, qsfp5_tx2_p, qsfp5_tx1_p}), // output
    .gt_txn_out({qsfp5_tx4_n, qsfp5_tx3_n, qsfp5_tx2_n, qsfp5_tx1_n}), // output
    .gt_txusrclk2(qsfp5_txuserclk2), // output
    .gt_loopback_in(12'd0), // input [11:0]
    .gt_rxrecclkout(), // output [3:0]
    .gt_powergoodout(), // output [3:0]
    .gt_ref_clk_out(), // output
    .gtwiz_reset_tx_datapath(1'b0), // input
    .gtwiz_reset_rx_datapath(1'b0), // input

    .gt_ref_clk_p(qsfp5_mgt_refclk_0_p), // input
    .gt_ref_clk_n(qsfp5_mgt_refclk_0_n), // input

    .init_clk(clk_125mhz), // input
    .sys_reset(clk_125mhz_rst_qsfp), // input

    .rx_axis_tvalid(qsfp5_rx_axis_tvalid_int), // output
    .rx_axis_tdata(qsfp5_rx_axis_tdata_int), // output [511:0]
    .rx_axis_tlast(qsfp5_rx_axis_tlast_int), // output
    .rx_axis_tkeep(qsfp5_rx_axis_tkeep_int), // output [63:0]
    .rx_axis_tuser(qsfp5_rx_axis_tuser_int), // output

    .rx_otn_bip8_0(), // output [7:0]
    .rx_otn_bip8_1(), // output [7:0]
    .rx_otn_bip8_2(), // output [7:0]
    .rx_otn_bip8_3(), // output [7:0]
    .rx_otn_bip8_4(), // output [7:0]
    .rx_otn_data_0(), // output [65:0]
    .rx_otn_data_1(), // output [65:0]
    .rx_otn_data_2(), // output [65:0]
    .rx_otn_data_3(), // output [65:0]
    .rx_otn_data_4(), // output [65:0]
    .rx_otn_ena(), // output
    .rx_otn_lane0(), // output
    .rx_otn_vlmarker(), // output
    .rx_preambleout(), // output [55:0]
    .usr_rx_reset(qsfp5_rx_rst_int), // output
    .gt_rxusrclk2(), // output

    .stat_rx_aligned(vector_signals[8]), // output
    .stat_rx_aligned_err(), // output
    .stat_rx_bad_code(), // output [2:0]
    .stat_rx_bad_fcs(), // output [2:0]
    .stat_rx_bad_preamble(), // output
    .stat_rx_bad_sfd(), // output
    .stat_rx_bip_err_0(), // output
    .stat_rx_bip_err_1(), // output
    .stat_rx_bip_err_10(), // output
    .stat_rx_bip_err_11(), // output
    .stat_rx_bip_err_12(), // output
    .stat_rx_bip_err_13(), // output
    .stat_rx_bip_err_14(), // output
    .stat_rx_bip_err_15(), // output
    .stat_rx_bip_err_16(), // output
    .stat_rx_bip_err_17(), // output
    .stat_rx_bip_err_18(), // output
    .stat_rx_bip_err_19(), // output
    .stat_rx_bip_err_2(), // output
    .stat_rx_bip_err_3(), // output
    .stat_rx_bip_err_4(), // output
    .stat_rx_bip_err_5(), // output
    .stat_rx_bip_err_6(), // output
    .stat_rx_bip_err_7(), // output
    .stat_rx_bip_err_8(), // output
    .stat_rx_bip_err_9(), // output
    .stat_rx_block_lock(), // output [19:0]
    .stat_rx_broadcast(), // output
    .stat_rx_fragment(), // output [2:0]
    .stat_rx_framing_err_0(), // output [1:0]
    .stat_rx_framing_err_1(), // output [1:0]
    .stat_rx_framing_err_10(), // output [1:0]
    .stat_rx_framing_err_11(), // output [1:0]
    .stat_rx_framing_err_12(), // output [1:0]
    .stat_rx_framing_err_13(), // output [1:0]
    .stat_rx_framing_err_14(), // output [1:0]
    .stat_rx_framing_err_15(), // output [1:0]
    .stat_rx_framing_err_16(), // output [1:0]
    .stat_rx_framing_err_17(), // output [1:0]
    .stat_rx_framing_err_18(), // output [1:0]
    .stat_rx_framing_err_19(), // output [1:0]
    .stat_rx_framing_err_2(), // output [1:0]
    .stat_rx_framing_err_3(), // output [1:0]
    .stat_rx_framing_err_4(), // output [1:0]
    .stat_rx_framing_err_5(), // output [1:0]
    .stat_rx_framing_err_6(), // output [1:0]
    .stat_rx_framing_err_7(), // output [1:0]
    .stat_rx_framing_err_8(), // output [1:0]
    .stat_rx_framing_err_9(), // output [1:0]
    .stat_rx_framing_err_valid_0(), // output
    .stat_rx_framing_err_valid_1(), // output
    .stat_rx_framing_err_valid_10(), // output
    .stat_rx_framing_err_valid_11(), // output
    .stat_rx_framing_err_valid_12(), // output
    .stat_rx_framing_err_valid_13(), // output
    .stat_rx_framing_err_valid_14(), // output
    .stat_rx_framing_err_valid_15(), // output
    .stat_rx_framing_err_valid_16(), // output
    .stat_rx_framing_err_valid_17(), // output
    .stat_rx_framing_err_valid_18(), // output
    .stat_rx_framing_err_valid_19(), // output
    .stat_rx_framing_err_valid_2(), // output
    .stat_rx_framing_err_valid_3(), // output
    .stat_rx_framing_err_valid_4(), // output
    .stat_rx_framing_err_valid_5(), // output
    .stat_rx_framing_err_valid_6(), // output
    .stat_rx_framing_err_valid_7(), // output
    .stat_rx_framing_err_valid_8(), // output
    .stat_rx_framing_err_valid_9(), // output
    .stat_rx_got_signal_os(), // output
    .stat_rx_hi_ber(), // output
    .stat_rx_inrangeerr(), // output
    .stat_rx_internal_local_fault(), // output
    .stat_rx_jabber(), // output
    .stat_rx_local_fault(), // output
    .stat_rx_mf_err(), // output [19:0]
    .stat_rx_mf_len_err(), // output [19:0]
    .stat_rx_mf_repeat_err(), // output [19:0]
    .stat_rx_misaligned(), // output
    .stat_rx_multicast(), // output
    .stat_rx_oversize(), // output
    .stat_rx_packet_1024_1518_bytes(), // output
    .stat_rx_packet_128_255_bytes(), // output
    .stat_rx_packet_1519_1522_bytes(), // output
    .stat_rx_packet_1523_1548_bytes(), // output
    .stat_rx_packet_1549_2047_bytes(), // output
    .stat_rx_packet_2048_4095_bytes(), // output
    .stat_rx_packet_256_511_bytes(), // output
    .stat_rx_packet_4096_8191_bytes(), // output
    .stat_rx_packet_512_1023_bytes(), // output
    .stat_rx_packet_64_bytes(), // output
    .stat_rx_packet_65_127_bytes(), // output
    .stat_rx_packet_8192_9215_bytes(), // output
    .stat_rx_packet_bad_fcs(), // output
    .stat_rx_packet_large(), // output
    .stat_rx_packet_small(), // output [2:0]

    .ctl_rx_enable(1'b1), // input
    .ctl_rx_force_resync(1'b0), // input
    .ctl_rx_test_pattern(1'b0), // input
    .ctl_rsfec_ieee_error_indication_mode(1'b0), // input
    .ctl_rx_rsfec_enable(1'b1), // input
    .ctl_rx_rsfec_enable_correction(1'b1), // input
    .ctl_rx_rsfec_enable_indication(1'b1), // input
    .core_rx_reset(1'b0), // input
    .rx_clk(qsfp5_rx_clk_int), // input

    .stat_rx_received_local_fault(), // output
    .stat_rx_remote_fault(), // output
    .stat_rx_status(vector_signals[9]), // output
    .stat_rx_stomped_fcs(), // output [2:0]
    .stat_rx_synced(), // output [19:0]
    .stat_rx_synced_err(), // output [19:0]
    .stat_rx_test_pattern_mismatch(), // output [2:0]
    .stat_rx_toolong(), // output
    .stat_rx_total_bytes(), // output [6:0]
    .stat_rx_total_good_bytes(), // output [13:0]
    .stat_rx_total_good_packets(), // output
    .stat_rx_total_packets(), // output [2:0]
    .stat_rx_truncated(), // output
    .stat_rx_undersize(), // output [2:0]
    .stat_rx_unicast(), // output
    .stat_rx_vlan(), // output
    .stat_rx_pcsl_demuxed(), // output [19:0]
    .stat_rx_pcsl_number_0(), // output [4:0]
    .stat_rx_pcsl_number_1(), // output [4:0]
    .stat_rx_pcsl_number_10(), // output [4:0]
    .stat_rx_pcsl_number_11(), // output [4:0]
    .stat_rx_pcsl_number_12(), // output [4:0]
    .stat_rx_pcsl_number_13(), // output [4:0]
    .stat_rx_pcsl_number_14(), // output [4:0]
    .stat_rx_pcsl_number_15(), // output [4:0]
    .stat_rx_pcsl_number_16(), // output [4:0]
    .stat_rx_pcsl_number_17(), // output [4:0]
    .stat_rx_pcsl_number_18(), // output [4:0]
    .stat_rx_pcsl_number_19(), // output [4:0]
    .stat_rx_pcsl_number_2(), // output [4:0]
    .stat_rx_pcsl_number_3(), // output [4:0]
    .stat_rx_pcsl_number_4(), // output [4:0]
    .stat_rx_pcsl_number_5(), // output [4:0]
    .stat_rx_pcsl_number_6(), // output [4:0]
    .stat_rx_pcsl_number_7(), // output [4:0]
    .stat_rx_pcsl_number_8(), // output [4:0]
    .stat_rx_pcsl_number_9(), // output [4:0]
    .stat_rx_rsfec_am_lock0(), // output
    .stat_rx_rsfec_am_lock1(), // output
    .stat_rx_rsfec_am_lock2(), // output
    .stat_rx_rsfec_am_lock3(), // output
    .stat_rx_rsfec_corrected_cw_inc(), // output
    .stat_rx_rsfec_cw_inc(), // output
    .stat_rx_rsfec_err_count0_inc(), // output [2:0]
    .stat_rx_rsfec_err_count1_inc(), // output [2:0]
    .stat_rx_rsfec_err_count2_inc(), // output [2:0]
    .stat_rx_rsfec_err_count3_inc(), // output [2:0]
    .stat_rx_rsfec_hi_ser(), // output
    .stat_rx_rsfec_lane_alignment_status(), // output
    .stat_rx_rsfec_lane_fill_0(), // output [13:0]
    .stat_rx_rsfec_lane_fill_1(), // output [13:0]
    .stat_rx_rsfec_lane_fill_2(), // output [13:0]
    .stat_rx_rsfec_lane_fill_3(), // output [13:0]
    .stat_rx_rsfec_lane_mapping(), // output [7:0]
    .stat_rx_rsfec_uncorrected_cw_inc(), // output

    .stat_tx_bad_fcs(), // output
    .stat_tx_broadcast(), // output
    .stat_tx_frame_error(), // output
    .stat_tx_local_fault(), // output
    .stat_tx_multicast(), // output
    .stat_tx_packet_1024_1518_bytes(), // output
    .stat_tx_packet_128_255_bytes(), // output
    .stat_tx_packet_1519_1522_bytes(), // output
    .stat_tx_packet_1523_1548_bytes(), // output
    .stat_tx_packet_1549_2047_bytes(), // output
    .stat_tx_packet_2048_4095_bytes(), // output
    .stat_tx_packet_256_511_bytes(), // output
    .stat_tx_packet_4096_8191_bytes(), // output
    .stat_tx_packet_512_1023_bytes(), // output
    .stat_tx_packet_64_bytes(), // output
    .stat_tx_packet_65_127_bytes(), // output
    .stat_tx_packet_8192_9215_bytes(), // output
    .stat_tx_packet_large(), // output
    .stat_tx_packet_small(), // output
    .stat_tx_total_bytes(), // output [5:0]
    .stat_tx_total_good_bytes(), // output [13:0]
    .stat_tx_total_good_packets(), // output
    .stat_tx_total_packets(), // output
    .stat_tx_unicast(), // output
    .stat_tx_vlan(), // output

    .ctl_tx_enable(1'b1), // input
    .ctl_tx_test_pattern(1'b0), // input
    .ctl_tx_rsfec_enable(1'b1), // input
    .ctl_tx_send_idle(1'b0), // input
    .ctl_tx_send_rfi(1'b0), // input
    .ctl_tx_send_lfi(1'b0), // input
    .core_tx_reset(1'b0), // input

    .tx_axis_tready(qsfp5_mac_tx_axis_tready), // output
    .tx_axis_tvalid(qsfp5_mac_tx_axis_tvalid), // input
    .tx_axis_tdata(qsfp5_mac_tx_axis_tdata), // input [511:0]
    .tx_axis_tlast(qsfp5_mac_tx_axis_tlast), // input
    .tx_axis_tkeep(qsfp5_mac_tx_axis_tkeep), // input [63:0]
    .tx_axis_tuser(qsfp5_mac_tx_axis_tuser), // input

    .tx_ovfout(), // output
    .tx_unfout(), // output
    .tx_preamblein(56'd0), // input [55:0]
    .usr_tx_reset(qsfp5_tx_rst_int), // output

    .core_drp_reset(1'b0), // input
    .drp_clk(1'b0), // input
    .drp_addr(10'd0), // input [9:0]
    .drp_di(16'd0), // input [15:0]
    .drp_en(1'b0), // input
    .drp_do(), // output [15:0]
    .drp_rdy(), // output
    .drp_we(1'b0) // input
);


/*
 * qsfp6
 */
cmac_pad #(
    .DATA_WIDTH(AXIS_ETH_DATA_WIDTH),
    .KEEP_WIDTH(AXIS_ETH_KEEP_WIDTH),
    .USER_WIDTH(1)
)
qsfp6_cmac_pad_inst (
    .clk(qsfp6_tx_clk_int),
    .rst(qsfp6_tx_rst_int),

    .s_axis_tdata(qsfp6_tx_axis_tdata_int),
    .s_axis_tkeep(qsfp6_tx_axis_tkeep_int),
    .s_axis_tvalid(qsfp6_tx_axis_tvalid_int),
    .s_axis_tready(qsfp6_tx_axis_tready_int),
    .s_axis_tlast(qsfp6_tx_axis_tlast_int),
    .s_axis_tuser(qsfp6_tx_axis_tuser_int),

    .m_axis_tdata(qsfp6_mac_tx_axis_tdata),
    .m_axis_tkeep(qsfp6_mac_tx_axis_tkeep),
    .m_axis_tvalid(qsfp6_mac_tx_axis_tvalid),
    .m_axis_tready(qsfp6_mac_tx_axis_tready),
    .m_axis_tlast(qsfp6_mac_tx_axis_tlast),
    .m_axis_tuser(qsfp6_mac_tx_axis_tuser)
);

cmac_usplus_5
qsfp6_cmac_inst (
    .gt_rxp_in({qsfp6_rx4_p, qsfp6_rx3_p, qsfp6_rx2_p, qsfp6_rx1_p}), // input
    .gt_rxn_in({qsfp6_rx4_n, qsfp6_rx3_n, qsfp6_rx2_n, qsfp6_rx1_n}), // input
    .gt_txp_out({qsfp6_tx4_p, qsfp6_tx3_p, qsfp6_tx2_p, qsfp6_tx1_p}), // output
    .gt_txn_out({qsfp6_tx4_n, qsfp6_tx3_n, qsfp6_tx2_n, qsfp6_tx1_n}), // output
    .gt_txusrclk2(qsfp6_txuserclk2), // output
    .gt_loopback_in(12'd0), // input [11:0]
    .gt_rxrecclkout(), // output [3:0]
    .gt_powergoodout(), // output [3:0]
    .gt_ref_clk_out(), // output
    .gtwiz_reset_tx_datapath(1'b0), // input
    .gtwiz_reset_rx_datapath(1'b0), // input

    .gt_ref_clk_p(qsfp6_mgt_refclk_0_p), // input
    .gt_ref_clk_n(qsfp6_mgt_refclk_0_n), // input

    .init_clk(clk_125mhz), // input
    .sys_reset(clk_125mhz_rst_qsfp), // input

    .rx_axis_tvalid(qsfp6_rx_axis_tvalid_int), // output
    .rx_axis_tdata(qsfp6_rx_axis_tdata_int), // output [511:0]
    .rx_axis_tlast(qsfp6_rx_axis_tlast_int), // output
    .rx_axis_tkeep(qsfp6_rx_axis_tkeep_int), // output [63:0]
    .rx_axis_tuser(qsfp6_rx_axis_tuser_int), // output

    .rx_otn_bip8_0(), // output [7:0]
    .rx_otn_bip8_1(), // output [7:0]
    .rx_otn_bip8_2(), // output [7:0]
    .rx_otn_bip8_3(), // output [7:0]
    .rx_otn_bip8_4(), // output [7:0]
    .rx_otn_data_0(), // output [65:0]
    .rx_otn_data_1(), // output [65:0]
    .rx_otn_data_2(), // output [65:0]
    .rx_otn_data_3(), // output [65:0]
    .rx_otn_data_4(), // output [65:0]
    .rx_otn_ena(), // output
    .rx_otn_lane0(), // output
    .rx_otn_vlmarker(), // output
    .rx_preambleout(), // output [55:0]
    .usr_rx_reset(qsfp6_rx_rst_int), // output
    .gt_rxusrclk2(), // output

    .stat_rx_aligned(vector_signals[10]), // output
    .stat_rx_aligned_err(), // output
    .stat_rx_bad_code(), // output [2:0]
    .stat_rx_bad_fcs(), // output [2:0]
    .stat_rx_bad_preamble(), // output
    .stat_rx_bad_sfd(), // output
    .stat_rx_bip_err_0(), // output
    .stat_rx_bip_err_1(), // output
    .stat_rx_bip_err_10(), // output
    .stat_rx_bip_err_11(), // output
    .stat_rx_bip_err_12(), // output
    .stat_rx_bip_err_13(), // output
    .stat_rx_bip_err_14(), // output
    .stat_rx_bip_err_15(), // output
    .stat_rx_bip_err_16(), // output
    .stat_rx_bip_err_17(), // output
    .stat_rx_bip_err_18(), // output
    .stat_rx_bip_err_19(), // output
    .stat_rx_bip_err_2(), // output
    .stat_rx_bip_err_3(), // output
    .stat_rx_bip_err_4(), // output
    .stat_rx_bip_err_5(), // output
    .stat_rx_bip_err_6(), // output
    .stat_rx_bip_err_7(), // output
    .stat_rx_bip_err_8(), // output
    .stat_rx_bip_err_9(), // output
    .stat_rx_block_lock(), // output [19:0]
    .stat_rx_broadcast(), // output
    .stat_rx_fragment(), // output [2:0]
    .stat_rx_framing_err_0(), // output [1:0]
    .stat_rx_framing_err_1(), // output [1:0]
    .stat_rx_framing_err_10(), // output [1:0]
    .stat_rx_framing_err_11(), // output [1:0]
    .stat_rx_framing_err_12(), // output [1:0]
    .stat_rx_framing_err_13(), // output [1:0]
    .stat_rx_framing_err_14(), // output [1:0]
    .stat_rx_framing_err_15(), // output [1:0]
    .stat_rx_framing_err_16(), // output [1:0]
    .stat_rx_framing_err_17(), // output [1:0]
    .stat_rx_framing_err_18(), // output [1:0]
    .stat_rx_framing_err_19(), // output [1:0]
    .stat_rx_framing_err_2(), // output [1:0]
    .stat_rx_framing_err_3(), // output [1:0]
    .stat_rx_framing_err_4(), // output [1:0]
    .stat_rx_framing_err_5(), // output [1:0]
    .stat_rx_framing_err_6(), // output [1:0]
    .stat_rx_framing_err_7(), // output [1:0]
    .stat_rx_framing_err_8(), // output [1:0]
    .stat_rx_framing_err_9(), // output [1:0]
    .stat_rx_framing_err_valid_0(), // output
    .stat_rx_framing_err_valid_1(), // output
    .stat_rx_framing_err_valid_10(), // output
    .stat_rx_framing_err_valid_11(), // output
    .stat_rx_framing_err_valid_12(), // output
    .stat_rx_framing_err_valid_13(), // output
    .stat_rx_framing_err_valid_14(), // output
    .stat_rx_framing_err_valid_15(), // output
    .stat_rx_framing_err_valid_16(), // output
    .stat_rx_framing_err_valid_17(), // output
    .stat_rx_framing_err_valid_18(), // output
    .stat_rx_framing_err_valid_19(), // output
    .stat_rx_framing_err_valid_2(), // output
    .stat_rx_framing_err_valid_3(), // output
    .stat_rx_framing_err_valid_4(), // output
    .stat_rx_framing_err_valid_5(), // output
    .stat_rx_framing_err_valid_6(), // output
    .stat_rx_framing_err_valid_7(), // output
    .stat_rx_framing_err_valid_8(), // output
    .stat_rx_framing_err_valid_9(), // output
    .stat_rx_got_signal_os(), // output
    .stat_rx_hi_ber(), // output
    .stat_rx_inrangeerr(), // output
    .stat_rx_internal_local_fault(), // output
    .stat_rx_jabber(), // output
    .stat_rx_local_fault(), // output
    .stat_rx_mf_err(), // output [19:0]
    .stat_rx_mf_len_err(), // output [19:0]
    .stat_rx_mf_repeat_err(), // output [19:0]
    .stat_rx_misaligned(), // output
    .stat_rx_multicast(), // output
    .stat_rx_oversize(), // output
    .stat_rx_packet_1024_1518_bytes(), // output
    .stat_rx_packet_128_255_bytes(), // output
    .stat_rx_packet_1519_1522_bytes(), // output
    .stat_rx_packet_1523_1548_bytes(), // output
    .stat_rx_packet_1549_2047_bytes(), // output
    .stat_rx_packet_2048_4095_bytes(), // output
    .stat_rx_packet_256_511_bytes(), // output
    .stat_rx_packet_4096_8191_bytes(), // output
    .stat_rx_packet_512_1023_bytes(), // output
    .stat_rx_packet_64_bytes(), // output
    .stat_rx_packet_65_127_bytes(), // output
    .stat_rx_packet_8192_9215_bytes(), // output
    .stat_rx_packet_bad_fcs(), // output
    .stat_rx_packet_large(), // output
    .stat_rx_packet_small(), // output [2:0]

    .ctl_rx_enable(1'b1), // input
    .ctl_rx_force_resync(1'b0), // input
    .ctl_rx_test_pattern(1'b0), // input
    .ctl_rsfec_ieee_error_indication_mode(1'b0), // input
    .ctl_rx_rsfec_enable(1'b1), // input
    .ctl_rx_rsfec_enable_correction(1'b1), // input
    .ctl_rx_rsfec_enable_indication(1'b1), // input
    .core_rx_reset(1'b0), // input
    .rx_clk(qsfp6_rx_clk_int), // input

    .stat_rx_received_local_fault(), // output
    .stat_rx_remote_fault(), // output
    .stat_rx_status(vector_signals[11]), // output
    .stat_rx_stomped_fcs(), // output [2:0]
    .stat_rx_synced(), // output [19:0]
    .stat_rx_synced_err(), // output [19:0]
    .stat_rx_test_pattern_mismatch(), // output [2:0]
    .stat_rx_toolong(), // output
    .stat_rx_total_bytes(), // output [6:0]
    .stat_rx_total_good_bytes(), // output [13:0]
    .stat_rx_total_good_packets(), // output
    .stat_rx_total_packets(), // output [2:0]
    .stat_rx_truncated(), // output
    .stat_rx_undersize(), // output [2:0]
    .stat_rx_unicast(), // output
    .stat_rx_vlan(), // output
    .stat_rx_pcsl_demuxed(), // output [19:0]
    .stat_rx_pcsl_number_0(), // output [4:0]
    .stat_rx_pcsl_number_1(), // output [4:0]
    .stat_rx_pcsl_number_10(), // output [4:0]
    .stat_rx_pcsl_number_11(), // output [4:0]
    .stat_rx_pcsl_number_12(), // output [4:0]
    .stat_rx_pcsl_number_13(), // output [4:0]
    .stat_rx_pcsl_number_14(), // output [4:0]
    .stat_rx_pcsl_number_15(), // output [4:0]
    .stat_rx_pcsl_number_16(), // output [4:0]
    .stat_rx_pcsl_number_17(), // output [4:0]
    .stat_rx_pcsl_number_18(), // output [4:0]
    .stat_rx_pcsl_number_19(), // output [4:0]
    .stat_rx_pcsl_number_2(), // output [4:0]
    .stat_rx_pcsl_number_3(), // output [4:0]
    .stat_rx_pcsl_number_4(), // output [4:0]
    .stat_rx_pcsl_number_5(), // output [4:0]
    .stat_rx_pcsl_number_6(), // output [4:0]
    .stat_rx_pcsl_number_7(), // output [4:0]
    .stat_rx_pcsl_number_8(), // output [4:0]
    .stat_rx_pcsl_number_9(), // output [4:0]
    .stat_rx_rsfec_am_lock0(), // output
    .stat_rx_rsfec_am_lock1(), // output
    .stat_rx_rsfec_am_lock2(), // output
    .stat_rx_rsfec_am_lock3(), // output
    .stat_rx_rsfec_corrected_cw_inc(), // output
    .stat_rx_rsfec_cw_inc(), // output
    .stat_rx_rsfec_err_count0_inc(), // output [2:0]
    .stat_rx_rsfec_err_count1_inc(), // output [2:0]
    .stat_rx_rsfec_err_count2_inc(), // output [2:0]
    .stat_rx_rsfec_err_count3_inc(), // output [2:0]
    .stat_rx_rsfec_hi_ser(), // output
    .stat_rx_rsfec_lane_alignment_status(), // output
    .stat_rx_rsfec_lane_fill_0(), // output [13:0]
    .stat_rx_rsfec_lane_fill_1(), // output [13:0]
    .stat_rx_rsfec_lane_fill_2(), // output [13:0]
    .stat_rx_rsfec_lane_fill_3(), // output [13:0]
    .stat_rx_rsfec_lane_mapping(), // output [7:0]
    .stat_rx_rsfec_uncorrected_cw_inc(), // output

    .stat_tx_bad_fcs(), // output
    .stat_tx_broadcast(), // output
    .stat_tx_frame_error(), // output
    .stat_tx_local_fault(), // output
    .stat_tx_multicast(), // output
    .stat_tx_packet_1024_1518_bytes(), // output
    .stat_tx_packet_128_255_bytes(), // output
    .stat_tx_packet_1519_1522_bytes(), // output
    .stat_tx_packet_1523_1548_bytes(), // output
    .stat_tx_packet_1549_2047_bytes(), // output
    .stat_tx_packet_2048_4095_bytes(), // output
    .stat_tx_packet_256_511_bytes(), // output
    .stat_tx_packet_4096_8191_bytes(), // output
    .stat_tx_packet_512_1023_bytes(), // output
    .stat_tx_packet_64_bytes(), // output
    .stat_tx_packet_65_127_bytes(), // output
    .stat_tx_packet_8192_9215_bytes(), // output
    .stat_tx_packet_large(), // output
    .stat_tx_packet_small(), // output
    .stat_tx_total_bytes(), // output [5:0]
    .stat_tx_total_good_bytes(), // output [13:0]
    .stat_tx_total_good_packets(), // output
    .stat_tx_total_packets(), // output
    .stat_tx_unicast(), // output
    .stat_tx_vlan(), // output

    .ctl_tx_enable(1'b1), // input
    .ctl_tx_test_pattern(1'b0), // input
    .ctl_tx_rsfec_enable(1'b1), // input
    .ctl_tx_send_idle(1'b0), // input
    .ctl_tx_send_rfi(1'b0), // input
    .ctl_tx_send_lfi(1'b0), // input
    .core_tx_reset(1'b0), // input

    .tx_axis_tready(qsfp6_mac_tx_axis_tready), // output
    .tx_axis_tvalid(qsfp6_mac_tx_axis_tvalid), // input
    .tx_axis_tdata(qsfp6_mac_tx_axis_tdata), // input [511:0]
    .tx_axis_tlast(qsfp6_mac_tx_axis_tlast), // input
    .tx_axis_tkeep(qsfp6_mac_tx_axis_tkeep), // input [63:0]
    .tx_axis_tuser(qsfp6_mac_tx_axis_tuser), // input

    .tx_ovfout(), // output
    .tx_unfout(), // output
    .tx_preamblein(56'd0), // input [55:0]
    .usr_tx_reset(qsfp6_tx_rst_int), // output

    .core_drp_reset(1'b0), // input
    .drp_clk(1'b0), // input
    .drp_addr(10'd0), // input [9:0]
    .drp_di(16'd0), // input [15:0]
    .drp_en(1'b0), // input
    .drp_do(), // output [15:0]
    .drp_rdy(), // output
    .drp_we(1'b0) // input
);

/*
 * qsfp7
 */
cmac_pad #(
    .DATA_WIDTH(AXIS_ETH_DATA_WIDTH),
    .KEEP_WIDTH(AXIS_ETH_KEEP_WIDTH),
    .USER_WIDTH(1)
)
qsfp7_cmac_pad_inst (
    .clk(qsfp7_tx_clk_int),
    .rst(qsfp7_tx_rst_int),

    .s_axis_tdata(qsfp7_tx_axis_tdata_int),
    .s_axis_tkeep(qsfp7_tx_axis_tkeep_int),
    .s_axis_tvalid(qsfp7_tx_axis_tvalid_int),
    .s_axis_tready(qsfp7_tx_axis_tready_int),
    .s_axis_tlast(qsfp7_tx_axis_tlast_int),
    .s_axis_tuser(qsfp7_tx_axis_tuser_int),

    .m_axis_tdata(qsfp7_mac_tx_axis_tdata),
    .m_axis_tkeep(qsfp7_mac_tx_axis_tkeep),
    .m_axis_tvalid(qsfp7_mac_tx_axis_tvalid),
    .m_axis_tready(qsfp7_mac_tx_axis_tready),
    .m_axis_tlast(qsfp7_mac_tx_axis_tlast),
    .m_axis_tuser(qsfp7_mac_tx_axis_tuser)
);

cmac_usplus_6
qsfp7_cmac_inst (
    .gt_rxp_in({qsfp7_rx4_p, qsfp7_rx3_p, qsfp7_rx2_p, qsfp7_rx1_p}), // input
    .gt_rxn_in({qsfp7_rx4_n, qsfp7_rx3_n, qsfp7_rx2_n, qsfp7_rx1_n}), // input
    .gt_txp_out({qsfp7_tx4_p, qsfp7_tx3_p, qsfp7_tx2_p, qsfp7_tx1_p}), // output
    .gt_txn_out({qsfp7_tx4_n, qsfp7_tx3_n, qsfp7_tx2_n, qsfp7_tx1_n}), // output
    .gt_txusrclk2(qsfp7_txuserclk2), // output
    .gt_loopback_in(12'd0), // input [11:0]
    .gt_rxrecclkout(), // output [3:0]
    .gt_powergoodout(), // output [3:0]
    .gt_ref_clk_out(), // output
    .gtwiz_reset_tx_datapath(1'b0), // input
    .gtwiz_reset_rx_datapath(1'b0), // input

    .gt_ref_clk_p(qsfp7_mgt_refclk_0_p), // input
    .gt_ref_clk_n(qsfp7_mgt_refclk_0_n), // input

    .init_clk(clk_125mhz), // input
    .sys_reset(clk_125mhz_rst_qsfp), // input

    .rx_axis_tvalid(qsfp7_rx_axis_tvalid_int), // output
    .rx_axis_tdata(qsfp7_rx_axis_tdata_int), // output [511:0]
    .rx_axis_tlast(qsfp7_rx_axis_tlast_int), // output
    .rx_axis_tkeep(qsfp7_rx_axis_tkeep_int), // output [63:0]
    .rx_axis_tuser(qsfp7_rx_axis_tuser_int), // output

    .rx_otn_bip8_0(), // output [7:0]
    .rx_otn_bip8_1(), // output [7:0]
    .rx_otn_bip8_2(), // output [7:0]
    .rx_otn_bip8_3(), // output [7:0]
    .rx_otn_bip8_4(), // output [7:0]
    .rx_otn_data_0(), // output [65:0]
    .rx_otn_data_1(), // output [65:0]
    .rx_otn_data_2(), // output [65:0]
    .rx_otn_data_3(), // output [65:0]
    .rx_otn_data_4(), // output [65:0]
    .rx_otn_ena(), // output
    .rx_otn_lane0(), // output
    .rx_otn_vlmarker(), // output
    .rx_preambleout(), // output [55:0]
    .usr_rx_reset(qsfp7_rx_rst_int), // output
    .gt_rxusrclk2(), // output

    .stat_rx_aligned(vector_signals[12]), // output
    .stat_rx_aligned_err(), // output
    .stat_rx_bad_code(), // output [2:0]
    .stat_rx_bad_fcs(), // output [2:0]
    .stat_rx_bad_preamble(), // output
    .stat_rx_bad_sfd(), // output
    .stat_rx_bip_err_0(), // output
    .stat_rx_bip_err_1(), // output
    .stat_rx_bip_err_10(), // output
    .stat_rx_bip_err_11(), // output
    .stat_rx_bip_err_12(), // output
    .stat_rx_bip_err_13(), // output
    .stat_rx_bip_err_14(), // output
    .stat_rx_bip_err_15(), // output
    .stat_rx_bip_err_16(), // output
    .stat_rx_bip_err_17(), // output
    .stat_rx_bip_err_18(), // output
    .stat_rx_bip_err_19(), // output
    .stat_rx_bip_err_2(), // output
    .stat_rx_bip_err_3(), // output
    .stat_rx_bip_err_4(), // output
    .stat_rx_bip_err_5(), // output
    .stat_rx_bip_err_6(), // output
    .stat_rx_bip_err_7(), // output
    .stat_rx_bip_err_8(), // output
    .stat_rx_bip_err_9(), // output
    .stat_rx_block_lock(), // output [19:0]
    .stat_rx_broadcast(), // output
    .stat_rx_fragment(), // output [2:0]
    .stat_rx_framing_err_0(), // output [1:0]
    .stat_rx_framing_err_1(), // output [1:0]
    .stat_rx_framing_err_10(), // output [1:0]
    .stat_rx_framing_err_11(), // output [1:0]
    .stat_rx_framing_err_12(), // output [1:0]
    .stat_rx_framing_err_13(), // output [1:0]
    .stat_rx_framing_err_14(), // output [1:0]
    .stat_rx_framing_err_15(), // output [1:0]
    .stat_rx_framing_err_16(), // output [1:0]
    .stat_rx_framing_err_17(), // output [1:0]
    .stat_rx_framing_err_18(), // output [1:0]
    .stat_rx_framing_err_19(), // output [1:0]
    .stat_rx_framing_err_2(), // output [1:0]
    .stat_rx_framing_err_3(), // output [1:0]
    .stat_rx_framing_err_4(), // output [1:0]
    .stat_rx_framing_err_5(), // output [1:0]
    .stat_rx_framing_err_6(), // output [1:0]
    .stat_rx_framing_err_7(), // output [1:0]
    .stat_rx_framing_err_8(), // output [1:0]
    .stat_rx_framing_err_9(), // output [1:0]
    .stat_rx_framing_err_valid_0(), // output
    .stat_rx_framing_err_valid_1(), // output
    .stat_rx_framing_err_valid_10(), // output
    .stat_rx_framing_err_valid_11(), // output
    .stat_rx_framing_err_valid_12(), // output
    .stat_rx_framing_err_valid_13(), // output
    .stat_rx_framing_err_valid_14(), // output
    .stat_rx_framing_err_valid_15(), // output
    .stat_rx_framing_err_valid_16(), // output
    .stat_rx_framing_err_valid_17(), // output
    .stat_rx_framing_err_valid_18(), // output
    .stat_rx_framing_err_valid_19(), // output
    .stat_rx_framing_err_valid_2(), // output
    .stat_rx_framing_err_valid_3(), // output
    .stat_rx_framing_err_valid_4(), // output
    .stat_rx_framing_err_valid_5(), // output
    .stat_rx_framing_err_valid_6(), // output
    .stat_rx_framing_err_valid_7(), // output
    .stat_rx_framing_err_valid_8(), // output
    .stat_rx_framing_err_valid_9(), // output
    .stat_rx_got_signal_os(), // output
    .stat_rx_hi_ber(), // output
    .stat_rx_inrangeerr(), // output
    .stat_rx_internal_local_fault(), // output
    .stat_rx_jabber(), // output
    .stat_rx_local_fault(), // output
    .stat_rx_mf_err(), // output [19:0]
    .stat_rx_mf_len_err(), // output [19:0]
    .stat_rx_mf_repeat_err(), // output [19:0]
    .stat_rx_misaligned(), // output
    .stat_rx_multicast(), // output
    .stat_rx_oversize(), // output
    .stat_rx_packet_1024_1518_bytes(), // output
    .stat_rx_packet_128_255_bytes(), // output
    .stat_rx_packet_1519_1522_bytes(), // output
    .stat_rx_packet_1523_1548_bytes(), // output
    .stat_rx_packet_1549_2047_bytes(), // output
    .stat_rx_packet_2048_4095_bytes(), // output
    .stat_rx_packet_256_511_bytes(), // output
    .stat_rx_packet_4096_8191_bytes(), // output
    .stat_rx_packet_512_1023_bytes(), // output
    .stat_rx_packet_64_bytes(), // output
    .stat_rx_packet_65_127_bytes(), // output
    .stat_rx_packet_8192_9215_bytes(), // output
    .stat_rx_packet_bad_fcs(), // output
    .stat_rx_packet_large(), // output
    .stat_rx_packet_small(), // output [2:0]

    .ctl_rx_enable(1'b1), // input
    .ctl_rx_force_resync(1'b0), // input
    .ctl_rx_test_pattern(1'b0), // input
    .ctl_rsfec_ieee_error_indication_mode(1'b0), // input
    .ctl_rx_rsfec_enable(1'b1), // input
    .ctl_rx_rsfec_enable_correction(1'b1), // input
    .ctl_rx_rsfec_enable_indication(1'b1), // input
    .core_rx_reset(1'b0), // input
    .rx_clk(qsfp7_rx_clk_int), // input

    .stat_rx_received_local_fault(), // output
    .stat_rx_remote_fault(), // output
    .stat_rx_status(vector_signals[13]), // output
    .stat_rx_stomped_fcs(), // output [2:0]
    .stat_rx_synced(), // output [19:0]
    .stat_rx_synced_err(), // output [19:0]
    .stat_rx_test_pattern_mismatch(), // output [2:0]
    .stat_rx_toolong(), // output
    .stat_rx_total_bytes(), // output [6:0]
    .stat_rx_total_good_bytes(), // output [13:0]
    .stat_rx_total_good_packets(), // output
    .stat_rx_total_packets(), // output [2:0]
    .stat_rx_truncated(), // output
    .stat_rx_undersize(), // output [2:0]
    .stat_rx_unicast(), // output
    .stat_rx_vlan(), // output
    .stat_rx_pcsl_demuxed(), // output [19:0]
    .stat_rx_pcsl_number_0(), // output [4:0]
    .stat_rx_pcsl_number_1(), // output [4:0]
    .stat_rx_pcsl_number_10(), // output [4:0]
    .stat_rx_pcsl_number_11(), // output [4:0]
    .stat_rx_pcsl_number_12(), // output [4:0]
    .stat_rx_pcsl_number_13(), // output [4:0]
    .stat_rx_pcsl_number_14(), // output [4:0]
    .stat_rx_pcsl_number_15(), // output [4:0]
    .stat_rx_pcsl_number_16(), // output [4:0]
    .stat_rx_pcsl_number_17(), // output [4:0]
    .stat_rx_pcsl_number_18(), // output [4:0]
    .stat_rx_pcsl_number_19(), // output [4:0]
    .stat_rx_pcsl_number_2(), // output [4:0]
    .stat_rx_pcsl_number_3(), // output [4:0]
    .stat_rx_pcsl_number_4(), // output [4:0]
    .stat_rx_pcsl_number_5(), // output [4:0]
    .stat_rx_pcsl_number_6(), // output [4:0]
    .stat_rx_pcsl_number_7(), // output [4:0]
    .stat_rx_pcsl_number_8(), // output [4:0]
    .stat_rx_pcsl_number_9(), // output [4:0]
    .stat_rx_rsfec_am_lock0(), // output
    .stat_rx_rsfec_am_lock1(), // output
    .stat_rx_rsfec_am_lock2(), // output
    .stat_rx_rsfec_am_lock3(), // output
    .stat_rx_rsfec_corrected_cw_inc(), // output
    .stat_rx_rsfec_cw_inc(), // output
    .stat_rx_rsfec_err_count0_inc(), // output [2:0]
    .stat_rx_rsfec_err_count1_inc(), // output [2:0]
    .stat_rx_rsfec_err_count2_inc(), // output [2:0]
    .stat_rx_rsfec_err_count3_inc(), // output [2:0]
    .stat_rx_rsfec_hi_ser(), // output
    .stat_rx_rsfec_lane_alignment_status(), // output
    .stat_rx_rsfec_lane_fill_0(), // output [13:0]
    .stat_rx_rsfec_lane_fill_1(), // output [13:0]
    .stat_rx_rsfec_lane_fill_2(), // output [13:0]
    .stat_rx_rsfec_lane_fill_3(), // output [13:0]
    .stat_rx_rsfec_lane_mapping(), // output [7:0]
    .stat_rx_rsfec_uncorrected_cw_inc(), // output

    .stat_tx_bad_fcs(), // output
    .stat_tx_broadcast(), // output
    .stat_tx_frame_error(), // output
    .stat_tx_local_fault(), // output
    .stat_tx_multicast(), // output
    .stat_tx_packet_1024_1518_bytes(), // output
    .stat_tx_packet_128_255_bytes(), // output
    .stat_tx_packet_1519_1522_bytes(), // output
    .stat_tx_packet_1523_1548_bytes(), // output
    .stat_tx_packet_1549_2047_bytes(), // output
    .stat_tx_packet_2048_4095_bytes(), // output
    .stat_tx_packet_256_511_bytes(), // output
    .stat_tx_packet_4096_8191_bytes(), // output
    .stat_tx_packet_512_1023_bytes(), // output
    .stat_tx_packet_64_bytes(), // output
    .stat_tx_packet_65_127_bytes(), // output
    .stat_tx_packet_8192_9215_bytes(), // output
    .stat_tx_packet_large(), // output
    .stat_tx_packet_small(), // output
    .stat_tx_total_bytes(), // output [5:0]
    .stat_tx_total_good_bytes(), // output [13:0]
    .stat_tx_total_good_packets(), // output
    .stat_tx_total_packets(), // output
    .stat_tx_unicast(), // output
    .stat_tx_vlan(), // output

    .ctl_tx_enable(1'b1), // input
    .ctl_tx_test_pattern(1'b0), // input
    .ctl_tx_rsfec_enable(1'b1), // input
    .ctl_tx_send_idle(1'b0), // input
    .ctl_tx_send_rfi(1'b0), // input
    .ctl_tx_send_lfi(1'b0), // input
    .core_tx_reset(1'b0), // input

    .tx_axis_tready(qsfp7_mac_tx_axis_tready), // output
    .tx_axis_tvalid(qsfp7_mac_tx_axis_tvalid), // input
    .tx_axis_tdata(qsfp7_mac_tx_axis_tdata), // input [511:0]
    .tx_axis_tlast(qsfp7_mac_tx_axis_tlast), // input
    .tx_axis_tkeep(qsfp7_mac_tx_axis_tkeep), // input [63:0]
    .tx_axis_tuser(qsfp7_mac_tx_axis_tuser), // input

    .tx_ovfout(), // output
    .tx_unfout(), // output
    .tx_preamblein(56'd0), // input [55:0]
    .usr_tx_reset(qsfp7_tx_rst_int), // output

    .core_drp_reset(1'b0), // input
    .drp_clk(1'b0), // input
    .drp_addr(10'd0), // input [9:0]
    .drp_di(16'd0), // input [15:0]
    .drp_en(1'b0), // input
    .drp_do(), // output [15:0]
    .drp_rdy(), // output
    .drp_we(1'b0) // input
);

/*
 * qsfp8
 */
cmac_pad #(
    .DATA_WIDTH(AXIS_ETH_DATA_WIDTH),
    .KEEP_WIDTH(AXIS_ETH_KEEP_WIDTH),
    .USER_WIDTH(1)
)
qsfp8_cmac_pad_inst (
    .clk(qsfp8_tx_clk_int),
    .rst(qsfp8_tx_rst_int),

    .s_axis_tdata(qsfp8_tx_axis_tdata_int),
    .s_axis_tkeep(qsfp8_tx_axis_tkeep_int),
    .s_axis_tvalid(qsfp8_tx_axis_tvalid_int),
    .s_axis_tready(qsfp8_tx_axis_tready_int),
    .s_axis_tlast(qsfp8_tx_axis_tlast_int),
    .s_axis_tuser(qsfp8_tx_axis_tuser_int),

    .m_axis_tdata(qsfp8_mac_tx_axis_tdata),
    .m_axis_tkeep(qsfp8_mac_tx_axis_tkeep),
    .m_axis_tvalid(qsfp8_mac_tx_axis_tvalid),
    .m_axis_tready(qsfp8_mac_tx_axis_tready),
    .m_axis_tlast(qsfp8_mac_tx_axis_tlast),
    .m_axis_tuser(qsfp8_mac_tx_axis_tuser)
);

cmac_usplus_7
qsfp8_cmac_inst (
    .gt_rxp_in({qsfp8_rx4_p, qsfp8_rx3_p, qsfp8_rx2_p, qsfp8_rx1_p}), // input
    .gt_rxn_in({qsfp8_rx4_n, qsfp8_rx3_n, qsfp8_rx2_n, qsfp8_rx1_n}), // input
    .gt_txp_out({qsfp8_tx4_p, qsfp8_tx3_p, qsfp8_tx2_p, qsfp8_tx1_p}), // output
    .gt_txn_out({qsfp8_tx4_n, qsfp8_tx3_n, qsfp8_tx2_n, qsfp8_tx1_n}), // output
    .gt_txusrclk2(qsfp8_txuserclk2), // output
    .gt_loopback_in(12'd0), // input [11:0]
    .gt_rxrecclkout(), // output [3:0]
    .gt_powergoodout(), // output [3:0]
    .gt_ref_clk_out(), // output
    .gtwiz_reset_tx_datapath(1'b0), // input
    .gtwiz_reset_rx_datapath(1'b0), // input

    .gt_ref_clk_p(qsfp8_mgt_refclk_0_p), // input
    .gt_ref_clk_n(qsfp8_mgt_refclk_0_n), // input

    .init_clk(clk_125mhz), // input
    .sys_reset(clk_125mhz_rst_qsfp), // input

    .rx_axis_tvalid(qsfp8_rx_axis_tvalid_int), // output
    .rx_axis_tdata(qsfp8_rx_axis_tdata_int), // output [511:0]
    .rx_axis_tlast(qsfp8_rx_axis_tlast_int), // output
    .rx_axis_tkeep(qsfp8_rx_axis_tkeep_int), // output [63:0]
    .rx_axis_tuser(qsfp8_rx_axis_tuser_int), // output

    .rx_otn_bip8_0(), // output [7:0]
    .rx_otn_bip8_1(), // output [7:0]
    .rx_otn_bip8_2(), // output [7:0]
    .rx_otn_bip8_3(), // output [7:0]
    .rx_otn_bip8_4(), // output [7:0]
    .rx_otn_data_0(), // output [65:0]
    .rx_otn_data_1(), // output [65:0]
    .rx_otn_data_2(), // output [65:0]
    .rx_otn_data_3(), // output [65:0]
    .rx_otn_data_4(), // output [65:0]
    .rx_otn_ena(), // output
    .rx_otn_lane0(), // output
    .rx_otn_vlmarker(), // output
    .rx_preambleout(), // output [55:0]
    .usr_rx_reset(qsfp8_rx_rst_int), // output
    .gt_rxusrclk2(), // output

    .stat_rx_aligned(vector_signals[14]), // output
    .stat_rx_aligned_err(), // output
    .stat_rx_bad_code(), // output [2:0]
    .stat_rx_bad_fcs(), // output [2:0]
    .stat_rx_bad_preamble(), // output
    .stat_rx_bad_sfd(), // output
    .stat_rx_bip_err_0(), // output
    .stat_rx_bip_err_1(), // output
    .stat_rx_bip_err_10(), // output
    .stat_rx_bip_err_11(), // output
    .stat_rx_bip_err_12(), // output
    .stat_rx_bip_err_13(), // output
    .stat_rx_bip_err_14(), // output
    .stat_rx_bip_err_15(), // output
    .stat_rx_bip_err_16(), // output
    .stat_rx_bip_err_17(), // output
    .stat_rx_bip_err_18(), // output
    .stat_rx_bip_err_19(), // output
    .stat_rx_bip_err_2(), // output
    .stat_rx_bip_err_3(), // output
    .stat_rx_bip_err_4(), // output
    .stat_rx_bip_err_5(), // output
    .stat_rx_bip_err_6(), // output
    .stat_rx_bip_err_7(), // output
    .stat_rx_bip_err_8(), // output
    .stat_rx_bip_err_9(), // output
    .stat_rx_block_lock(), // output [19:0]
    .stat_rx_broadcast(), // output
    .stat_rx_fragment(), // output [2:0]
    .stat_rx_framing_err_0(), // output [1:0]
    .stat_rx_framing_err_1(), // output [1:0]
    .stat_rx_framing_err_10(), // output [1:0]
    .stat_rx_framing_err_11(), // output [1:0]
    .stat_rx_framing_err_12(), // output [1:0]
    .stat_rx_framing_err_13(), // output [1:0]
    .stat_rx_framing_err_14(), // output [1:0]
    .stat_rx_framing_err_15(), // output [1:0]
    .stat_rx_framing_err_16(), // output [1:0]
    .stat_rx_framing_err_17(), // output [1:0]
    .stat_rx_framing_err_18(), // output [1:0]
    .stat_rx_framing_err_19(), // output [1:0]
    .stat_rx_framing_err_2(), // output [1:0]
    .stat_rx_framing_err_3(), // output [1:0]
    .stat_rx_framing_err_4(), // output [1:0]
    .stat_rx_framing_err_5(), // output [1:0]
    .stat_rx_framing_err_6(), // output [1:0]
    .stat_rx_framing_err_7(), // output [1:0]
    .stat_rx_framing_err_8(), // output [1:0]
    .stat_rx_framing_err_9(), // output [1:0]
    .stat_rx_framing_err_valid_0(), // output
    .stat_rx_framing_err_valid_1(), // output
    .stat_rx_framing_err_valid_10(), // output
    .stat_rx_framing_err_valid_11(), // output
    .stat_rx_framing_err_valid_12(), // output
    .stat_rx_framing_err_valid_13(), // output
    .stat_rx_framing_err_valid_14(), // output
    .stat_rx_framing_err_valid_15(), // output
    .stat_rx_framing_err_valid_16(), // output
    .stat_rx_framing_err_valid_17(), // output
    .stat_rx_framing_err_valid_18(), // output
    .stat_rx_framing_err_valid_19(), // output
    .stat_rx_framing_err_valid_2(), // output
    .stat_rx_framing_err_valid_3(), // output
    .stat_rx_framing_err_valid_4(), // output
    .stat_rx_framing_err_valid_5(), // output
    .stat_rx_framing_err_valid_6(), // output
    .stat_rx_framing_err_valid_7(), // output
    .stat_rx_framing_err_valid_8(), // output
    .stat_rx_framing_err_valid_9(), // output
    .stat_rx_got_signal_os(), // output
    .stat_rx_hi_ber(), // output
    .stat_rx_inrangeerr(), // output
    .stat_rx_internal_local_fault(), // output
    .stat_rx_jabber(), // output
    .stat_rx_local_fault(), // output
    .stat_rx_mf_err(), // output [19:0]
    .stat_rx_mf_len_err(), // output [19:0]
    .stat_rx_mf_repeat_err(), // output [19:0]
    .stat_rx_misaligned(), // output
    .stat_rx_multicast(), // output
    .stat_rx_oversize(), // output
    .stat_rx_packet_1024_1518_bytes(), // output
    .stat_rx_packet_128_255_bytes(), // output
    .stat_rx_packet_1519_1522_bytes(), // output
    .stat_rx_packet_1523_1548_bytes(), // output
    .stat_rx_packet_1549_2047_bytes(), // output
    .stat_rx_packet_2048_4095_bytes(), // output
    .stat_rx_packet_256_511_bytes(), // output
    .stat_rx_packet_4096_8191_bytes(), // output
    .stat_rx_packet_512_1023_bytes(), // output
    .stat_rx_packet_64_bytes(), // output
    .stat_rx_packet_65_127_bytes(), // output
    .stat_rx_packet_8192_9215_bytes(), // output
    .stat_rx_packet_bad_fcs(), // output
    .stat_rx_packet_large(), // output
    .stat_rx_packet_small(), // output [2:0]

    .ctl_rx_enable(1'b1), // input
    .ctl_rx_force_resync(1'b0), // input
    .ctl_rx_test_pattern(1'b0), // input
    .ctl_rsfec_ieee_error_indication_mode(1'b0), // input
    .ctl_rx_rsfec_enable(1'b1), // input
    .ctl_rx_rsfec_enable_correction(1'b1), // input
    .ctl_rx_rsfec_enable_indication(1'b1), // input
    .core_rx_reset(1'b0), // input
    .rx_clk(qsfp8_rx_clk_int), // input

    .stat_rx_received_local_fault(), // output
    .stat_rx_remote_fault(), // output
    .stat_rx_status(vector_signals[15]), // output
    .stat_rx_stomped_fcs(), // output [2:0]
    .stat_rx_synced(), // output [19:0]
    .stat_rx_synced_err(), // output [19:0]
    .stat_rx_test_pattern_mismatch(), // output [2:0]
    .stat_rx_toolong(), // output
    .stat_rx_total_bytes(), // output [6:0]
    .stat_rx_total_good_bytes(), // output [13:0]
    .stat_rx_total_good_packets(), // output
    .stat_rx_total_packets(), // output [2:0]
    .stat_rx_truncated(), // output
    .stat_rx_undersize(), // output [2:0]
    .stat_rx_unicast(), // output
    .stat_rx_vlan(), // output
    .stat_rx_pcsl_demuxed(), // output [19:0]
    .stat_rx_pcsl_number_0(), // output [4:0]
    .stat_rx_pcsl_number_1(), // output [4:0]
    .stat_rx_pcsl_number_10(), // output [4:0]
    .stat_rx_pcsl_number_11(), // output [4:0]
    .stat_rx_pcsl_number_12(), // output [4:0]
    .stat_rx_pcsl_number_13(), // output [4:0]
    .stat_rx_pcsl_number_14(), // output [4:0]
    .stat_rx_pcsl_number_15(), // output [4:0]
    .stat_rx_pcsl_number_16(), // output [4:0]
    .stat_rx_pcsl_number_17(), // output [4:0]
    .stat_rx_pcsl_number_18(), // output [4:0]
    .stat_rx_pcsl_number_19(), // output [4:0]
    .stat_rx_pcsl_number_2(), // output [4:0]
    .stat_rx_pcsl_number_3(), // output [4:0]
    .stat_rx_pcsl_number_4(), // output [4:0]
    .stat_rx_pcsl_number_5(), // output [4:0]
    .stat_rx_pcsl_number_6(), // output [4:0]
    .stat_rx_pcsl_number_7(), // output [4:0]
    .stat_rx_pcsl_number_8(), // output [4:0]
    .stat_rx_pcsl_number_9(), // output [4:0]
    .stat_rx_rsfec_am_lock0(), // output
    .stat_rx_rsfec_am_lock1(), // output
    .stat_rx_rsfec_am_lock2(), // output
    .stat_rx_rsfec_am_lock3(), // output
    .stat_rx_rsfec_corrected_cw_inc(), // output
    .stat_rx_rsfec_cw_inc(), // output
    .stat_rx_rsfec_err_count0_inc(), // output [2:0]
    .stat_rx_rsfec_err_count1_inc(), // output [2:0]
    .stat_rx_rsfec_err_count2_inc(), // output [2:0]
    .stat_rx_rsfec_err_count3_inc(), // output [2:0]
    .stat_rx_rsfec_hi_ser(), // output
    .stat_rx_rsfec_lane_alignment_status(), // output
    .stat_rx_rsfec_lane_fill_0(), // output [13:0]
    .stat_rx_rsfec_lane_fill_1(), // output [13:0]
    .stat_rx_rsfec_lane_fill_2(), // output [13:0]
    .stat_rx_rsfec_lane_fill_3(), // output [13:0]
    .stat_rx_rsfec_lane_mapping(), // output [7:0]
    .stat_rx_rsfec_uncorrected_cw_inc(), // output

    .stat_tx_bad_fcs(), // output
    .stat_tx_broadcast(), // output
    .stat_tx_frame_error(), // output
    .stat_tx_local_fault(), // output
    .stat_tx_multicast(), // output
    .stat_tx_packet_1024_1518_bytes(), // output
    .stat_tx_packet_128_255_bytes(), // output
    .stat_tx_packet_1519_1522_bytes(), // output
    .stat_tx_packet_1523_1548_bytes(), // output
    .stat_tx_packet_1549_2047_bytes(), // output
    .stat_tx_packet_2048_4095_bytes(), // output
    .stat_tx_packet_256_511_bytes(), // output
    .stat_tx_packet_4096_8191_bytes(), // output
    .stat_tx_packet_512_1023_bytes(), // output
    .stat_tx_packet_64_bytes(), // output
    .stat_tx_packet_65_127_bytes(), // output
    .stat_tx_packet_8192_9215_bytes(), // output
    .stat_tx_packet_large(), // output
    .stat_tx_packet_small(), // output
    .stat_tx_total_bytes(), // output [5:0]
    .stat_tx_total_good_bytes(), // output [13:0]
    .stat_tx_total_good_packets(), // output
    .stat_tx_total_packets(), // output
    .stat_tx_unicast(), // output
    .stat_tx_vlan(), // output

    .ctl_tx_enable(1'b1), // input
    .ctl_tx_test_pattern(1'b0), // input
    .ctl_tx_rsfec_enable(1'b1), // input
    .ctl_tx_send_idle(1'b0), // input
    .ctl_tx_send_rfi(1'b0), // input
    .ctl_tx_send_lfi(1'b0), // input
    .core_tx_reset(1'b0), // input

    .tx_axis_tready(qsfp8_mac_tx_axis_tready), // output
    .tx_axis_tvalid(qsfp8_mac_tx_axis_tvalid), // input
    .tx_axis_tdata(qsfp8_mac_tx_axis_tdata), // input [511:0]
    .tx_axis_tlast(qsfp8_mac_tx_axis_tlast), // input
    .tx_axis_tkeep(qsfp8_mac_tx_axis_tkeep), // input [63:0]
    .tx_axis_tuser(qsfp8_mac_tx_axis_tuser), // input

    .tx_ovfout(), // output
    .tx_unfout(), // output
    .tx_preamblein(56'd0), // input [55:0]
    .usr_tx_reset(qsfp8_tx_rst_int), // output

    .core_drp_reset(1'b0), // input
    .drp_clk(1'b0), // input
    .drp_addr(10'd0), // input [9:0]
    .drp_di(16'd0), // input [15:0]
    .drp_en(1'b0), // input
    .drp_do(), // output [15:0]
    .drp_rdy(), // output
    .drp_we(1'b0) // input
);


supernic_core core_inst (
    /*
     * Clock: 250 MHz
     * Synchronous reset
     */
    .clk_250mhz(clk_250mhz),
    .rst_250mhz(clk_250mhz_rst),

    .vector_signals(vector_signals),

    /*
     * Ethernet: QSFP28
     */
    .qsfp1_tx_clk(qsfp1_tx_clk_int),
    .qsfp1_tx_rst(qsfp1_tx_rst_int),
    .qsfp1_tx_axis_tdata(qsfp1_tx_axis_tdata_int),
    .qsfp1_tx_axis_tkeep(qsfp1_tx_axis_tkeep_int),
    .qsfp1_tx_axis_tvalid(qsfp1_tx_axis_tvalid_int),
    .qsfp1_tx_axis_tready(qsfp1_tx_axis_tready_int),
    .qsfp1_tx_axis_tlast(qsfp1_tx_axis_tlast_int),
    .qsfp1_tx_axis_tuser(qsfp1_tx_axis_tuser_int),

    .qsfp1_rx_clk(qsfp1_rx_clk_int),
    .qsfp1_rx_rst(qsfp1_rx_rst_int),
    .qsfp1_rx_axis_tdata(qsfp1_rx_axis_tdata_int),
    .qsfp1_rx_axis_tkeep(qsfp1_rx_axis_tkeep_int),
    .qsfp1_rx_axis_tvalid(qsfp1_rx_axis_tvalid_int),
    .qsfp1_rx_axis_tlast(qsfp1_rx_axis_tlast_int),
    .qsfp1_rx_axis_tuser(qsfp1_rx_axis_tuser_int),

    /*
     * Ethernet: QSFP28
     */
    .qsfp2_tx_clk(qsfp2_tx_clk_int),
    .qsfp2_tx_rst(qsfp2_tx_rst_int),
    .qsfp2_tx_axis_tdata(qsfp2_tx_axis_tdata_int),
    .qsfp2_tx_axis_tkeep(qsfp2_tx_axis_tkeep_int),
    .qsfp2_tx_axis_tvalid(qsfp2_tx_axis_tvalid_int),
    .qsfp2_tx_axis_tready(qsfp2_tx_axis_tready_int),
    .qsfp2_tx_axis_tlast(qsfp2_tx_axis_tlast_int),
    .qsfp2_tx_axis_tuser(qsfp2_tx_axis_tuser_int),

    .qsfp2_rx_clk(qsfp2_rx_clk_int),
    .qsfp2_rx_rst(qsfp2_rx_rst_int),
    .qsfp2_rx_axis_tdata(qsfp2_rx_axis_tdata_int),
    .qsfp2_rx_axis_tkeep(qsfp2_rx_axis_tkeep_int),
    .qsfp2_rx_axis_tvalid(qsfp2_rx_axis_tvalid_int),
    .qsfp2_rx_axis_tlast(qsfp2_rx_axis_tlast_int),
    .qsfp2_rx_axis_tuser(qsfp2_rx_axis_tuser_int),

    /*
     * Ethernet: QSFP28
     */
    .qsfp3_tx_clk(qsfp3_tx_clk_int),
    .qsfp3_tx_rst(qsfp3_tx_rst_int),
    .qsfp3_tx_axis_tdata(qsfp3_tx_axis_tdata_int),
    .qsfp3_tx_axis_tkeep(qsfp3_tx_axis_tkeep_int),
    .qsfp3_tx_axis_tvalid(qsfp3_tx_axis_tvalid_int),
    .qsfp3_tx_axis_tready(qsfp3_tx_axis_tready_int),
    .qsfp3_tx_axis_tlast(qsfp3_tx_axis_tlast_int),
    .qsfp3_tx_axis_tuser(qsfp3_tx_axis_tuser_int),

    .qsfp3_rx_clk(qsfp3_rx_clk_int),
    .qsfp3_rx_rst(qsfp3_rx_rst_int),
    .qsfp3_rx_axis_tdata(qsfp3_rx_axis_tdata_int),
    .qsfp3_rx_axis_tkeep(qsfp3_rx_axis_tkeep_int),
    .qsfp3_rx_axis_tvalid(qsfp3_rx_axis_tvalid_int),
    .qsfp3_rx_axis_tlast(qsfp3_rx_axis_tlast_int),
    .qsfp3_rx_axis_tuser(qsfp3_rx_axis_tuser_int),

    /*
     * Ethernet: QSFP28
     */
    .qsfp4_tx_clk(qsfp4_tx_clk_int),
    .qsfp4_tx_rst(qsfp4_tx_rst_int),
    .qsfp4_tx_axis_tdata(qsfp4_tx_axis_tdata_int),
    .qsfp4_tx_axis_tkeep(qsfp4_tx_axis_tkeep_int),
    .qsfp4_tx_axis_tvalid(qsfp4_tx_axis_tvalid_int),
    .qsfp4_tx_axis_tready(qsfp4_tx_axis_tready_int),
    .qsfp4_tx_axis_tlast(qsfp4_tx_axis_tlast_int),
    .qsfp4_tx_axis_tuser(qsfp4_tx_axis_tuser_int),

    .qsfp4_rx_clk(qsfp4_rx_clk_int),
    .qsfp4_rx_rst(qsfp4_rx_rst_int),
    .qsfp4_rx_axis_tdata(qsfp4_rx_axis_tdata_int),
    .qsfp4_rx_axis_tkeep(qsfp4_rx_axis_tkeep_int),
    .qsfp4_rx_axis_tvalid(qsfp4_rx_axis_tvalid_int),
    .qsfp4_rx_axis_tlast(qsfp4_rx_axis_tlast_int),
    .qsfp4_rx_axis_tuser(qsfp4_rx_axis_tuser_int)
);

supernic_core2 core_inst2 (
    /*
     * Clock: 250 MHz
     * Synchronous reset
     */
    .clk_250mhz(clk_250mhz),
    .rst_250mhz(clk_250mhz_rst),

    .clk_125mhz_rst_qsfp(clk_125mhz_rst_qsfp),
    .vector_signals(),

    /*
     * Ethernet: QSFP28
     */
    .qsfp1_tx_clk(qsfp5_tx_clk_int),
    .qsfp1_tx_rst(qsfp5_tx_rst_int),
    .qsfp1_tx_axis_tdata(qsfp5_tx_axis_tdata_int),
    .qsfp1_tx_axis_tkeep(qsfp5_tx_axis_tkeep_int),
    .qsfp1_tx_axis_tvalid(qsfp5_tx_axis_tvalid_int),
    .qsfp1_tx_axis_tready(qsfp5_tx_axis_tready_int),
    .qsfp1_tx_axis_tlast(qsfp5_tx_axis_tlast_int),
    .qsfp1_tx_axis_tuser(qsfp5_tx_axis_tuser_int),

    .qsfp1_rx_clk(qsfp5_rx_clk_int),
    .qsfp1_rx_rst(qsfp5_rx_rst_int),
    .qsfp1_rx_axis_tdata(qsfp5_rx_axis_tdata_int),
    .qsfp1_rx_axis_tkeep(qsfp5_rx_axis_tkeep_int),
    .qsfp1_rx_axis_tvalid(qsfp5_rx_axis_tvalid_int),
    .qsfp1_rx_axis_tlast(qsfp5_rx_axis_tlast_int),
    .qsfp1_rx_axis_tuser(qsfp5_rx_axis_tuser_int),

    /*
     * Ethernet: QSFP28
     */
    .qsfp2_tx_clk(qsfp6_tx_clk_int),
    .qsfp2_tx_rst(qsfp6_tx_rst_int),
    .qsfp2_tx_axis_tdata(qsfp6_tx_axis_tdata_int),
    .qsfp2_tx_axis_tkeep(qsfp6_tx_axis_tkeep_int),
    .qsfp2_tx_axis_tvalid(qsfp6_tx_axis_tvalid_int),
    .qsfp2_tx_axis_tready(qsfp6_tx_axis_tready_int),
    .qsfp2_tx_axis_tlast(qsfp6_tx_axis_tlast_int),
    .qsfp2_tx_axis_tuser(qsfp6_tx_axis_tuser_int),

    .qsfp2_rx_clk(qsfp6_rx_clk_int),
    .qsfp2_rx_rst(qsfp6_rx_rst_int),
    .qsfp2_rx_axis_tdata(qsfp6_rx_axis_tdata_int),
    .qsfp2_rx_axis_tkeep(qsfp6_rx_axis_tkeep_int),
    .qsfp2_rx_axis_tvalid(qsfp6_rx_axis_tvalid_int),
    .qsfp2_rx_axis_tlast(qsfp6_rx_axis_tlast_int),
    .qsfp2_rx_axis_tuser(qsfp6_rx_axis_tuser_int),

    /*
     * Ethernet: QSFP28
     */
    .qsfp3_tx_clk(qsfp7_tx_clk_int),
    .qsfp3_tx_rst(qsfp7_tx_rst_int),
    .qsfp3_tx_axis_tdata(qsfp7_tx_axis_tdata_int),
    .qsfp3_tx_axis_tkeep(qsfp7_tx_axis_tkeep_int),
    .qsfp3_tx_axis_tvalid(qsfp7_tx_axis_tvalid_int),
    .qsfp3_tx_axis_tready(qsfp7_tx_axis_tready_int),
    .qsfp3_tx_axis_tlast(qsfp7_tx_axis_tlast_int),
    .qsfp3_tx_axis_tuser(qsfp7_tx_axis_tuser_int),

    .qsfp3_rx_clk(qsfp7_rx_clk_int),
    .qsfp3_rx_rst(qsfp7_rx_rst_int),
    .qsfp3_rx_axis_tdata(qsfp7_rx_axis_tdata_int),
    .qsfp3_rx_axis_tkeep(qsfp7_rx_axis_tkeep_int),
    .qsfp3_rx_axis_tvalid(qsfp7_rx_axis_tvalid_int),
    .qsfp3_rx_axis_tlast(qsfp7_rx_axis_tlast_int),
    .qsfp3_rx_axis_tuser(qsfp7_rx_axis_tuser_int),

    /*
     * Ethernet: QSFP28
     */
    .qsfp4_tx_clk(qsfp8_tx_clk_int),
    .qsfp4_tx_rst(qsfp8_tx_rst_int),
    .qsfp4_tx_axis_tdata(qsfp8_tx_axis_tdata_int),
    .qsfp4_tx_axis_tkeep(qsfp8_tx_axis_tkeep_int),
    .qsfp4_tx_axis_tvalid(qsfp8_tx_axis_tvalid_int),
    .qsfp4_tx_axis_tready(qsfp8_tx_axis_tready_int),
    .qsfp4_tx_axis_tlast(qsfp8_tx_axis_tlast_int),
    .qsfp4_tx_axis_tuser(qsfp8_tx_axis_tuser_int),

    .qsfp4_rx_clk(qsfp8_rx_clk_int),
    .qsfp4_rx_rst(qsfp8_rx_rst_int),
    .qsfp4_rx_axis_tdata(qsfp8_rx_axis_tdata_int),
    .qsfp4_rx_axis_tkeep(qsfp8_rx_axis_tkeep_int),
    .qsfp4_rx_axis_tvalid(qsfp8_rx_axis_tvalid_int),
    .qsfp4_rx_axis_tlast(qsfp8_rx_axis_tlast_int),
    .qsfp4_rx_axis_tuser(qsfp8_rx_axis_tuser_int)
);
endmodule
