#**************************************************************
# Create Clock
#**************************************************************
create_clock -period 40 [get_ports pll_ref_clk]

# for enhancing USB BlasterII to be reliable, 25MHz
create_clock -name {altera_reserved_tck} -period 40 {altera_reserved_tck}
set_input_delay -clock altera_reserved_tck -clock_fall 3 [get_ports altera_reserved_tdi]
set_input_delay -clock altera_reserved_tck -clock_fall 3 [get_ports altera_reserved_tms]
set_output_delay -clock altera_reserved_tck 3 [get_ports altera_reserved_tdo]

#**************************************************************
# Create Generated Clock
#**************************************************************
derive_pll_clocks



#**************************************************************
# Set Clock Latency
#**************************************************************



#**************************************************************
# Set Clock Uncertainty
#**************************************************************
derive_clock_uncertainty



#**************************************************************
# Set Input Delay
#**************************************************************
# Board Delay (Data) + Propagation Delay - Board Delay (Clock)
#set_input_delay -min -clock tv_27m 14.128 [get_ports TD_DATA*]

#**************************************************************
# Set Output Delay
#**************************************************************
# max : Board Delay (Data) - Board Delay (Clock) + tsu (External Device)
# min : Board Delay (Data) - Board Delay (Clock) - th (External Device)
#set_output_delay -max -clock clk_vga 0.215 [get_ports VGA_BLANK]
#set_output_delay -min -clock clk_vga -1.485 [get_ports VGA_BLANK]




#**************************************************************
# Set Clock Groups
#**************************************************************



#**************************************************************
# Set False Path
#**************************************************************

set_false_path -from [get_ports {USR_LED[0]}] -to *
set_false_path -from [get_ports {USR_LED[1]}] -to *
set_false_path -from [get_ports {USR_LED[2]}] -to *
set_false_path -from [get_ports {USR_LED[3]}] -to *

set_false_path -from [get_ports {GPIO[54]}] -to *

set_false_path -from [get_ports {sd_data0}] -to *
set_false_path -from [get_ports {sd_data1}] -to *
set_false_path -from [get_ports {sd_cmd}] -to *
set_false_path -from [get_ports {sd_clk}] -to *
set_false_path -from [get_ports {USB_UART_TXD}] -to *
set_false_path -from [get_ports {USB_UART_RXD}] -to *
set_false_path -from [get_ports {global_reset_n}] -to *


#**************************************************************
# Set Multicycle Path
#**************************************************************



#**************************************************************
# Set Maximum Delay
#**************************************************************



#**************************************************************
# Set Minimum Delay
#**************************************************************



#**************************************************************
# Set Input Transition
#**************************************************************



#**************************************************************
# Set Load
#**************************************************************
