

## [SQL Joins and Aggregations in the Taxi Dataset](https://www.youtube.com/watch?v=QEcps_iskgg&list=PL3MmuxUbc_hJed7dXYoJw8DoCuVHhGEQb&index=10)

### Video Summary

- **00:59 – Joining yellow taxi table with the zones lookup table (implicit inner join)**  
  Shows how to link trip records in (`yellow_taxi_data`) with location details in (`zones`) using an implicit join - so that we can have actual location names corresponding to the LocationIDs (which are just numbers right now)

  - yellow_taxi_data table contains pickup and dropoff LocationIDs (PULocationID and DOLocationID). The zones table maps the LocationIDs to the actual location names/neighborhoods - "Upper West Side" for example. 

  - Goal:  join yellow_taxi_data with zones so that instead of seeing PULocationID: 142, we'll get something like: PULocationID: 142 (Harlem-East)



- **05:20 – Using an explicit INNER JOIN**  
  Shows the preferred approach using `INNER JOIN ON` for clear, explicit join conditions.

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
