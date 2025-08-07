

## [SQL Joins and Aggregations in the Taxi Dataset](https://www.youtube.com/watch?v=QEcps_iskgg&list=PL3MmuxUbc_hJed7dXYoJw8DoCuVHhGEQb&index=10)

## Exploring NYC Taxi Dataset in pgAdmin

 ### Joining yellow taxi table with the zones lookup table 
  - How to link (`yellow_taxi_trips`) with location details in (`zones`) using an implicit join - so that we can have actual location names corresponding to the LocationIDs (which are just numbers right now)

  - `yellow_taxi_trips` table contains pickup and dropoff LocationIDs (PULocationID and DOLocationID). 
  - `zones` table maps the LocationIDs to the actual location names/neighborhoods - "Upper West Side" 

  - **Goal:**  Join yellow_taxi_data with zones so that instead of seeing PULocationID: 142, we'll get something like: PULocationID: 142 (Harlem-East)

**Best Practice: Use Explicit INNER JOIN**
``` sql SELECT 
    t.tpep_pickup_datetime, 
    t.tpep_dropoff_datetime, 
    t.total_amount, 
    CONCAT(zpu."Borough", '/', zpu."Zone") AS pickup_loc, 
    CONCAT(zdo."Borough", '/', zdo."Zone") AS dropoff_loc
    FROM 
    yellow_taxi_trips t
    INNER JOIN zones zpu ON t."PULocationID" = zpu."LocationID"
    INNER JOIN zones zdo ON t."DOLocationID" = zdo."LocationID"
    LIMIT 100
```

### Concept of a SET 
- A **set** is a collection of **unique** values — no duplicates, no specific order.

- If you have a table column like PULocationID, run this query: 
``` sql SELECT 
    DISTINCT PULocationID
    FROM yellow_taxi_trips; 
```
- You create a SET of all UNIQUE pickup LocationIDs (PULocationID)

 - And then if you say: 

``` sql WHERE PULocationID 
    NOT IN (SELECT LocationID FROM zones) 
```
- You're doing a set difference: Show me all pickup IDs in the trips table that aren’t in the zones table.
i.e. What’s in one set but not the other.





--

- **06:05 – Checking for records with Location IDs not in the zones table**  
  Runs a query to identify taxi records with `LocationID`s that don’t exist in the zones table — a sanity check for data quality.

- **06:45 – Checking for Location IDs in the zones table not in the yellow taxi table**  
  Reverses the previous check — finding zones that never appear in the trip data, which could indicate unused or underused zones.

- **07:51 – Using LEFT, RIGHT, and OUTER JOINs**  
  Explains how and when to use different types of joins (left, right, full outer), especially when data may be missing on one side.

- **10:53 – Using GROUP BY to calculate number of trips per day**  
  Groups trips by date to count how many occurred each day — a common aggregation for time-based analysis.

- **12:20 – Using ORDER BY**  
  Adds sorting to the grouped results to identify trends or find peak days.

- **13:27 – Other kinds of aggregations**  
  Discusses other aggregate functions (`SUM`, `AVG`, `MAX`, etc.) for calculating metrics like total fare or average distance.

- **14:03 – Grouping by multiple fields**  
  Demonstrates how to group by more than one column (e.g., pickup date and zone) for more granular analysis.

- **15:26 – Closing**  
  Wraps up the session, summarizing how to enrich, clean, and analyze datasets using SQL joins and aggregations.

 ### Appendix - Implicit JOIN - not best practice 
- Here we are telling the taxi table to join on the zones table twice (once for pickup location and once for  dropoff) by giving each use a different alias (zpu and zdo). 

    - Joining yellow_taxi_trips → to zones (as zpu) for the pickup info

    - Joining yellow_taxi_trips → to zones (as zdo) for the dropoff info

*This is not the ideal method. If you forget a JOIN it creates a Cartesian product...*

 **WTF is a Cartesian Product?** 
- Result of joining two or more tables WITHOUT a join condition 
- Literally multiplies every row in table A with every row in TABLE B. 

**Why is it bad** 
- It explodes your row count and memory and slows queries massively. 