// Code your design here
module fifo(data_in,wr_clk,rd_clk,full,empty,reset,wr_en,rd_en,data_out);
  input [7:0]data_in;
  input wr_clk,rd_clk,reset,wr_en,rd_en;
  output reg full,empty;
  output reg[7:0]data_out;
  
  reg [2:0]rd_ptr,wr_ptr;
  
  reg [7:0]ram[0:7];
  
  always@(posedge wr_clk)//writing the data
    begin
      if(reset)
        wr_ptr<=0;
  	  else
        if(wr_en && !full)
          begin
            ram[wr_ptr]<=data_in;
  		    wr_ptr<=wr_ptr+1;
          end
    end
  
  always@(posedge rd_clk)//reading the data
    begin
      if(reset)
        rd_ptr<=0;
  	  else
        if(rd_en && !empty)
          begin
            data_out<=ram[rd_ptr];
  		    rd_ptr<=rd_ptr+1;
          end
    end
  
  always@(posedge wr_clk)
    begin
      if(reset)
        full<=0;
      else
        if(wr_ptr==3'b111)
          full<=1;
    end
  
  always@(posedge rd_clk)
    begin
      if(reset)
        empty<=0;
      else
        if(rd_ptr==3'b111)
          empty<=1;
    end
endmodule
      