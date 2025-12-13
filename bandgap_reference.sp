*bandgap

****************************************************
* Bandgap Reference
* Technology : UMC 0.18um CMOS
* Author     : Yu-Hsiang Lin
****************************************************

.SUBCKT bandgap_reference VDD VDD_BGR VSS VREF
*---------------------------------------------------
* Error amplifier
*---------------------------------------------------
XOP X Y VOUT VDD VSS two_stage_op

*---------------------------------------------------
* BJT core 
*---------------------------------------------------
Q1 VSS VSS X PNP_V50X50_MM m=1
Q2 VSS VSS net2 PNP_V50X50_MM m=8
Q3 VSS VSS net3 PNP_V50X50_MM m=1
R2 VREF net3 VDD_BGR rnhr1000_mm wr=400n lr=65.45u m=1
R1 Y    net2 VDD_BGR rnhr1000_mm wr=1u lr=18.59u m=1 
M1 X VOUT VDD_BGR VDD_BGR p_18_mm w=8u l=1u
M2 Y VOUT VDD_BGR VDD_BGR p_18_mm w=8u l=1u
M3 VREF VOUT VDD_BGR VDD_BGR p_18_mm w=8u l=1u 
.ENDS

.SUBCKT two_stage_op VIN VIP VOUT VDD VSS

***********************
* Differential Input Pair
***********************
m1  net58 vin  net57 vss n_18_mm  w=3e-6 l=1e-6  m=1
m2  net59 vip  net57 vss n_18_mm  w=3e-6 l=1e-6  m=1


***********************
* Tail Current & Bias Sink
***********************
m5  net57 net54 vss  vss n_18_mm  w=2e-6    l=1e-6  m=2
m8 net54 net54 vss  vss n_18_mm  w=2e-6    l=1e-6  m=1


***********************
* Constant-gm Bias Chain (NMOS)
***********************
m13 net56 net54 vss  vss n_18_mm  w=7e-6    l=1e-6  m=1
m12 net55 net56 vss  vss n_18_mm  w=1e-6    l=1e-6  m=1
m9  net55 net54 vss  vss n_18_mm  w=2e-6    l=1e-6  m=1


***********************
* Constant-gm Bias Load (PMOS)
***********************
m11 net55 net55 vdd  vdd p_18_mm  w=2e-6    l=1e-6  m=1
m10 net54 net55 net60 net60 p_18_mm  w=2e-6 l=1e-6  m=4


***********************
* Active Load (1st Stage PMOS)
***********************
m3  net58 net58 vdd  vdd p_18_mm  w=4e-6    l=1e-6  m=1
m4  net59 net58 vdd  vdd p_18_mm  w=4e-6    l=1e-6  m=1


***********************
* Second Stage Output Devices
***********************
m6  vout net59 vdd  vdd p_18_mm  w=7.98e-6 l=500e-9 m=4
m7  vout net54 vss  vss n_18_mm  w=5e-6    l=500e-9 m=2


***********************
* Bias Resistor Network
***********************
xrg1 net2  net56 vdd rnhr1000_mm  lr=4.28e-6  wr=180e-9
xrg2 net1  net2  vdd rnhr1000_mm  lr=4.28e-6  wr=180e-9
xrg3 vdd   net1  vdd rnhr1000_mm  lr=4.28e-6  wr=180e-9
* Rg is implemented as a series connection of xrg1, xrg2, and xrg3  
xrs  vdd   net60 vdd rnhr1000_mm  lr=11.38e-6 wr=180e-9


***********************
* Miller Compensation Network
***********************
xrz net61 net59 vdd rnhr1000_mm  lr=1.94e-6 wr=180e-9
xcc net61 vout mimcaps_mm       w=20e-6 l=22.18e-6
.ENDS