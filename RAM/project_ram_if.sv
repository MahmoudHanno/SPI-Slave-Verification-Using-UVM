interface project_ram_if(input clk);
    /*
    module spi_ram(din,rx_valid,tx_valid,dout,clk,rst_n);   
input [9:0] din;
input rx_valid;
input clk,rst_n;
output reg tx_valid;
output reg[7:0] dout;
*/
logic [9:0] din;
logic rx_valid;
logic rst_n;
logic tx_valid;
logic [7:0] dout;
endinterface : project_ram_if