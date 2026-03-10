# Real Wages Exercise Implementation Plan

> **For Claude:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task.

**Goal:** Build a printable Quarto PDF exercise giving students simulated "Parliamentary Report" tables to construct a real wage index for England 1770–1850.

**Architecture:** A standalone R script (`generate_data.R`) writes 9 CSV files to `data/`. A parametrized Quarto document (`real-wages-exercise.qmd`) loads those CSVs and renders them as `booktabs` LaTeX tables. A `params: solutions` flag controls whether an answer-key section (with LaTeX equations and R computation) is included.

**Tech Stack:** R (base only for data generation), Quarto, knitr, kableExtra, ggplot2

---

## Reference: Simulated Data Values

All monetary values in £ decimal. Units chosen for readability.

### London wages (£/week)
| Industry | 1770 | 1790 | 1810 | 1830 | 1850 |
|---|---|---|---|---|---|
| Agriculture | 0.45 | 0.50 | 0.55 | 0.60 | 0.70 |
| Textiles | 0.60 | 0.70 | 0.70 | 0.65 | 0.90 |
| Building & Construction | 0.70 | 0.80 | 0.90 | 0.95 | 1.10 |
| Mining | 0.65 | 0.75 | 0.85 | 0.90 | 1.00 |
| Domestic Service | 0.35 | 0.40 | 0.45 | 0.50 | 0.60 |

### Northern Counties wages (£/week)
| Industry | 1770 | 1790 | 1810 | 1830 | 1850 |
|---|---|---|---|---|---|
| Agriculture | 0.35 | 0.40 | 0.45 | 0.45 | 0.50 |
| Textiles | 0.50 | 0.60 | 0.55 | 0.50 | 0.70 |
| Building & Construction | 0.55 | 0.65 | 0.75 | 0.80 | 0.90 |
| Mining | 0.55 | 0.65 | 0.75 | 0.80 | 0.95 |
| Domestic Service | 0.25 | 0.30 | 0.35 | 0.40 | 0.45 |

### National employment shares (%)
| Industry | 1770 | 1790 | 1810 | 1830 | 1850 |
|---|---|---|---|---|---|
| Agriculture | 40 | 36 | 32 | 28 | 22 |
| Textiles | 18 | 20 | 22 | 22 | 20 |
| Building & Construction | 10 | 11 | 11 | 12 | 13 |
| Mining | 5 | 6 | 7 | 8 | 10 |
| Domestic Service | 27 | 27 | 28 | 30 | 35 |

### Wheat prices (£/quarter)
| Region | 1770 | 1790 | 1810 | 1830 | 1850 |
|---|---|---|---|---|---|
| London | 2.00 | 2.40 | 5.25 | 3.40 | 2.75 |
| Northern Counties | 1.80 | 2.20 | 4.80 | 3.10 | 2.50 |

### National commodity prices
| Commodity | Unit | 1770 | 1790 | 1810 | 1830 | 1850 |
|---|---|---|---|---|---|---|
| Meat | £/stone | 0.25 | 0.30 | 0.45 | 0.35 | 0.30 |
| Vegetables | £/stone | 0.08 | 0.09 | 0.14 | 0.11 | 0.09 |
| Beer | £/dozen quarts | 0.20 | 0.22 | 0.30 | 0.25 | 0.22 |
| Candles & fuel | £/dozen lbs | 0.55 | 0.60 | 0.85 | 0.70 | 0.60 |
| Woollen cloth | £/yard | 0.35 | 0.38 | 0.50 | 0.40 | 0.32 |

### Weekly rent (£/week)
| Region | 1770 | 1790 | 1810 | 1830 | 1850 |
|---|---|---|---|---|---|
| London | 0.10 | 0.12 | 0.18 | 0.20 | 0.25 |
| Northern Counties | 0.05 | 0.06 | 0.09 | 0.10 | 0.12 |

### Budget shares (%) — one row, seven columns
Bread/grain 35, Meat 12, Vegetables 6, Beer 8, Fuel & candles 7, Rent 20, Clothes 12

### Textile unemployment (weeks unemployed per year)
1770: 2, 1790: 3, 1810: 5, 1830: 9, 1850: 4

### Female labour force participation (%)
| Industry | 1770 | 1790 | 1810 | 1830 | 1850 |
|---|---|---|---|---|---|
| Agriculture | 15 | 13 | 11 | 9 | 7 |
| Textiles | 42 | 45 | 38 | 35 | 40 |
| Building & Construction | 2 | 2 | 1 | 1 | 1 |
| Mining | 8 | 7 | 6 | 5 | 4 |
| Domestic Service | 68 | 70 | 72 | 74 | 76 |

---

## Task 1: Create directory structure and write generate_data.R

**Files:**
- Create: `data/` (directory)
- Create: `generate_data.R`

**Step 1: Create the data directory**

```bash
mkdir -p real-wages-exercise/data
```

Expected: directory exists

**Step 2: Write generate_data.R**

Create `real-wages-exercise/generate_data.R` with the following content. All values come from the reference table above.

```r
# generate_data.R
# Generates simulated primary source data for the real wages exercise.
# Run this script once to populate the data/ directory.
# All monetary values are in £ (decimal).

dates <- c(1770, 1790, 1810, 1830, 1850)

# --- Table 1: London wages (£/week) ---
wages_london <- data.frame(
  Industry = c("Agriculture", "Textiles", "Building & Construction",
               "Mining", "Domestic Service"),
  `1770` = c(0.45, 0.60, 0.70, 0.65, 0.35),
  `1790` = c(0.50, 0.70, 0.80, 0.75, 0.40),
  `1810` = c(0.55, 0.70, 0.90, 0.85, 0.45),
  `1830` = c(0.60, 0.65, 0.95, 0.90, 0.50),
  `1850` = c(0.70, 0.90, 1.10, 1.00, 0.60),
  check.names = FALSE
)
write.csv(wages_london, "data/wages_london.csv", row.names = FALSE)

# --- Table 2: Northern Counties wages (£/week) ---
wages_northern <- data.frame(
  Industry = c("Agriculture", "Textiles", "Building & Construction",
               "Mining", "Domestic Service"),
  `1770` = c(0.35, 0.50, 0.55, 0.55, 0.25),
  `1790` = c(0.40, 0.60, 0.65, 0.65, 0.30),
  `1810` = c(0.45, 0.55, 0.75, 0.75, 0.35),
  `1830` = c(0.45, 0.50, 0.80, 0.80, 0.40),
  `1850` = c(0.50, 0.70, 0.90, 0.95, 0.45),
  check.names = FALSE
)
write.csv(wages_northern, "data/wages_northern.csv", row.names = FALSE)

# --- Table 3: National employment shares (%) ---
employment_shares <- data.frame(
  Industry = c("Agriculture", "Textiles", "Building & Construction",
               "Mining", "Domestic Service"),
  `1770` = c(40, 18, 10, 5, 27),
  `1790` = c(36, 20, 11, 6, 27),
  `1810` = c(32, 22, 11, 7, 28),
  `1830` = c(28, 22, 12, 8, 30),
  `1850` = c(22, 20, 13, 10, 35),
  check.names = FALSE
)
write.csv(employment_shares, "data/employment_shares.csv", row.names = FALSE)

# --- Table 4: Wheat prices by region (£/quarter) ---
prices_wheat <- data.frame(
  Region = c("London", "Northern Counties"),
  `1770` = c(2.00, 1.80),
  `1790` = c(2.40, 2.20),
  `1810` = c(5.25, 4.80),
  `1830` = c(3.40, 3.10),
  `1850` = c(2.75, 2.50),
  check.names = FALSE
)
write.csv(prices_wheat, "data/prices_wheat.csv", row.names = FALSE)

# --- Table 5: National commodity prices ---
prices_national <- data.frame(
  Commodity = c("Meat", "Vegetables", "Beer", "Candles & Fuel",
                "Woollen Cloth"),
  Unit = c("£/stone", "£/stone", "£/dozen quarts",
           "£/dozen lbs", "£/yard"),
  `1770` = c(0.25, 0.08, 0.20, 0.55, 0.35),
  `1790` = c(0.30, 0.09, 0.22, 0.60, 0.38),
  `1810` = c(0.45, 0.14, 0.30, 0.85, 0.50),
  `1830` = c(0.35, 0.11, 0.25, 0.70, 0.40),
  `1850` = c(0.30, 0.09, 0.22, 0.60, 0.32),
  check.names = FALSE
)
write.csv(prices_national, "data/prices_national.csv", row.names = FALSE)

# --- Table 6: Weekly rent by region (£/week) ---
prices_rent <- data.frame(
  Region = c("London", "Northern Counties"),
  `1770` = c(0.10, 0.05),
  `1790` = c(0.12, 0.06),
  `1810` = c(0.18, 0.09),
  `1830` = c(0.20, 0.10),
  `1850` = c(0.25, 0.12),
  check.names = FALSE
)
write.csv(prices_rent, "data/prices_rent.csv", row.names = FALSE)

# --- Table 7: Budget shares (%) ---
budget_shares <- data.frame(
  Category = c("Bread & Grain", "Meat", "Vegetables", "Beer",
               "Fuel & Candles", "Rent", "Clothing"),
  Share = c(35, 12, 6, 8, 7, 20, 12)
)
write.csv(budget_shares, "data/budget_shares.csv", row.names = FALSE)

# --- Table 8: Textile unemployment (weeks/year) ---
unemployment_textiles <- data.frame(
  `1770` = 2, `1790` = 3, `1810` = 5, `1830` = 9, `1850` = 4,
  check.names = FALSE
)
write.csv(unemployment_textiles, "data/unemployment_textiles.csv",
          row.names = FALSE)

# --- Table 9: Female labour force participation (%) ---
female_lfp <- data.frame(
  Industry = c("Agriculture", "Textiles", "Building & Construction",
               "Mining", "Domestic Service"),
  `1770` = c(15, 42, 2, 8, 68),
  `1790` = c(13, 45, 2, 7, 70),
  `1810` = c(11, 38, 1, 6, 72),
  `1830` = c(9, 35, 1, 5, 74),
  `1850` = c(7, 40, 1, 4, 76),
  check.names = FALSE
)
write.csv(female_lfp, "data/female_lfp.csv", row.names = FALSE)

cat("Done. 9 CSV files written to data/\n")
```

**Step 3: Run the script**

```bash
cd real-wages-exercise
Rscript generate_data.R
```

Expected output: `Done. 9 CSV files written to data/`

**Step 4: Verify CSVs exist**

```bash
ls data/
```

Expected: 9 `.csv` files listed.

**Step 5: Commit**

```bash
git add generate_data.R data/
git commit -m "feat: add data generation script and simulated CSVs"
```

---

## Task 2: Create the Quarto document skeleton

**Files:**
- Create: `real-wages-exercise.qmd`

**Step 1: Write the YAML header and preamble**

Create `real-wages-exercise.qmd` starting with:

```yaml
---
title: |
  Primary Sources for the Study of Real Wages \
  in England, 1770--1850
subtitle: "Selected Parliamentary Reports and Statistical Returns"
date: "c. 1851"
format:
  pdf:
    documentclass: article
    fontsize: 11pt
    geometry: "margin=1in"
    keep-tex: false
    include-in-header:
      text: |
        \usepackage{booktabs}
        \usepackage{longtable}
        \usepackage{array}
        \usepackage{amsmath}
params:
  solutions: false
---
```

Then add a short introductory block (plain markdown, not in a code chunk):

```markdown
The following tables are drawn from parliamentary inquiries and Board of
Trade returns compiled between 1770 and 1851. They are arranged by subject.
Students should note that these reports were produced at different times and
by different investigators; some inconsistencies in coverage and definition
should be expected.
```

**Step 2: Verify the document compiles (tables section empty)**

```bash
quarto render real-wages-exercise.qmd -P solutions:false
```

Expected: a PDF with title page and introductory paragraph, no errors.

**Step 3: Commit skeleton**

```bash
git add real-wages-exercise.qmd
git commit -m "feat: add Quarto document skeleton with YAML params"
```

---

## Task 3: Add all 9 tables to the document

**Files:**
- Modify: `real-wages-exercise.qmd`

Add all table code chunks after the introductory paragraph. Each chunk
follows the pattern below. Note: `echo: false` suppresses the R code in
the PDF; `message: false` suppresses kableExtra startup messages.

Add a single setup chunk first (right after the YAML, before the intro text):

````markdown
```{r}
#| include: false
library(knitr)
library(kableExtra)
```
````

Then add the following 9 table chunks in order.

**Table 1 — London wages:**

````markdown
## Parliamentary Report on Wages in London Industries

*Report of the Select Committee on Wages and Employment, 1851.
Weekly wages in pounds sterling for adult male workers.*

```{r}
#| echo: false
#| message: false
df <- read.csv("data/wages_london.csv", check.names = FALSE)
kable(df, booktabs = TRUE, align = c("l", rep("r", 5)),
      caption = "London: Weekly Wages by Industry (£/week)") |>
  kable_styling(latex_options = c("hold_position", "striped"), font_size = 10)
```
````

**Table 2 — Northern Counties wages:**

````markdown
## Parliamentary Report on Wages in the Northern Counties

*Report of the Factory Inspectors and Poor Law Commissioners, 1851.
Weekly wages in pounds sterling for adult male workers.*

```{r}
#| echo: false
df <- read.csv("data/wages_northern.csv", check.names = FALSE)
kable(df, booktabs = TRUE, align = c("l", rep("r", 5)),
      caption = "Northern Counties: Weekly Wages by Industry (£/week)") |>
  kable_styling(latex_options = c("hold_position", "striped"), font_size = 10)
```
````

**Table 3 — Employment shares:**

````markdown
## Parliamentary Report on Employment by Industry, England and Wales

*Derived from decennial census returns and Board of Trade inquiries.
Figures represent percentage of the occupied male population.*

```{r}
#| echo: false
df <- read.csv("data/employment_shares.csv", check.names = FALSE)
kable(df, booktabs = TRUE, align = c("l", rep("r", 5)),
      caption = "National Employment Shares by Industry (\\%)") |>
  kable_styling(latex_options = c("hold_position", "striped"), font_size = 10)
```
````

**Table 4 — Wheat prices:**

````markdown
## Parliamentary Report on Grain Prices in London and Northern Markets

*Report of the Corn Committee, compiled from returns of market inspectors.
Prices are for one quarter (8 bushels) of best wheaten grain.*

```{r}
#| echo: false
df <- read.csv("data/prices_wheat.csv", check.names = FALSE)
kable(df, booktabs = TRUE, align = c("l", rep("r", 5)),
      caption = "Wheat Prices by Region (£/quarter)") |>
  kable_styling(latex_options = c("hold_position", "striped"), font_size = 10)
```
````

**Table 5 — National commodity prices:**

````markdown
## Parliamentary Report on Retail Prices of Selected Commodities

*Select Committee on Artisan Conditions, 1851. Prices collected from
retail markets in five major English towns and averaged nationally.*

```{r}
#| echo: false
df <- read.csv("data/prices_national.csv", check.names = FALSE)
kable(df, booktabs = TRUE, align = c("l", "l", rep("r", 5)),
      caption = "National Retail Prices of Selected Commodities") |>
  kable_styling(latex_options = c("hold_position", "striped"), font_size = 10)
```
````

**Table 6 — Regional rent:**

````markdown
## Parliamentary Report on Weekly Rents by Region

*Report of the Poor Law Commissioners on the Condition of Labouring
Families, 1851. Typical rent for a two-room labourer's dwelling.*

```{r}
#| echo: false
df <- read.csv("data/prices_rent.csv", check.names = FALSE)
kable(df, booktabs = TRUE, align = c("l", rep("r", 5)),
      caption = "Weekly Dwelling Rents by Region (£/week)") |>
  kable_styling(latex_options = c("hold_position", "striped"), font_size = 10)
```
````

**Table 7 — Budget shares:**

````markdown
## Parliamentary Report on Expenditure of Labouring Families

*Drawn from the household budgets collected by Eden (1797) and
subsequent Board of Trade surveys. Figures represent average
expenditure shares for a family of four in England.*

```{r}
#| echo: false
df <- read.csv("data/budget_shares.csv", check.names = FALSE)
kable(df, booktabs = TRUE, align = c("l", "r"),
      col.names = c("Category of Expenditure", "Budget Share (\\%)"),
      caption = "Household Expenditure Shares, Labouring Families") |>
  kable_styling(latex_options = c("hold_position", "striped"), font_size = 10)
```
````

**Table 8 — Textile unemployment:**

````markdown
## Parliamentary Report on Employment Conditions in the Textile Industry

*Report of the Factory Inspectors, various years. Figures represent
the estimated average number of weeks per year in which a textile
worker could expect to find no paid employment.*

```{r}
#| echo: false
df <- read.csv("data/unemployment_textiles.csv", check.names = FALSE)
kable(df, booktabs = TRUE, align = rep("r", 5),
      caption = "Textile Industry: Estimated Weeks Unemployed per Year") |>
  kable_styling(latex_options = c("hold_position"), font_size = 10)
```
````

**Table 9 — Female LFP:**

````markdown
## Parliamentary Report on Female Employment in Selected Industries

*Select Committee on the Employment of Women and Children, 1851.
Figures represent the share of the female population of working age
(15--60) recorded as gainfully employed in each industry.*

```{r}
#| echo: false
df <- read.csv("data/female_lfp.csv", check.names = FALSE)
kable(df, booktabs = TRUE, align = c("l", rep("r", 5)),
      caption = "Female Labour Force Participation by Industry (\\%)") |>
  kable_styling(latex_options = c("hold_position", "striped"), font_size = 10)
```
````

**Step after adding all tables: render and inspect**

```bash
quarto render real-wages-exercise.qmd -P solutions:false
```

Expected: 9 tables render with `booktabs` formatting, no R code visible,
no error messages.

**Commit:**

```bash
git add real-wages-exercise.qmd
git commit -m "feat: add all 9 Parliamentary Report tables to exercise"
```

---

## Task 4: Add the solutions section

**Files:**
- Modify: `real-wages-exercise.qmd`

Append the following block after the last table. The `eval` and `echo`
options are controlled by `params$solutions` so this section only appears
and executes in the teacher edition.

First, add the page-break and section header:

````markdown
`r if (params$solutions) "\\newpage"`

```{r}
#| echo: false
#| eval: !expr params$solutions
# Nothing here — the newpage above handles the break.
# The conditional rendering uses the params$solutions parameter.
```
````

Then add the methodology section with LaTeX equations:

````markdown
```{=latex}
```
````

Wait — the LaTeX equations should be inside a conditional block. The
cleanest approach in Quarto is to use an `asis` chunk:

````markdown
```{r}
#| echo: false
#| eval: !expr params$solutions
#| results: asis
cat("
## Solutions: Constructing the Real Wage Index

### Methodology

We construct three indices, each with base year 1770 (= 1.00).

**1. Cost of Living Index**

Let $C$ denote the set of $n$ commodities in the consumption basket,
$w_i$ the budget share of commodity $i$ (with $\\sum_i w_i = 1$),
and $p_{i,t}$ the price of commodity $i$ at date $t$. The cost of
living index is a Laspeyres price index with fixed 1770 weights:

$$P_t = \\sum_{i=1}^{n} w_i \\frac{p_{i,t}}{p_{i,0}}$$

where $t = 1770, 1790, 1810, 1830, 1850$ and $t_0 = 1770$.

**2. Nominal Wage Index**

Let $J$ denote the set of $m$ industries, $s_{j,t}$ the employment
share of industry $j$ at date $t$ (with $\\sum_j s_{j,t} = 1$),
and $\\bar{w}_{j,t}$ the wage in industry $j$ at date $t$. We form a
weighted average nominal wage at each date and express it relative to
1770:

$$W_t = \\frac{\\sum_{j=1}^{m} s_{j,t}\\, \\bar{w}_{j,t}}{\\sum_{j=1}^{m} s_{j,0}\\, \\bar{w}_{j,0}}$$

Note that using contemporaneous employment weights $s_{j,t}$ makes
this a Paasche-type quantity index. An alternative is to hold
employment shares fixed at $s_{j,0}$ (Laspeyres). Students should
consider which choice is more appropriate.

**3. Real Wage Index**

$$RW_t = \\frac{W_t}{P_t}$$

A value above 1.00 indicates real wages higher than in 1770;
below 1.00 indicates lower real purchasing power.
")
```
````

Then add the R computation:

````markdown
```{r}
#| echo: true
#| eval: !expr params$solutions
#| message: false
library(knitr)
library(kableExtra)
library(ggplot2)

dates <- c(1770, 1790, 1810, 1830, 1850)

# --- Load data ---
wL <- read.csv("data/wages_london.csv",     check.names = FALSE)
wN <- read.csv("data/wages_northern.csv",   check.names = FALSE)
es <- read.csv("data/employment_shares.csv",check.names = FALSE)
pw <- read.csv("data/prices_wheat.csv",     check.names = FALSE)
pn <- read.csv("data/prices_national.csv",  check.names = FALSE)
pr <- read.csv("data/prices_rent.csv",      check.names = FALSE)
bs <- read.csv("data/budget_shares.csv",    check.names = FALSE)

# --- Nominal wages: national average of London and Northern ---
wage_mat <- (as.matrix(wL[, -1]) + as.matrix(wN[, -1])) / 2
share_mat <- as.matrix(es[, -1]) / 100

# Weighted average nominal wage at each date
W_abs <- colSums(wage_mat * share_mat)
W_index <- W_abs / W_abs[1]   # base 1770 = 1.00

# --- Cost of Living index ---
# Commodity prices: wheat (avg of regions), meat, veg, beer,
#                   candles, rent (avg of regions), clothes
wheat_avg <- colMeans(as.matrix(pw[, -1]))
rent_avg  <- colMeans(as.matrix(pr[, -1]))

# National prices matrix: rows = commodities, cols = dates
price_mat <- rbind(
  wheat   = wheat_avg,
  meat    = as.numeric(pn[pn$Commodity == "Meat",      -(1:2)]),
  veg     = as.numeric(pn[pn$Commodity == "Vegetables",-(1:2)]),
  beer    = as.numeric(pn[pn$Commodity == "Beer",       -(1:2)]),
  candles = as.numeric(pn[pn$Commodity == "Candles & Fuel", -(1:2)]),
  rent    = rent_avg,
  clothes = as.numeric(pn[pn$Commodity == "Woollen Cloth",  -(1:2)])
)

# Price relatives (each row divided by its 1770 value)
price_rel <- price_mat / price_mat[, 1]

# Budget weights (same order as rows above)
weights <- bs$Share / 100  # already sums to 1

P_index <- colSums(price_rel * weights)   # base 1770 = 1.00

# --- Real wage index ---
RW_index <- W_index / P_index

# --- Summary table ---
results <- data.frame(
  Year              = dates,
  `Nominal Wage Index` = round(W_index, 3),
  `Cost of Living Index` = round(P_index, 3),
  `Real Wage Index`      = round(RW_index, 3),
  check.names = FALSE
)

kable(results, booktabs = TRUE, align = c("r","r","r","r"),
      caption = "Real Wage Index, England 1770--1850 (1770 = 1.00)") |>
  kable_styling(latex_options = c("hold_position", "striped"))

# --- Plot ---
long <- data.frame(
  Year  = rep(dates, 3),
  Index = c(W_index, P_index, RW_index),
  Series = rep(c("Nominal Wage", "Cost of Living", "Real Wage"), each = 5)
)

ggplot(long, aes(x = Year, y = Index, colour = Series, linetype = Series)) +
  geom_line(linewidth = 1) +
  geom_point(size = 2) +
  geom_hline(yintercept = 1, linetype = "dotted", colour = "grey40") +
  scale_x_continuous(breaks = dates) +
  labs(title = "Real Wages in England, 1770-1850",
       subtitle = "1770 = 1.00",
       x = NULL, y = "Index (1770 = 1.00)",
       colour = NULL, linetype = NULL) +
  theme_minimal(base_size = 11) +
  theme(legend.position = "bottom")
```
````

**Step: Render both versions**

```bash
# Student handout — no solutions
quarto render real-wages-exercise.qmd -P solutions:false
# Teacher edition — with solutions
quarto render real-wages-exercise.qmd -P solutions:true
```

Expected for student version: PDF ends after Table 9, no equations, no R output.
Expected for teacher version: PDF has additional page with LaTeX equations,
R code, summary table, and line chart.

**Commit:**

```bash
git add real-wages-exercise.qmd
git commit -m "feat: add parametrized solutions section with equations and R computation"
```

---

## Task 5: Final check and clean up

**Step 1: Confirm both PDFs render cleanly with no warnings**

```bash
quarto render real-wages-exercise.qmd -P solutions:false  2>&1 | grep -i "warning\|error"
quarto render real-wages-exercise.qmd -P solutions:true   2>&1 | grep -i "warning\|error"
```

Expected: no output (no warnings or errors).

**Step 2: Commit final state**

```bash
git add .
git commit -m "feat: complete real wages exercise — tables and solutions"
```
