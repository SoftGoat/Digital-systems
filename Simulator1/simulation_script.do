# Compile design and testbench files
vlog fas.sv
vlog fas_test.sv

# Load simulation
vsim fas_test

# Add signals to the waveform window
add wave -noupdate /fas_test/uut/*
