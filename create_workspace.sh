#!/usr/bin/bash

# Create Workspace Script
# Opens required directories in VS Code and launches necessary terminals

set -e

echo "Setting up workspace..."

# Open directories in VS Code
echo "Opening directories in VS Code..."
code ~/Research/repos/chipyard

# Wait for VS Code to open and execute commands in its integrated terminal
sleep 3

# Open integrated terminal in chipyard workspace and run setup commands
code -r ~/Research/repos/chipyard --command 'workbench.action.terminal.new'
sleep 1
# Send commands to the VS Code terminal
xdotool type --delay 100 "source env.sh && cd fpga/src/main/resources/genesys2/sdboot"
xdotool key Return

# Open other directories
code ~/Research/repos/u-boot
code ~/Research/repos/opensbi
code ~/Research/repos/vivado-risc-v

# Give VS Code a moment to initialize
sleep 2

# Open terminal for serial connection
echo "Launching serial connection terminal..."
gnome-terminal --title="Serial Connection" --working-directory="$HOME/Research/repos/chipyard/fpga/scripts" -- bash -c "./connect_serial.sh; exec bash"

# Open terminal for FPGA programming
echo "Launching FPGA programming terminal..."
gnome-terminal --title="FPGA Programming" --working-directory="$HOME/Research/repos/chipyard/fpga/scripts" -- bash -c "source /tools/Xilinx/2025.1/Vivado/settings64.sh && ./programFPGA.sh; exec bash"

echo "Workspace setup complete!"
