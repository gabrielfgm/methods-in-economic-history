# GDP Lecture Slides — Design Spec
Date: 2026-03-17
File to produce: `08_slides.qmd`

## Overview

Week 8 lecture on the measurement of GDP. Four sections: origins/purpose, data quality (Jerven), hedonic pricing (Nordhaus), and an in-class exercise on nail prices (Sichel).

Format: Quarto revealjs, matching existing slides (e.g. `07_slides.qmd`) — `{.smaller}` on every slide, bullet lists with `-`, LaTeX math with `$$`, blockquotes with `>`, `bibliography: references.bib`.

## Slide List (22 slides)

### Section 1: Today's plan + History of GDP
1. **Today's plan** — 4-point overview
2. **What is GDP?** — flow/location/time; three measurement approaches
3. **Early modern precursors** — Petty, Davenant, Necker; GDP as planner's tool
4. **Smith's productive/unproductive distinction** — blockquote; echoes in Marx/Soviet accounting
5. **Interwar institutionalization** — Clark (UK), Kuznets (US), Roosevelt commission
6. **Kuznets: welfare vs output** — 1937 blockquote on subtracting armaments/advertising
7. **The wartime battle** — Kuznets vs Gilbert/Commerce Dept; 1942 GNP includes govt spending
8. **The conceptual shift** — govt is part of the economy; Kuznets tautology; Pettis/Klein
9. **GDP as empirical construct** — Stone quote; theory-dependent; geared to management not welfare
10. **Gesturing beyond GDP** — Stiglitz, HDI/Sen; not today's focus

### Section 2: Jerven on data quality
11. **Jerven's framing** — veneer of accuracy; production boundary; Pigou's cook
12. **The base year problem** — definition; IMF best practice; why rarely followed
13. **Ghana's GDP revision** — 1993→2006 base; $21.7bn→$36.9bn; missing telecoms sector

### Section 3: Nordhaus / hedonic pricing
14. **The core problem** — price indices track goods not services; miss quality change
15. **Nordhaus: measuring the price of light** — lumens/watt; hedonic logic
16. **Fig 1.2: Bias in price indexes** — Nordhaus figure (image from Obsidian vault)
17. **Price indices for light** — second Nordhaus figure; dramatic fall in illumination cost
18. **The labour-hours measure** — 1,000 hours → candle equivalent; modern quality adjustment

### Section 4: Nails exercise
19. **Introducing the exercise** — what services do nails provide? link to Excel spreadsheet
20. **Historical timeline of nail technology** — Table A1 milestones (hand-forged → cut → wire → pneumatic); holding power differences
21. **Exercise instructions** — open spreadsheet; identify price breaks; think about quality adjustment

22. **Bibliography**

## Assets

- **Nordhaus images** (copy into `images/` directory):
  - `Pasted image 20260317134042.png` → slide 16 (Fig 1.2 bias in price indexes)
  - `Pasted image 20260317134614.png` → slide 17 (price indices for light)
  - `Pasted image 20260317134954.png` → slide 19/20 (Sichel nail price figure for exercise intro)
  - Source: `/Users/k1925864/Library/CloudStorage/Dropbox/Obsidian Vault/`
- **Nail price spreadsheet**: extract column BH (PRMATCHCN, real cents/nail 2012$, 1695–2019) from `/Users/k1925864/Downloads/154101-V1/Sichel JEP Nails PRICES Data Figures Sep21.xlsx` → create `nails-exercise/` directory and save as `nails-exercise/nail_prices.xlsx` with columns Year and Real_Price_Cents_Per_Nail_2012USD
- **Spreadsheet link in slides**: use a relative hyperlink `[nail_prices.xlsx](nails-exercise/nail_prices.xlsx)` on slide 21
- Add `@sichel2022` to `references.bib`

## References already in references.bib
- `@coyle2014`, `@jerven2013`, `@nordhaus1997`

## Reference to add
- Key: `sichel2022`; Sichel, Daniel E. "The Price of Nails since 1695: A Window into Economic Change." *Journal of Economic Perspectives* 36, no. 1 (2022): 125–50.

## Citation notes
- Slide 8 Pettis/Klein reference is an allusion only — no formal citation needed
- Slide 9 Stone quote is paraphrased via @coyle2014 — cite as @coyle2014
