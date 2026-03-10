# Design: Real Wages Exercise — Simulated Primary Source Materials

**Date:** 2026-03-10
**Course:** Methods in Economic History (6AAH1008)
**Author:** Gabriel Mesevage

---

## Purpose

Create printable primary source materials for a student exercise in constructing a
real wage index following the approaches of Lindert & Williamson and Feinstein.
Students work with simulated "Parliamentary Reports" to build a Cost of Living index
and a nominal wage index, then combine them into a real wage series covering England
1770–1850.

---

## File Structure

```
real-wages-exercise/
├── generate_data.R          # generates all CSVs from scratch
├── real-wages-exercise.qmd  # parametrized Quarto document → PDF
├── docs/plans/              # this design doc
└── data/
    ├── wages_london.csv
    ├── wages_northern.csv
    ├── employment_shares.csv
    ├── prices_wheat.csv
    ├── prices_rent.csv
    ├── prices_national.csv
    ├── budget_shares.csv
    ├── unemployment_textiles.csv
    └── female_lfp.csv
```

### Rendering

```bash
quarto render real-wages-exercise.qmd -P solutions:false  # student handout
quarto render real-wages-exercise.qmd -P solutions:true   # teacher edition
```

---

## The Nine Tables

All monetary values in £ (decimal). Unit choices avoid tiny decimals:
wages in £/week, wheat in £/quarter, rent in £/week, meat in £/stone,
candles in £/dozen lbs, clothes in £/yard.

| # | Title | Content | Regional? |
|---|-------|---------|-----------|
| 1 | Parliamentary Report on Wages in London Industries | Weekly wages (£/week) by industry | London |
| 2 | Parliamentary Report on Wages in the Northern Counties | Weekly wages (£/week) by industry | North |
| 3 | Parliamentary Report on Employment by Industry, England & Wales | Employment shares (%) | National |
| 4 | Parliamentary Report on Grain Prices in London and Northern Markets | Wheat price (£/quarter) | Both |
| 5 | Parliamentary Report on Retail Prices of Selected Commodities | Meat, veg, beer, candles, clothes | National |
| 6 | Parliamentary Report on Weekly Rents by Region | Rent (£/week) | Both |
| 7 | Parliamentary Report on Expenditure of Labouring Families | Budget shares (%) | National |
| 8 | Parliamentary Report on Employment Conditions in the Textile Industry | Weeks unemployed/year | National |
| 9 | Parliamentary Report on Female Employment in Selected Industries | Female participation rate (%) | National |

**Industries:** Agriculture, Textiles, Building & Construction, Mining, Domestic Service
**Dates:** 1770, 1790, 1810, 1830, 1850

---

## Data Narrative

Calibrated to produce a Feinstein-style "pessimist" result:
- Real wages broadly stagnate or fall slightly 1770–1830
- Recovery visible 1830–1850
- Wheat prices spike at 1810 (Napoleonic Wars) then fall back
- London wages consistently higher than Northern; gap widens slightly
- Textiles unemployment low 1770, peaks 1830 (handloom collapse), eases 1850
- Female participation high in Domestic Service throughout; falls in Agriculture
- Budget shares: food (bread/meat/veg) ~53%, rent ~20%, rest for fuel/beer/clothes

This matches readings from week 7 (Feinstein; Lindert & Williamson) and
connects back to week 5 (Allen; Humphries) on wage measurement debates.

---

## Student Methodological Choices

The exercise is designed so students face genuine decisions mirroring the literature:

1. **Regional aggregation of wages:** Use London, Northern, or weighted combination?
   Employment shares are national — students must decide whether to use these as
   regional proxies, re-weight, or flag the limitation.

2. **Unemployment adjustment:** Table 8 gives textile unemployment. Students must
   decide: ignore it, adjust textile wages downward by weeks worked, or treat it
   as a data quality flag.

3. **Female labour:** Table 9 gives female participation by industry. Students must
   decide: construct a female-only series, a blended series, or note it as a
   caveat on the male-dominated wage data.

---

## Solutions Section (teacher edition only)

The `solutions:true` render adds a page-break section with:

1. **LaTeX equations** defining the three indices:
   - Cost of Living Index: $P_t = \sum_i w_i (p_{i,t} / p_{i,0})$
   - Nominal Wage Index: $W_t = \sum_j s_{j,t} (w_{j,t} / w_{j,0})$
   - Real Wage Index: $RW_t = W_t / P_t$

2. **Embedded R code** that:
   - Loads the CSVs
   - Computes national-average nominal wages using employment shares
   - Computes CoL index using budget-share weights
   - Divides to produce real wage index
   - Outputs a table and a plot of all three series 1770–1850

---

## Technology

- **Data generation:** `generate_data.R` (base R, no dependencies)
- **Document:** Quarto with `format: pdf`, `params: solutions`
- **Tables:** `knitr::kable` with `booktabs = TRUE` and `kableExtra` for formatting
- **Solutions plots:** `ggplot2`
