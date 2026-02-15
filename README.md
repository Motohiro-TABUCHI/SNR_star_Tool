# SNR* Tool (ImageJ Macro)

Covariance-based SNR estimation macro for ImageJ.

---

## Overview

SNR* is a covariance-based signal-to-noise ratio (SNR) estimator
calculated from **two observed images acquired under identical imaging conditions**.

This method separates signal variance and noise variance using statistical relationships between two images.

### Theory

Given two observed images:

I₁ = S + N₁  
I₂ = S + N₂  

where  
S  : true signal  
N₁, N₂ : independent noise components  

The variances are estimated as:

Signal variance:
σ_s² = Cov(I₁, I₂)

Noise variance:
σ_n² = Var(I₁ − I₂) / 2

SNR* is defined as:

SNR* (dB) = 10 log₁₀ (σ_s² / σ_n²)

---

## Requirements

- ImageJ 1.53 or later
- Exactly two observed images
- Images must:
  - Have identical dimensions
  - Be acquired under identical imaging conditions
  - Represent independent noise realizations

---

## Installation (Toolset Version)

1. Copy `SNR_star_Tool.ijm`
2. Place the file into:

```
ImageJ/macros/toolsets/
```

Example (Windows):

```
C:\ImageJ\macros\toolsets\
```

3. Restart ImageJ
4. Activate via:

```
More Tools >> SNR_star_Tool
```

The SNR* icon will appear in the ImageJ toolbar.

---

## Usage

1. Prepare a folder containing exactly two observed images.
2. Click the **SNR\*** tool icon.
3. Select the folder.
4. Draw an ROI on the first image.
5. The SNR* result is displayed in the Log window.

---

## Output

The macro outputs:

- SNR* [dB]
- ROI size
- Signal variance (σ_s²)
- Noise variance (σ_n²)

Output format follows the internal macro implementation.

---

## Notes

- The method assumes:
  - Additive noise
  - Zero-mean independent noise between the two images
- If covariance becomes negative, imaging conditions may not satisfy assumptions.
- Larger ROIs improve estimation stability.

---

## Version

1.0 (2026)

---

## Author
Motohiro TABUCHI

---

## License
This project is licensed under the MIT License.
See the LICENSE file for details.
