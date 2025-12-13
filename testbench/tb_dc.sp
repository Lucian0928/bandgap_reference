****************************************************
* TB: Bandgap VREF vs TEMP (TT, VDD=1.8/1.9/2.0)
****************************************************
.option post=2

.include "../bandgap_reference.sp"
.lib ".../top_model_tt" 

.param VDD=1.8

* --- supplies ---
VDD_OP   vdd     0  'VDD'
VDD_BGR  vdd_bgr 0  'VDD'
VSS      vss     0  0

* --- DUT ---
XBG vdd vdd_bgr vss vref bandgap_reference

* --- sweep temperature ---
.dc TEMP -40 100 1

* --- measures ---
.meas dc VREF_MAX  MAX v(vref)
.meas dc VREF_MIN  MIN v(vref)
.meas dc VREF_60   FIND v(vref) AT=60
.meas dc TC_PPM    PARAM='(VREF_MAX - VREF_MIN) / (VREF_60 * (100 - (-40))) * 1e6'

* --- currents/power ---
.meas dc I_OP_UA      PARAM='abs(i(VDD_OP))*1e6'
.meas dc I_BGR_UA     PARAM='abs(i(VDD_BGR))*1e6'
.meas dc P_OP_UW      PARAM='VDD*abs(i(VDD_OP))*1e6'
.meas dc P_BGR_UW     PARAM='VDD*abs(i(VDD_BGR))*1e6'

****************************************************
* Alter cases for VDD
****************************************************
.alter
.param VDD=1.9

.alter
.param VDD=2.0

****************************************************
* Alter cases for corners
****************************************************
.alter
.lib ".../top_model_ff" 
.param VDD=1.8

.alter
.lib ".../top_model_ss" 
.param VDD=1.8

.end
