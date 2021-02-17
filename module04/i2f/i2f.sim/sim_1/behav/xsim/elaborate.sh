#!/bin/bash -f
# ****************************************************************************
# Vivado (TM) v2020.2 (64-bit)
#
# Filename    : elaborate.sh
# Simulator   : Xilinx Vivado Simulator
# Description : Script for elaborating the compiled design
#
# Generated by Vivado on Tue Feb 16 20:03:53 EST 2021
# SW Build 3064766 on Wed Nov 18 09:12:47 MST 2020
#
# Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
#
# usage: elaborate.sh
#
# ****************************************************************************
set -Eeuo pipefail
# elaborate design
echo "xelab -wto 55a7e0a5e4e74fa587c07e863bb77122 --incr --debug typical --relax --mt 8 -L xil_defaultlib -L xbip_utils_v3_0_10 -L axi_utils_v2_0_6 -L xbip_pipe_v3_0_6 -L xbip_dsp48_wrapper_v3_0_4 -L xbip_dsp48_addsub_v3_0_6 -L xbip_dsp48_multadd_v3_0_6 -L xbip_bram18k_v3_0_6 -L mult_gen_v12_0_16 -L floating_point_v7_1_11 -L unisims_ver -L unimacro_ver -L secureip -L xpm --snapshot tb_i2f_behav xil_defaultlib.tb_i2f xil_defaultlib.glbl -log elaborate.log"
xelab -wto 55a7e0a5e4e74fa587c07e863bb77122 --incr --debug typical --relax --mt 8 -L xil_defaultlib -L xbip_utils_v3_0_10 -L axi_utils_v2_0_6 -L xbip_pipe_v3_0_6 -L xbip_dsp48_wrapper_v3_0_4 -L xbip_dsp48_addsub_v3_0_6 -L xbip_dsp48_multadd_v3_0_6 -L xbip_bram18k_v3_0_6 -L mult_gen_v12_0_16 -L floating_point_v7_1_11 -L unisims_ver -L unimacro_ver -L secureip -L xpm --snapshot tb_i2f_behav xil_defaultlib.tb_i2f xil_defaultlib.glbl -log elaborate.log

