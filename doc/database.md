# Technical Requirements
based on Business Requirements, see README

- ensure high quality data
- important read operations
  - enable fast reading for data analytics dashboard
  - retrieve customer data
    - customer history
    - for product recommendations / ML Clustering!
  - retrieve product data
    - price
  - retrieve shipment data
- important write operations 
  - existing customer places a new order
  - new customer places a new order
- Do's
  - monitor query performances

# Database Design Considerations
- In this scenrio, the database shall be the single source of truth for the company at this point of time.
  - Therefore, it has to combine design aspects for fast reading and writing.
- In order to ensure a high data quality, implement constraints.
- 
  - Can you explain why dividing the information into several tables is preferable to keeping it in a single table?
  - How would you manage tables with unique rows such as customers, products, etc.?
  - Is there any need to engineer new columns in any of the tables that are not available in the Sample-Superstore.csv (e.g. Supplier price)?
- 

## Technical Roadmap
- first step 
  - create an intuitive split up of the large table
  - test and see if the data base performs well
- second step
  - connect to analytics system
- third step
  - migrate

