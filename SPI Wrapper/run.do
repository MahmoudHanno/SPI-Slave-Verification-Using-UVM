vlib work
vlog spi_wrapper_write_data_seq_pkg.sv spi_wrapper.v spi_wrapper_write_addr_seq_pkg.sv spi_wrapper_top.sv spi_wrapper_seq_item_pkg.sv spi_wrapper_sqr.sv spi_wrapper_test.sv spi_wrapper_scoreboard.sv spi_wrapper_rst_seq_pkg.sv spi_wrapper_read_data_seq_pkg.sv spi_wrapper_read_addr_seq_pkg.sv spi_wrapper_monitor.sv spi_wrapper_G_if.sv spi_wrapper_if.sv spi_wrapper_env.sv spi_wrapper_coverage.sv spi_wrapper_driver.sv spi_wrapper_config.sv spi_wrapper_agent.sv
vsim -voptargs=+acc work.top -classdebug -uvmcontrol=all -cover
add wave /top/spiif/*
add wave /top/spiif_G/*
coverage save SPItb.ucdb -onexit
run -all
vcover report SPItb.ucdb -details -annotate -all