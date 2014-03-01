module initial_reset_pulse
#(
	parameter INITIAL_US_DELAY = 1000000, //1sec
	parameter CLOCK_SPEED_HZ = 50000000, //50Mhz
	parameter PULSE_LENGTH = 100)
(
input clk,
output pulse
);

parameter INITIAL_CYCLONE_COUNT = (CLOCK_SPEED_HZ / 1000000) * INITIAL_US_DELAY;

reg [31:0] counter_next;
reg [31:0] counter_reg;

reg pulse_next;
reg pulse_reg;

wire couter_past_initial_cycle_count;
wire couter_past_final_cycle_count;

assign couter_past_initial_cycle_count = counter_reg >= INITIAL_CYCLONE_COUNT;
assign couter_past_final_cycle_count = counter_reg >= (INITIAL_CYCLONE_COUNT + PULSE_LENGTH);

initial counter_reg = 32'd0;

always @(*)
begin
   pulse_next = 1'b0;
	counter_next = counter_reg + 1;
	if(~couter_past_initial_cycle_count)
	begin
		pulse_next = 1'b0;
	end
	else if(couter_past_initial_cycle_count && ~couter_past_final_cycle_count)
	begin
		pulse_next = 1'b1;
	end
	else if(couter_past_final_cycle_count)
	begin
		pulse_next = 1'b0;
		counter_next = counter_reg;
	end
end

always @ ( posedge clk )
begin
	counter_reg <= counter_next;
	pulse_reg <= pulse_next;
end

assign pulse = ~pulse_reg;

endmodule