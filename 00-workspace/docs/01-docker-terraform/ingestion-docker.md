# Run Ingestion on Docker

### TO DO : FINISH THE DOCS 
 - Add code examples and commands to Deep Dive section 

> This guide summarizes the key steps to take a local ingestion script and containerize it with Docker using `docker-compose`. It’s based on the DataTalks DE Zoomcamp walkthrough.

## ✅ Step-by-Step Process

| | **Build Steps** | **Why?** |
|----------|------------------|---------------------|
| 1. | Convert Jupyter notebook to a `.py` script | Jupyter notebooks fine for dev, not for prod. Need a proper Python script that can be containerized and run automatically. |
| 2. | Test ingestion script locally | Make sure it actually works before containerizing it. Validate DB connection and script logic. Ensure total rows ingested is the same as the manual script from earlier / ensure no duplicates etc. |
| 3. | Add the ingestion script as a new **service** in `docker-compose.yaml`| This creates a container that runs the ingestion script on the same Docker network as Postgres, so it can connect using Postgres service name (e.g., pg-database). allows the script to ingest data into Postgres without exposing ports externally.
| 4. | Build and run all containers with `docker-compose up --build`| Rebuilds images (needed if Dockerfile or scripts changed) and spins up Postgres, PgAdmin, and ingestion script container together. |
| 5. | Check PgAdmin or Postgres CLI to confirm ingestion | Verify that the Dockerized script worked end to end and loaded data into the target table. |
| 6. | Add a **volume** to persist PgAdmin state (optional but useful) | Keeps your server connection config so you don’t re-add it every time. |
| 7. | Repeat the pattern with other files (e.g., `zones.csv`) | Use a separate ingestion script (`zones.py`) to create a new table (`zones`) in the DB. |
| 8. | Confirm ingestion again via PgAdmin | Always verify. Data’s not real until it shows up. |


## Deep Dive


## 🧰 1. Convert Manual Ingestion Notebook to Python Script
- Move logic from `.ipynb` to `.py` (e.g.`upload-data.ipynb` to `ingest_data.py`)
- jupyter nbconvert --to=script upload-data.py
- Ensure it accepts CLI args via `argparse`
- Add an `if __name__ == "__main__"` guard