	alias clc ".main clear"
	
	clc
	exec vlib work
	vmap work work
	
	set TB					"tb"
	set hdl_path			"../src/hdl"
	set inc_path			"../src/inc"
	
	set run_time			"1 us"
#	set run_time			"-all"

#============================ Add verilog files  ===============================
# Pleas add other module here	
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/counter6bit.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/counter25.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/cu.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/dp.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/parity_finder.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/parity.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/prev_parity_reg5bit.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/reg25bit.v
		
	vlog 	+acc -incr -source  +incdir+$inc_path +define+SIM 	./tb/$TB.v
	onerror {break}

#================================ simulation ====================================

	vsim	-voptargs=+acc -debugDB $TB


#======================= adding signals to wave window ==========================


	add wave -hex -group 	 	{TB}				sim:/$TB/*
	add wave -hex -group 	 	{top}				sim:/$TB/uut/*	
	add wave -hex -group -r		{all}				sim:/$TB/*

#=========================== Configure wave signals =============================
	
	configure wave -signalnamewidth 2
    

#====================================== run =====================================

	run $run_time 
	