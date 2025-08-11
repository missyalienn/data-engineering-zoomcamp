# Manual Ingestion Notes 📝

> Covers setup through initial data ingestion using a Jupyter notebook (not yet dockerized)

## 🎥 Videos   
- [1.2.1 Intro to Docker](https://www.youtube.com/watch?v=EYNwNlOrpr0&list=PL3MmuxUbc_hJed7dXYoJw8DoCuVHhGEQb&index=41)  
- [1.2.2 Ingesting NYC Taxi Data into Postgres (Manual)](https://www.youtube.com/watch?v=2JM-ziJt0WI&list=PL3MmuxUbc_hJed7dXYoJw8DoCuVHhGEQb&index=6)  

Context: Step-by-step from setting up Postgres Docker container, downloading and reading CSV data w pandas, creating schema for postgres, and ingesting data manually via jupyter notebook. 

## 🎯 Key Topics  
- Running Postgres and pgAdmin containers with Docker 🐳  
- Loading and ingesting CSV data using pandas and SQLAlchemy 🐍  
- Connecting pgAdmin GUI to Postgres inside Docker and exploring data 🔗

## 🛠️ Workflow Summary  
- Start Postgres container using Docker Compose  
- Download NYC Taxi CSV data and load it in Jupyter Notebook with pandas  
- Define and create database schema and tables via SQLAlchemy in notebook  
- Manually insert CSV data into Postgres through notebook scripts  
- Add pgAdmin container to Docker Compose and connect it to Postgres container  
- Use pgAdmin UI to explore and verify the ingested data  

## 🐳 pgAdmin Server Connection & Docker Networking  
When pgAdmin and Postgres run as Docker containers:  

- `localhost` inside a container refers to the container itself, not your host machine or other containers.  
- Use the Postgres service name from your Docker Compose (`postgres` or your service’s actual name) as the **Host name/address** when setting up the server connection in pgAdmin.  
- Docker Compose sets up an internal network so containers can communicate by these service names automatically.  

**TL;DR:** Always connect pgAdmin to Postgres using the Docker service name, not `localhost`.

## 💡 Key Takeaways  
- Docker simplifies running isolated Postgres and pgAdmin services  
- Manual ingestion in notebook helps validate data flow before automation  
- “localhost” inside containers is different than host machine—critical for DB connections  
- Correct Docker Compose environment syntax and image tags are vital  
- pgAdmin’s “Servers” are just connection configs, not separate servers  

## 🐞 Debug Moments  
- Mistyped pgAdmin image tag as `dpage/pgadmin14` instead of `dpage/pgadmin4`  
- Environment variables in Docker Compose need correct YAML formatting (`key: value` vs `- key=value`)  
- Initially tried `localhost` for Postgres host in pgAdmin, which failed due to container networking rules  

## 🛠️ Tech Stack & Components  
- Docker (Postgres & pgAdmin containers) 🐳  
- Python (pandas, SQLAlchemy) 🐍  
- Jupyter Notebook for exploration and ingestion scripts 📓  
- NYC Taxi CSV dataset 🚕  