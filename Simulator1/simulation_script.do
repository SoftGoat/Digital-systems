# Load design files
vlog fas.sv fas_test.sv // Assuming your design files are fas.sv and fas_test.sv

# Compile the design and testbench
vsim -c -do {run -all; exit} work.fas_test

# Add signals to the waveform window
add wave -noupdate /fas_test/uut/*

# Run simulation
run -all

# Open waveform viewer
wave zoom full
