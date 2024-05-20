interface spi_wrapper_if(input clk);
    /*
   input MOSI,clk,rst_n,SS_n;
    output MISO;
*/
logic MOSI;
logic SS_n;
logic rst_n;
logic MISO;

endinterface : spi_wrapper_if