module project(MOSI,MISO,SS_n,clk,rst_n,rx_data,rx_valid,tx_data,tx_valid);
parameter IDLE=3'b000;
parameter CHK_CMD=3'b001;
parameter WRITE=3'b010;
parameter READ_DATA=3'b011;
parameter READ_ADD=3'b100;


input MOSI,SS_n,clk,rst_n,tx_valid;
input[7:0] tx_data;
output reg [9:0] rx_data;
output reg rx_valid;
output reg MISO;

reg flag;
reg [2:0] cs,ns;
reg[3:0] i,k;
always@(posedge clk or negedge rst_n)
begin
if(rst_n==0)
cs<=IDLE;
else cs<=ns;
end
always@(cs,SS_n,MOSI)
begin
case(cs)
IDLE: begin
if(SS_n==0)
ns<=CHK_CMD;
else
ns<=IDLE;
end
CHK_CMD: 
begin
if(SS_n==1)
ns<=IDLE;
else if(SS_n==0 && MOSI==0)
ns<=WRITE;
else if(SS_n==0 && MOSI==1 &&flag==1)
begin
ns<=READ_DATA;
end
else if(SS_n==0 && MOSI==1)
begin
ns<=READ_ADD;
end
end
WRITE: 
begin
if(SS_n==0)
ns<=WRITE;
else
ns<=IDLE;
end
READ_ADD:
begin
if(SS_n==0)
ns<=READ_ADD;
else
ns<=IDLE;
end
READ_DATA:
begin
if(SS_n==0)
ns<=READ_DATA;
else
ns<=IDLE;
end
endcase
end
always@(posedge clk)
begin
case (cs)
IDLE: rx_valid=0;
CHK_CMD: begin 
i<=9;
k<=0;
end
WRITE:begin
if(i==0) begin
rx_data[i]<=MOSI;
rx_valid<=1;
end
else begin
rx_data[i]<=MOSI;
i<=i-1;
end
end
READ_ADD:begin
if(i==0) begin
rx_data[i]<=MOSI;
rx_valid<=1;
flag<=1;
end
else begin
rx_data[i]<=MOSI;
i<=i-1;
end
end
READ_DATA: begin
if(i==0) begin
rx_valid<=1;
rx_data[i]<=MOSI;
end
else begin
rx_data[i]<=MOSI;
i<=i-1;
end
if(tx_valid==1) begin
   if(k==7) begin
   MISO<=tx_data[k];
   flag<=0;
   end
   else begin
   MISO<=tx_data[k];
   k=k+1;
   end
end
end
endcase
end


endmodule


