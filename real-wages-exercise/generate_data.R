# generate_data.R
# Generates simulated primary source data for the real wages exercise.
# Run this script once to populate the data/ directory.
# All monetary values are in £ (decimal).

if (!dir.exists("data")) stop("Run this script from the repo root (where data/ exists).")

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
# Single row: overall share of women aged 15-60 in paid employment.
# Declining trend reflects withdrawal from market labour over industrialisation.
female_lfp <- data.frame(
  `1770` = 38, `1790` = 34, `1810` = 30, `1830` = 26, `1850` = 24,
  check.names = FALSE
)
write.csv(female_lfp, "data/female_lfp.csv", row.names = FALSE)

cat("Done. 9 CSV files written to data/\n")
