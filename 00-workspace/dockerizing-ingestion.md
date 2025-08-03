# Run Ingestion on Docker

> This guide covers turning a local ingestion script into a Dockerized service with Docker Compose. It covers script cleanup, image building, setting up containers, and running everything locally.

---
## 🧰 1. Convert Manual Ingestion Notebook to Python Script
- Move logic from `.ipynb` to `.py` (e.g.`upload-data.ipynb` to `ingest_data.py`)
- jupyter nbconvert --to=script upload-data.py
- Ensure it accepts CLI args via `argparse`
- Add an `if __name__ == "__main__"` guard

## 🧪 2. Test Script Locally
- Run the ingestion script manually from CLI with correct arguments: 
  - Database user, password, host, port, and name
  - Target table name
  - CSV file URL to ingest
- Make sure it downloads data and loads into Postgres successfully
  Example:
  ```bash
  python ingest_data.py \
    --user=root \
    --password=root \
    --host=localhost \
    --port=5432 \
    --db=ny_taxi \
    --table_name=green_taxi_data \
    --url=https://some-url.com/data.csv