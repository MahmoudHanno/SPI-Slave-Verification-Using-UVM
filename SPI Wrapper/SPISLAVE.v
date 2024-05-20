module SPISLAVE(MOSI,MISO,SS_n,clk,rst_n);
//rx_data=din tx_data=dout
input MOSI,SS_n,clk,rst_n;
output reg MISO;
reg [9:0] rx_data;
reg [7:0] tx_data;
reg rx_valid,tx_valid,flag; //flag to diffrentiate betweeen read address and read data
reg [7:0] mem[255:0];
reg [2:0] cs,ns;
reg [3:0] count,count2; //internal signal for the MOSI and MISO count
reg [7:0] wr_add,rd_add;  //internal signal for the address to be written/read

parameter idle=0,chk_cmd=1,write=2,read_addr=3,read_data=4;

always@(cs or SS_n or MOSI) begin
	
	case(cs)

	idle: begin
		
		if(SS_n) begin
			ns=idle;
		end
		else begin
			ns=chk_cmd;
		end

	end

	chk_cmd: begin
		if(SS_n==0&&MOSI==0 && !flag) begin
			ns=write;
		end
		else if(SS_n==0&&MOSI==1&& !flag) begin
			ns=read_addr;
		end
		else if(SS_n==0&&MOSI==1&&flag) begin
			ns=read_data;
		end
		else if(SS_n==1)
			ns=idle;
		else begin
			ns=chk_cmd;
		end
	end

	write: begin

		if(SS_n==1) begin
			ns=idle;
		end
		else begin
			ns=write;
		end


	end

	read_addr: begin

		if(SS_n==1) begin
			ns=idle;
		end
		else begin
			ns=read_addr;
		end
	end

	read_data: begin

		if(SS_n==1) begin
			ns=idle;
		end
		else begin
			ns=read_data;
		end
	end

	default: ns=idle;
	endcase


end


always@(posedge clk or negedge rst_n) begin
	
	if(!rst_n) begin
		cs<=idle;
		count<=0;
		count2<=7;
		rx_valid<=0;
		tx_valid<=0;
		flag<=0;
		rx_data<=0;
		tx_data<=0;
	end
	else begin
		cs<=ns;
		
	end
end




always@(posedge clk) begin
	case(cs)
	write: begin
		if(count<10)
			rx_data<={rx_data[8:0],MOSI}; //takes the MOSI and shifts register if count is less than 10
			count<=count+1;
			if(count==9) begin
			rx_valid<=1; //rx valid to inform memory that it will receive data or the write addr to receive address
		end
	
		if(rx_valid==1)begin
			if(rx_data[8]==0&&rx_data[9]==0)begin
				wr_add<=rx_data[7:0]; //stores the address in internal signal if most significant bits are 00

			end
			else if(rx_data[8]==1 && rx_data[9]==0)begin
				mem[wr_add]<=rx_data[7:0]; //stores the data in memory address previously saved in wr_add if most significant bits are 01
			end
			count<=0; //resets the count and rx valid
			rx_valid<=0;
		end
	end
	read_addr:begin
			if(count<10) 
			rx_data<={rx_data[8:0],MOSI}; //takes the MOSI and shifts register if count is less than 10
			count<=count+1;
			if(count==9) begin
			rx_valid<=1; //rx valid to inform rd_add that it will receive address
			end
	
			if(rx_valid==1)begin
			if(rx_data[8]==0&&rx_data[9]==1)begin //stores the address in internal signal if most significant bits are 10
				rd_add<=rx_data[7:0];
				end
			count<=0;  //resets the count and rx valid
			rx_valid<=0;
			flag<=1; //flag==1 to go to read memory not address in the next case
		end

	end

	read_data:begin
		if(count<10) begin  
		rx_data<={rx_data[8:0],MOSI}; //takes the MOSI and shifts register if count is less than 10
		end
		count<=count+1;
		if(count==9)begin
			tx_valid<=1; //tx valid to inform the slave that it will load data out on MISO from tx data
			tx_data<=mem[rd_add]; 
			end
		if(count2>=0 && tx_valid)begin
			MISO<=tx_data[count2]; //MISO takes data from tx data
			
			count2<=count2-1;
			if(count2==0)begin
				tx_valid<=0;
				tx_data<=0;
				count2<=7;
				flag<=0; //flag=0 to go in the next time to read address not read data
				count<=0;
				rx_data<=0;
			end
		end
		
	end

		
	endcase
end


endmodule