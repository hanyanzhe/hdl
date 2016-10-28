# ip

source ../scripts/adi_env.tcl
source $ad_hdl_dir/library/scripts/adi_ip.tcl

adi_ip_create axi_ad5766
adi_ip_files axi_ad5766 [list \
    "$ad_hdl_dir/library/common/up_xfer_cntrl.v" \
    "$ad_hdl_dir/library/common/up_xfer_status.v" \
    "$ad_hdl_dir/library/common/sync_bits.v" \
    "$ad_hdl_dir/library/common/ad_rst.v" \
    "$ad_hdl_dir/library/common/up_dac_common.v" \
    "$ad_hdl_dir/library/common/up_clock_mon.v" \
    "$ad_hdl_dir/library/common/up_axi.v" \
    "$ad_hdl_dir/library/common/util_pulse_gen.v" \
    "up_ad5766_sequencer.v" \
    "axi_ad5766.v" ]

adi_ip_properties axi_ad5766

adi_add_bus "spi_engine_ctrl" "master" \
	"analog.com:interface:spi_engine_ctrl_rtl:1.0" \
	"analog.com:interface:spi_engine_ctrl:1.0" \
	{
		{"cmd_ready" "CMD_READY"} \
		{"cmd_valid" "CMD_VALID"} \
		{"cmd_data" "CMD_DATA"} \
		{"sdo_data_ready" "SDO_READY"} \
		{"sdo_data_valid" "SDO_VALID"} \
		{"sdo_data" "SDO_DATA"} \
		{"sdi_data_ready" "SDI_READY"} \
		{"sdi_data_valid" "SDI_VALID"} \
		{"sdi_data" "SDI_DATA"} \
		{"sync_ready" "SYNC_READY"} \
		{"sync_valid" "SYNC_VALID"} \
		{"sync_data" "SYNC_DATA"} \
	}

adi_add_bus "spi_engine_offload_ctrl" "slave" \
	"analog.com:interface:spi_engine_offload_ctrl_rtl:1.0" \
	"analog.com:interface:spi_engine_offload_ctrl:1.0" \
	{ \
		{ "ctrl_cmd_wr_en" "CMD_WR_EN"} \
		{ "ctrl_cmd_wr_data" "CMD_WR_DATA"} \
		{ "ctrl_enable" "ENABLE"} \
		{ "ctrl_enabled" "ENABLED"} \
		{ "ctrl_mem_reset" "MEM_RESET"} \
	}

adi_add_bus "dma_fifo_tx" "master" \
	"analog.com:interface:fifo_rd_rtl:1.1" \
	"analog.com:interface:fifo_rd:1.1" \
	{ \
		{ "dma_data" "DATA"} \
		{ "dma_valid" "ENABLE"} \
		{ "dma_enable" "VALID"} \
		{ "dma_underflow" "UNDERFLOW"} \
		{ "dma_xfer_req" "XFER_REQ"} \
	}


adi_add_bus_clock "ctrl_clk" "spi_engine_offload_ctrl"
adi_add_bus_clock "spi_clk" "spi_engine_ctrl" "spi_resetn"
adi_add_bus_clock "dma_clk" "dma_fifo_tx"

ipx::save_core [ipx::current_core]

