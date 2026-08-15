# 📊 SQL Learnings — Daily PostgreSQL Practice

A structured, daily log of SQL practice — built to strengthen query-writing skills for data analysis roles, and to document the reasoning behind each solution so it's useful as a reference, not just a record.

Each day covers a set of problems solved against a custom-built PostgreSQL dataset, with explanations of the concepts applied and why a particular approach was chosen over alternatives.

---

## 🎯 Purpose

This repository serves two goals:

1. **Practice** — consistent, hands-on SQL problem-solving across joins, aggregations, window functions, subqueries, and more.
2. **Reference** — each file is written to be readable on its own, so the queries and their logic can help others learning the same concepts, not just track personal progress.

---

## 🗂️ Dataset

All practice runs against a self-contained PostgreSQL schema — **17 tables** covering common business domains: customers, orders, products, order items, transactions, employees, subscriptions, stock trades, and more.

The dataset is intentionally designed with realistic messiness (NULLs, edge cases, inconsistent formats) so queries have to handle real-world conditions, not just clean textbook data.

📄 Schema and seed data: [`dataset/sql_practice_dataset.sql`](dataset/sql_practice_dataset.sql)

---

## 📁 Repository Structure

```
sql_learnings_postgres/
├── README.md
├── dataset/
│   └── sql_practice_dataset.sql     # Full schema + seed data (17 tables)
└── practice/
    ├── day01_joins_groupby.sql      # Day 1: JOINs, GROUP BY, HAVING
    ├── day02_....sql
    └── ...
```

Each practice file is self-contained: every query is commented with the question it answers, and can be run independently against the loaded dataset.

---

## 🗓️ Progress Log

| Day | Date | Focus Area | Key Concepts | File |
|---|---|---|---|---|
| 01 | 2026-08-15 | Joins & Aggregation | `INNER JOIN`, `LEFT JOIN`, `GROUP BY`, `HAVING`, `COUNT`, `SUM`, `AVG`, `COALESCE`, `CASE WHEN` | [day01_joins_groupby.sql](practice/day01_joins_groupby.sql) |

*Updated after each practice session — one row per day.*

---

## 🧠 Concepts Covered So Far

A running index of SQL concepts practiced across all days, for quick reference:

- **Joins:** `INNER JOIN`, `LEFT JOIN`
- **Aggregation:** `COUNT`, `SUM`, `AVG`, `GROUP BY`, `HAVING`
- **Conditional logic:** `CASE WHEN`, `COALESCE`

*(This section grows as new concepts are introduced in later days — window functions, CTEs, subqueries, self-joins, etc.)*

---

## 📝 Weekly Reflections

Short notes on patterns noticed, mistakes made, and what to revisit — added roughly every 5 days to track how understanding develops over time, not just what was completed.

**Week 1:**
- _Notes added as the week progresses._

---

## 🛠️ How to Run This Locally

1. Set up a PostgreSQL database.
2. Load the schema and seed data:
   ```
   psql -U <username> -d <database> -f dataset/sql_practice_dataset.sql
   ```
3. Run any file from `practice/` against that database — each query can be executed independently.

---

## 💡 Why a Daily Log

Consistency matters more than volume when building SQL fluency. This repo is a running record of that process — every session adds to a growing, reviewable body of practical query-writing experience.
