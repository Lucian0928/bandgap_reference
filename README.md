## Design Objective

The goal of this project is to design a **precision bandgap reference** operating at **1.8V～2.0V** with the following objectives:

- Generate a stable reference voltage around **1.2V**
- Achieve low temperature coefficient across wide temperature range
- Optimize static current consumption as low as possible

---

## Architecture Overview

![Bandgap Architecture](figures/architecture.png)

- **CTAT voltage generator** based on diode-connected bipolar devices
- **PTAT voltage generator** using ΔV<sub>BE</sub> from emitter-area ratio
- **Resistive weighting network** for PTAT–CTAT summation
- **Operational amplifier** enforcing accurate node voltage equality
- **Bias and current mirror network** for reference current generation
- **Startup mechanism** ensuring correct power-up behavior

---

## Bandgap Operating Principle

The reference voltage is formed by summing a CTAT voltage and a PTAT voltage:

$$V_REF = V_EB3 + V_Tln(n)*R_2/R_1$$

where:

- \( V_{BE} \) is the CTAT base–emitter voltage  
- \( V_T = \frac{kT}{q} \) is the thermal voltage  
- \( n \) is the emitter-area ratio of bipolar devices  

To minimize temperature dependence, the resistor ratio is selected such that the PTAT and CTAT slopes cancel around the nominal operating temperature.  
In this design, an emitter-area ratio of \( n = 8 \) is chosen to balance layout symmetry and PTAT voltage magnitude.

---

## Supply & Operating Conditions

| Parameter | Value |
|---------|------|
| Technology | UMC 0.18 µm CMOS |
| Supply Voltage (VDD) | 1.8 V (sweep: 1.8–2.0 V) |
| Reference Voltage @ 60 °C | ~1.21 V |
| Temperature Range | −40 °C to 100 °C |
| Process Corners | TT / FF / SS |
| Simulation Type | Pre-layout & Post-layout |

---

## Final Performance Summary (Pre-Layout vs. Post-Layout)

| Metric | Spec | Pre-Sim | Post-Sim |
|------|------|---------|----------|
| VREF @ 60 °C | ~1.21 V | 1.213 V | 1.210 V |
| Static Current (exclude OP) | < 50 µA | 9–13 µA | 9–13 µA |
| OP Current | — | ~56 µA | ~56 µA |
| OP Power | — | ~100 µW | ~100 µW |
| Temperature Coefficient | < 15 ppm/°C | 3–8 ppm/°C | 4–10 ppm/°C |
| PVT Robustness | Required | Pass | Pass |

---

## Device Parameters

### Bipolar Devices
| Device | Type | Emitter Area Ratio |
|------|------|--------------------|
| Q1, Q2, Q3 | Vertical PNP | 1 : 8 |

### MOS Devices
| Device | W / L (µm / µm) |
|------|------------------|
| M1, M2, M3 | 8 / 1 |

### Passive Components
| Component | Value |
|----------|-------|
| R1 | ~20 kΩ |
| R2 | ~170 kΩ |

---

## Temperature Sweep Results

### VREF vs. Temperature (TT / FF / SS @ VDD = 1.8 V)

<table>
  <tr>
    <td align="center"><b>Pre-Simulation</b></td>
    <td align="center"><b>Post-Simulation</b></td>
  </tr>
  <tr>
    <td><img src="figures/temp_pre.png" width="380"></td>
    <td><img src="figures/temp_post.png" width="380"></td>
  </tr>
</table>

---

## Supply Sensitivity

### VREF vs. Temperature under Different Supply Voltages

<table>
  <tr>
    <td align="center"><b>VDD = 1.8 / 1.9 / 2.0 V</b></td>
  </tr>
  <tr>
    <td><img src="figures/vdd_sweep.png" width="420"></td>
  </tr>
</table>

---

## Transient Response

### VREF under VDD Ramp (1.8 V → 2.0 V, 100 ms rise time)

<table>
  <tr>
    <td align="center"><b>Pre-Simulation</b></td>
    <td align="center"><b>Post-Simulation</b></td>
  </tr>
  <tr>
    <td><img src="figures/ramp_pre.png" width="380"></td>
    <td><img src="figures/ramp_post.png" width="380"></td>
  </tr>
</table>

---

## Layout Implementation

| Item | Result |
|----|----|
| Layout Area | ~8,100 µm² |
| DRC | Pass |
| LVS | Pass |
| Floorplan | Symmetric, matched devices |

<table>
  <tr>
    <td><img src="figures/layout.png" width="380"></td>
    <td><img src="figures/floorplan.png" width="380"></td>
  </tr>
</table>

---

## Design Methodology & Parameter Derivation

The analytical derivation of the bandgap equation, resistor ratio selection, emitter-area ratio choice, and operational amplifier design considerations are documented in:

📄 **`analysis/bandgap_parameter_derivation.pdf`**

This document includes:

- Step-by-step derivation of \( V_{REF} \)
- PTAT–CTAT slope matching strategy
- Initial hand calculations and assumptions
- Parameter refinement based on simulation feedback
- PVT robustness considerations

---

## Tools & Environment

- Cadence Virtuoso
- Spectre Simulator
- UMC 0.18 µm PDK
- Custom transistor-level netlists

---

## Author

**Yu-Hsiang Lin**  
Analog & Mixed-Signal IC Design  
National Yang Ming Chiao Tung University
