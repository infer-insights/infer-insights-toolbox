# Data Extraction & Analytics Engineering Toolbox

This repository is a collection of code templates and reference patterns for data extraction, transformation, and measure design — spanning DAX, M, SQL and corporate grade analytics environment - Snowflake. 
Rather than solving one specific business case, it documents the underlying engineering practices and how logic is organized across each layer of an analytics pipeline.

---

## Repository Components

### `measures-applied.dax` — Measures & Analytics
DAX patterns focused on scalable calculation design. The emphasis is on clear, self-explanatory naming so logic stays maintainable as business rules grow more complex.

### `power-query-etl-lib.m` — Power Query / ETL
Examples of cleaning, shaping, and combining data from multiple source systems before it reaches the data model.

### `practis-queries.sql` — Relational Data Extraction
Patterns for extracting data and pre-calculating measures directly at the SQL layer, ahead of the visualization tool — keeping the reporting layer lighter and moving logic closer to the source.

### `snowflake-memo.sql` — Cloud Data Warehousing
Early-stage scripts exploring the Snowflake environment, currently focused on basic structure, role-based access, and data governance fundamentals. 



---

## Engineering Principles

- **Business-driven logic** — Performance matters, but not at the expense of correctness. The design allows for added complexity where the underlying business rules genuinely require it.
- **Readability and maintainability** — Descriptive naming and inline documentation, so the logic stays easy to follow over time.
- **Logic placement** — Where practical, calculations are pushed upstream (e.g., into SQL) rather than left for the visualization layer to handle.

---

## License

MIT License — free to use, modify, or adapt.