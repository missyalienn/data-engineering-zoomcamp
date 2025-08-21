# Airflow DAG for Data Ingestion – Summary

## Setting Up Airflow
- Use Docker Compose to quickly spin up Airflow in a local dev environment.
- Services include scheduler, webserver, and database for Airflow metadata.
- Modify `docker-compose.yaml` and Dockerfile if additional dependencies are needed.

## Creating a Simple DAG
- Start with a basic DAG definition using the `BashOperator`.
- Define task dependencies with `>>` or `<<`.
- Test the DAG by triggering it manually in the Airflow UI.

## Parameterizing and Scheduling
- Add parameters such as execution date and file names using Jinja templating.
- Apply cron expressions for flexible scheduling (e.g., hourly, daily).
- Ensure DAGs are idempotent—re-running should not break or duplicate results.

## Debugging and Logs
- Logs are available in the Airflow UI for each task.
- Use container `exec` to enter the Airflow environment and debug files or paths.
- Pay attention to environment variables and directories (e.g., `/tmp`) when tasks create files.

## Downloading Data in the DAG
- Use Bash commands (`wget`, `curl`) in tasks to fetch data from external URLs.
- Parameterize file names and locations to align with task execution dates.
- Verify downloaded files inside the container for correctness.

## Integrating Python Scripts
- Move ingestion logic from a standalone Python script into Airflow.
- Use `DockerOperator` or `PythonOperator` to run the ingestion code.
- Update `requirements.txt` and the Airflow Dockerfile to include necessary dependencies.

## Database Integration
- Ensure Postgres is available and accessible from Airflow containers.
- Use environment variables for database credentials rather than hardcoding.
- Validate ingestion by connecting to Postgres with `pgcli` or similar tools.

## Best Practices
- Keep DAGs simple and modular—one DAG should represent one logical workflow.
- Make tasks idempotent for safe retries.
- Use templating for dynamic parameters (dates, file names).
- Separate config (URLs, DB credentials) from code using environment variables.
- Debug in dev containers before thinking about scaling to production.