# GDP Slides Implementation Plan

> **For agentic workers:** REQUIRED: Use superpowers:subagent-driven-development (if subagents available) or superpowers:executing-plans to implement this plan. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Produce `08_slides.qmd` — a 22-slide Quarto revealjs lecture deck on measuring GDP, plus a student Excel data file for an in-class exercise.

**Architecture:** Matches existing slide style in `07_slides.qmd` exactly (revealjs format, `{.smaller}` on every slide, `-` bullet lists, `$$` math, `>` blockquotes, `bibliography: references.bib`). Support assets (images, exercise spreadsheet) are created first, then the slides are written, then the bib entry is added.

**Tech Stack:** Quarto revealjs, Python (openpyxl) for data extraction, BibTeX for references.

**Spec:** `docs/superpowers/specs/2026-03-17-gdp-slides-design.md`

**Working directory:** All bash commands must be run from the project root:
`/Users/k1925864/Library/CloudStorage/Dropbox/teaching/methods-in-economic-history`

Prefix every bash block with:
```bash
cd /Users/k1925864/Library/CloudStorage/Dropbox/teaching/methods-in-economic-history
```

**Dependencies:** `openpyxl` must be available. Verify with:
```bash
python3 -c "import openpyxl; print('ok')"
```
If missing: `/Users/k1925864/miniconda3/bin/pip install openpyxl`

---

## Chunk 1: Assets — images, spreadsheet, bib entry

### Task 1: Copy Nordhaus/Sichel images into project

**Files:**
- Create: `images/nordhaus_bias_price_indexes.png`
- Create: `images/nordhaus_price_indices_light.png`
- Create: `images/sichel_nail_prices.png`

- [ ] **Step 1: Copy the three images from Obsidian vault**

```bash
cp "/Users/k1925864/Library/CloudStorage/Dropbox/Obsidian Vault/Pasted image 20260317134042.png" \
   images/nordhaus_bias_price_indexes.png

cp "/Users/k1925864/Library/CloudStorage/Dropbox/Obsidian Vault/Pasted image 20260317134614.png" \
   images/nordhaus_price_indices_light.png

cp "/Users/k1925864/Library/CloudStorage/Dropbox/Obsidian Vault/Pasted image 20260317134954.png" \
   images/sichel_nail_prices.png
```

Expected: three files exist in `images/`

- [ ] **Step 2: Verify**

```bash
ls images/nordhaus_bias_price_indexes.png images/nordhaus_price_indices_light.png images/sichel_nail_prices.png
```

Expected: all three paths printed with no errors

---

### Task 2: Extract nail price data to Excel

**Files:**
- Create: `nails-exercise/nail_prices.xlsx`

- [ ] **Step 1: Create the `nails-exercise/` directory**

```bash
mkdir -p nails-exercise
```

- [ ] **Step 2: Extract column BH (PRMATCHCN) from Sichel spreadsheet**

Run the following Python script:

```python
import openpyxl
from openpyxl.utils import column_index_from_string

src = "/Users/k1925864/Downloads/154101-V1/Sichel JEP Nails PRICES Data Figures Sep21.xlsx"
dst = "nails-exercise/nail_prices.xlsx"

wb_src = openpyxl.load_workbook(src, data_only=True)
ws_src = wb_src.active

bh_idx = column_index_from_string('BH')  # = 60

wb_dst = openpyxl.Workbook()
ws_dst = wb_dst.active
ws_dst.title = "Nail Prices"

# Header
ws_dst.append(["Year", "Real_Price_Cents_Per_Nail_2012USD"])

# Data starts at row 13; column A = year
for row in ws_src.iter_rows(min_row=13, max_row=ws_src.max_row, values_only=True):
    year = row[0]
    val  = row[bh_idx - 1]
    if year is not None and val is not None:
        ws_dst.append([int(year), round(float(val), 6)])

wb_dst.save(dst)
print(f"Saved {dst}")
```

Expected output: `Saved nails-exercise/nail_prices.xlsx`

- [ ] **Step 3: Verify row count and spot-check values**

```python
import openpyxl
wb = openpyxl.load_workbook("nails-exercise/nail_prices.xlsx")
ws = wb.active
rows = list(ws.iter_rows(values_only=True))
print("Header:", rows[0])
print("First data:", rows[1])
print("Last data:", rows[-1])
print("Total rows (incl header):", len(rows))
```

Expected: header is `('Year', 'Real_Price_Cents_Per_Nail_2012USD')`, first data row is `(1695, ...)`, last is `(2019, ...)`, total ~326 rows.

- [ ] **Step 4: Commit assets**

```bash
git add images/nordhaus_bias_price_indexes.png \
        images/nordhaus_price_indices_light.png \
        images/sichel_nail_prices.png \
        nails-exercise/nail_prices.xlsx
git commit -m "feat: add images and nail price exercise spreadsheet for wk8 GDP lecture"
```

---

### Task 3: Add Sichel to references.bib

**Files:**
- Modify: `references.bib`

- [ ] **Step 1: Add @sichel2022 entry to references.bib**

Append the following BibTeX entry to `references.bib`:

```bibtex
@article{sichel2022,
  title = {The Price of Nails since 1695: A Window into Economic Change},
  author = {Sichel, Daniel E.},
  year = {2022},
  journal = {Journal of Economic Perspectives},
  volume = {36},
  number = {1},
  pages = {125--150},
  langid = {en}
}
```

- [ ] **Step 2: Commit**

```bash
git add references.bib
git commit -m "feat: add Sichel 2022 JEP nails reference"
```

---

## Chunk 2: Write 08_slides.qmd

### Task 4: Write the complete slide deck

**Files:**
- Create: `08_slides.qmd`

The file should match the YAML front matter of `07_slides.qmd` exactly, with `title` updated. Every content slide uses `## Slide Title {.smaller}`.

- [ ] **Step 1: Write `08_slides.qmd`**

Write the file with all 22 slides as specified below. Full content for each slide:

---

**YAML front matter** (identical to 07_slides.qmd except title):

```yaml
---
title: "Measuring GDP"
author: "Gabriel Mesevage"
format:
  revealjs:
    slide-number: c/t
    chalkboard:
      buttons: true
editor:
  markdown:
    wrap: sentence
bibliography: references.bib
---
```

---

**Slide 1 — Today's plan**

```markdown
## Today's plan {.smaller}

1.  The origins and purpose of GDP
2.  Data quality: what do we actually know about GDP?
3.  Hedonic pricing: measuring the price of services, not goods
4.  Exercise: the price of nails
```

---

**Slide 2 — What is GDP?**

```markdown
## What is GDP? {.smaller}

-   GDP measures a **flow** of economic activity within a particular **location** over a particular **period of time**

-   Three equivalent approaches to measurement:

    1.  **Expenditure**: sum of all spending on final goods and services — $C + I + G + (X - M)$
    2.  **Income**: sum of all incomes earned in production
    3.  **Output**: sum of value added at each stage of production

-   In principle all three give the same number; in practice they diverge — the gaps are called **statistical discrepancies**

-   GDP is a **tool** first and foremost: it was designed to answer the planner's question, not the welfare question
```

---

**Slide 3 — Early modern precursors**

```markdown
## Early modern precursors {.smaller}

-   @coyle2014 opens with the claim that "GDP is one of the many inventions of World War II" — correct, but it has much earlier roots

-   **William Petty (1660s)**: estimated English income, expenditure, population, and assets — explicitly to show England could finance war against Holland and France

-   **Charles Davenant**: similar exercises in England

-   **Jacques Necker (France)**: national accounting geared towards showing the ruler the fiscal capacity of the state for war

-   The thread is consistent: these early efforts are instruments of **statecraft**, not welfare measurement
```

---

**Slide 4 — Smith's productive/unproductive distinction**

```markdown
## Smith's productive/unproductive distinction {.smaller}

-   Adam Smith drew a sharp line between productive and unproductive labour in *The Wealth of Nations*:

> There is one sort of labour which adds to the value of the subject upon which it is bestowed: There is another which has no such effect. … The labour of a menial servant, on the contrary, adds to the value of nothing. … A man grows rich by employing a multitude of manufacturers: He grows poor, by maintaining a multitude of menial servants.

-   This excluded much of what we now call **services** from national income

-   The prejudice was echoed by Marx; the Soviet Union "largely ignored service activities" [@coyle2014]

-   By the late 19th century, Alfred Marshall and others pushed for an **expansive view** closer to modern usage
```

---

**Slide 5 — Interwar institutionalisation**

```markdown
## Interwar institutionalisation {.smaller}

-   National income estimation became more formalised in the interwar period, linked to understanding the economic crises of the time

-   **UK**: Colin Clark produced national income and expenditure estimates; appointed in 1930 to the National Economic Advisory Council

-   **US**: Simon Kuznets worked under President Roosevelt to adapt these methods; his first report to Congress in 1934 estimated national income had **halved** between 1929 and 1932

-   This offered a far more complete picture than what Hoover had been working with: scattered industrial statistics and share prices

-   The numbers made the scale of the Depression visible and legible to policymakers
```

---

**Slide 6 — Kuznets: welfare vs output**

```markdown
## Kuznets: welfare vs output {.smaller}

-   Kuznets recognised he was producing an **output series**, but thought **welfare** was the more important and interesting problem

-   He wrote in 1937:

> It would be of great value to have national income estimates that would remove from the total the elements which … represent dis-service rather than service. Such estimates would subtract … all expenses on armament, most of the outlays on advertising … and what is perhaps most important, the outlays that have been made necessary in order to overcome difficulties that are, properly speaking, costs implicit in our economic civilization.

-   This was not what the US government wanted [@coyle2014]
```

---

**Slide 7 — The wartime battle**

```markdown
## The wartime battle {.smaller}

-   By the late 1930s the US government needed national accounts that showed **productive capacity for war** — and that **included government expenditure** as part of output

-   Earlier definitions generally excluded government spending; as government expanded at the expense of the private economy, GDP would appear to *shrink*

-   Government economist **Gilbert** argued for a measure useful to fiscal policy management — this position won out

-   The first official American GNP statistics (1942) included government expenditure and were designed to analyse the burden of the war

-   Kuznets remained skeptical: including government spending "tautologically ensured that fiscal spending would increase measured economic growth regardless of whether it actually benefited individuals' welfare" [@coyle2014]
```

---

**Slide 8 — The conceptual shift**

```markdown
## The conceptual shift {.smaller}

-   The modern settlement: government is **not separate** from the economy — the public and private sectors are interlinked

-   Given government consumption is around 18% of GDP in modern OECD countries, it would be strange *not* to include it

-   But Kuznets's point has force: a $1 billion bridge to nowhere is measured by its **cost** — an input measure, not a welfare measure

-   There are echoes in modern debates: economists like Pettis have argued that much Chinese GDP growth comes from politically-directed investment (real-estate construction) valued at cost, where the consumption benefits may be illusory

-   GDP measures **economic activity**, not **welfare** — that distinction is built into its history
```

---

**Slide 9 — GDP as empirical construct**

```markdown
## GDP as empirical construct {.smaller}

-   Richard Stone, a pioneer of national accounts in the UK, emphasised that GDP is a **theory-laden construct**, not a fact [@coyle2014]:

> To ascertain income it is necessary to set up a theory from which income is derived as a concept by postulation and then associate this concept with a certain set of primary facts.

-   Different theoretical frameworks would yield quite different measures

-   The UN System of National Accounts states explicitly that the accounting framework "is designed for purposes of **economic analysis, decision-taking and policymaking**" — not welfare

-   Two key features: (1) theory-dependent, (2) geared to economic management, not welfare measurement
```

---

**Slide 10 — Gesturing beyond GDP**

```markdown
## Gesturing beyond GDP {.smaller}

-   Recognition of GDP's limits has prompted alternatives aimed more explicitly at **welfare**

-   **Stiglitz-Sen-Fitoussi Commission (2009)**: recommended supplementing GDP with measures of inequality, sustainability, and subjective well-being

-   **Human Development Index (HDI)**: Amartya Sen and Mahbub ul Haq — combines income, health, and education; used by UNDP

-   These are important but raise their own deep measurement problems: how do you combine health and income into a single index?

-   Today's focus is different: before asking "should we go beyond GDP?" we need to understand **how well GDP itself is measured**
```

---

**Slide 11 — Jerven: the veneer of accuracy**

```markdown
## Jerven: the veneer of accuracy {.smaller}

-   @jerven2013 argues that GDP statistics for sub-Saharan Africa present a **veneer of greater accuracy** than is warranted

-   The answer to "what do we know about income and growth in sub-Saharan Africa?" is "much less than we like to think"

-   The core issue: where to place the **production boundary** — what counts as economic activity?

-   Pigou's famous example: if you marry your cook, what happens to GDP?

    -   Before: cook's wages counted as GDP (market transaction)
    -   After: domestic labour is unpaid and outside the production boundary — GDP *falls*

-   The boundary is a **conceptual choice**, not a natural fact — and different choices yield very different numbers
```

---

**Slide 12 — The base year problem**

```markdown
## The base year problem {.smaller}

-   To measure **real** (inflation-adjusted) GDP you need a base year in which prices are held constant

-   The base year also defines the **sectoral weights**: the relative size of agriculture, industry, services, etc.

-   As sectors grow at different rates and relative prices shift, the base-year weights become increasingly misleading

-   **IMF best practice**: rebase every five years — but this is rarely followed in low-income countries due to cost

-   Consequence: GDP figures reflect the structure of the economy in the base year, not today — introducing systematic **bias**
```

---

**Slide 13 — Ghana's GDP revision**

```markdown
## Ghana's GDP revision {.smaller}

-   Ghana was using **1993 as the base year** until the mid-2000s

-   In 2010 they updated the base year to 2006 sector weights and prices

-   Result: measured GDP jumped from **$21.7 billion** (old base) to **$36.9 billion** (new base) — nearly doubling overnight

-   One concrete problem with the 1993 base: Ghana had **no communications sector** in the base year

    -   Ghana has a large and growing telecoms sector — but its contribution was measured using 1993 landline-era weights and prices
    -   The mobile phone revolution was essentially invisible in the old accounts

-   @jerven2013: the statistics are not fabricated — they follow the rules — but the rules produce misleading results
```

---

**Slide 14 — The core measurement problem**

```markdown
## The core measurement problem {.smaller}

-   Even if data collection is perfect, price indices face a deeper challenge: they track the **prices of goods**, not the **prices of the services those goods provide**

-   @nordhaus1997:

> For many practical reasons, traditional price indexes measure the prices of goods that consumers buy rather than the prices of the services that consumers enjoy.

-   This matters whenever goods **change quality** or are **replaced by new products**

    -   A laptop in 2025 and a laptop in 1995 are both called "a laptop" — but they are radically different objects
    -   Tracking the price of "a laptop" misses the enormous improvement in computing services per dollar

-   **Hedonic pricing** (from the Greek *hedone*, pleasure): price the bundle of services goods provide, not the goods themselves
```

---

**Slide 15 — Nordhaus: measuring the price of light**

```markdown
## Nordhaus: measuring the price of light {.smaller}

-   @nordhaus1997 chooses a deliberately simple case: the price of **illumination**

-   People do not want candles, whale oil, kerosene, or electricity — they want **light**

-   The service can be measured cleanly: **lumens per watt** — units of illuminance per unit of energy input

-   This allows Nordhaus to track the *price of the service* rather than the *price of the energy source*

-   The key insight: as technology changes (candles → gas → electricity → LEDs), traditional price indices track a shifting set of goods; Nordhaus tracks a fixed service

-   Result: the true fall in the cost of light is **far larger** than traditional price indices suggest
```

---

**Slide 16 — Bias in price indexes**

```markdown
## Bias in price indexes {.smaller}

![Nordhaus (1997) Fig. 1.2: price of gas/kerosene vs electric light, 1883–1993 (1883 = 100)](images/nordhaus_bias_price_indexes.png){height="450px"}
```

---

**Slide 17 — The price of light over time**

```markdown
## The price of light over time {.smaller}

![Nordhaus (1997): price indices for light showing the dramatic long-run fall in illumination costs](images/nordhaus_price_indices_light.png){height="450px"}
```

---

**Slide 18 — The labour-hours measure**

```markdown
## The labour-hours measure {.smaller}

-   Nordhaus extends the hedonic argument by expressing the cost of light in **labour hours**:

> One modern one-hundred-watt incandescent bulb burning for three hours each night would produce 1.5 million lumen-hours of light per year. At the beginning of the last century, obtaining this amount of light would have required burning seventeen thousand candles, and the average worker would have had to toil almost **one thousand hours** to earn the dollars to buy the candles. [@nordhaus1997]

-   Not only is light much cheaper — the time we must devote to earning it has fallen even further

-   **Modern practice**: US statistical agencies now "quality-adjust" price indices — a new car's price is adjusted for mileage, safety features, fuel efficiency — tracking the *services* the car provides, not just its sticker price

-   This remains contested and difficult: how do you price all the services bundled in a smartphone?
```

---

**Slide 19 — The nail price exercise**

```markdown
## The nail price exercise {.smaller}

-   We now work through a similar exercise using the **price of nails** [@sichel2022]

-   Nails provide services: holding things together, bearing loads, ease of driving

-   The data: real price of a nail in 2012 US cents, 1695–2019

    -   Source: Sichel (2022), matched-model index (column PRMATCHCN)
    -   Splices together hand-forged, cut, and wire nail price series

![Sichel (2022): real price of nails, 1695–2019](images/sichel_nail_prices.png){height="300px"}
```

---

**Slide 20 — A history of nail technology**

```markdown
## A history of nail technology {.smaller}

| Period | Technology | Key change |
|---|---|---|
| Roman era – 1820 | **Hand-forged** | ~1 minute per nail by a nailsmith |
| 1790s – 1890s | **Cut nails** | Machine-cut from iron/steel sheet; steam-powered rolling mills |
| 1880s – 1920 | **Wire nails** | Drawn from wire; 300–450/min by machine |
| Early 1980s | **Pneumatic nail guns** | First appear in Sears catalogue |
| Today | Fully automated | Some machines: 2,000 nails/minute |

-   Cut nails have roughly **twice the holding power** of wire nails of the same size — but wire nails won because of lower cost and shipping weight [@sichel2022]

-   What does this imply for a traditional price index vs a hedonic one?
```

---

**Slide 21 — Exercise instructions**

```markdown
## Exercise {.smaller}

Open the data file: [nail_prices.xlsx](nails-exercise/nail_prices.xlsx)

The spreadsheet contains: **Year** and **Real_Price_Cents_Per_Nail_2012USD** (Sichel's matched-model index, column PRMATCHCN)

**Questions to consider:**

1.  Plot the series (or sketch the shape). Where are the major price breaks? Can you connect them to the technology timeline on the previous slide?

2.  What **services** do nails provide? List as many as you can.

3.  How have those services **changed** across the three nail technologies (forged → cut → wire)? Think about: holding power, ease of driving, weight, uniformity.

4.  If you were constructing a **hedonic price index** for nails, what unit of service would you use — analogous to Nordhaus's lumens per watt?

5.  Do you think a hedonic adjustment would make the price fall look *larger* or *smaller* than the raw matched-model series? Why?
```

---

**Slide 22 — Bibliography**

```markdown
## Bibliography
```

- [ ] **Step 2: Verify the file renders without errors**

```bash
quarto render 08_slides.qmd
```

Expected: HTML output produced with no errors. Warnings about missing refs are acceptable if the slides look correct.

- [ ] **Step 3: Commit**

```bash
git add 08_slides.qmd
git commit -m "feat: add wk8 GDP slides with hedonic pricing and nails exercise"
```

---
