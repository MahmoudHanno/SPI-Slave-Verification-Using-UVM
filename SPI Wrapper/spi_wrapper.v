module spi_wrapper(MISO,MOSI,SS_n,clk,rst_n);
input MOSI,clk,rst_n,SS_n;
output MISO;


wire [9:0] W1;
wire W2,W3;
wire [7:0] W4;
project m1(.MOSI(MOSI),.MISO(MISO),.clk(clk),.rst_n(rst_n),.SS_n(SS_n),.rx_data(W1),.rx_valid(W2),.tx_data(W4),.tx_valid(W3));

spi_ram m2(.clk(clk),.rst_n(rst_n),.din(W1),.rx_valid(W2),.dout(W4),.tx_valid(W3));


endmodule

