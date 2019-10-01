@echo off
REM ****************************************************************************
REM Vivado (TM) v2019.1 (64-bit)
REM
REM Filename    : simulate.bat
REM Simulator   : Xilinx Vivado Simulator
REM Description : Script for simulating the design by launching the simulator
REM
REM Generated by Vivado on Mon Sep 30 22:23:53 -0500 2019
REM SW Build 2552052 on Fri May 24 14:49:42 MDT 2019
REM
REM Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
REM
REM usage: simulate.bat
REM
REM ****************************************************************************
echo "xsim regfile_tb_behav -key {Behavioral:sim_1:Functional:regfile_tb} -tclbatch regfile_tb.tcl -view E:/EECS645/EECS645_HW4/HW4/HW04_MIPS_RegFile_Felsen/simulation_sources/regfile_wave.wcfg -log simulate.log"
call xsim  regfile_tb_behav -key {Behavioral:sim_1:Functional:regfile_tb} -tclbatch regfile_tb.tcl -view E:/EECS645/EECS645_HW4/HW4/HW04_MIPS_RegFile_Felsen/simulation_sources/regfile_wave.wcfg -log simulate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0