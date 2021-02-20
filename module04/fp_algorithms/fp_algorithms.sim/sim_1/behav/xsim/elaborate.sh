#!/bin/bash -f
# ****************************************************************************
# Vivado (TM) v2020.2 (64-bit)
#
# Filename    : elaborate.sh
# Simulator   : Xilinx Vivado Simulator
# Description : Script for elaborating the compiled design
#
# Generated by Vivado on Fri Feb 19 20:22:41 EST 2021
# SW Build 3064766 on Wed Nov 18 09:12:47 MST 2020
#
# Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
#
# usage: elaborate.sh
#
# ****************************************************************************
set -Eeuo pipefail
# elaborate design
echo "xelab -wto 2428e96babb5418e96e7d04eb510920f --incr --debug typical --relax --mt 8 -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip --snapshot fdiv_newton_tb_behav xil_defaultlib.fdiv_newton_tb xil_defaultlib.glbl -log elaborate.log"
xelab -wto 2428e96babb5418e96e7d04eb510920f --incr --debug typical --relax --mt 8 -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip --snapshot fdiv_newton_tb_behav xil_defaultlib.fdiv_newton_tb xil_defaultlib.glbl -log elaborate.log

