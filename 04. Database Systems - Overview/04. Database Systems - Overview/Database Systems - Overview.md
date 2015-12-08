## Database Systems - Overview

### 1. What database models do you know?
- I dont know any..jk - Object model, Document model, Relational model.

### 2. Which are the main functions performed by a Relational Database Management System (RDBMS)?
- Data dictionary.
- Data storage.
- Data transformation and presentation.
- Security management.
- Backup and recovery.
- Multiuser access control.

### 3. Define what is "table" in database terms.
- A table is a data structure used to organize information.

### 4.  Explain the difference between a primary and a foreign key.
- Primary key is used to set a unique identifier for each column while foreign keys are used to set a link between columns in different tables. 

### 5. Explain the different kinds of relationships between tables in relational databases.
- One to one - defines a relationship between two tables where a single record in one corresponds to the other

- One to many - a single record in one table has many corresponding records in another.

- Many to many - records in one table have many corresponding records in another

### 6. When is a certain database schema normalized? What are the advantages of normalized databases?
- A database schema is normalized when it does not contain duplicate data. You get better structure and it takes less space.

### 7.  What are database integrity constraints and when are they used?
They are used to define a set of rules for the db.

- Domain Integrity
- Entity Integrity Constraint
- Referential Integrity Constraint
- Foreign Key Integrity Constraint

### 8. Point out the pros and cons of using indexes in a database.
- Advantages - use the index for quick access to a db column.
- Disadvantages - index will affect the speed of adding and deleting records.

### 9. What's the main purpose of the SQL language?
- Provide a structured way of creating queries.

### 10. What are transactions used for?
- They are used to define a set of operations that need to happen for an operation to be performed. 

### 11. What is a NoSQL database?
- A NoSQL database provides a mechanism for storage and retrieval of data that is modeled in means other than the tabular relations used in relational databases. Motivations for this approach include simplicity of design, horizontal scaling, and finer control over availability. The data structures used by NoSQL databases (e.g. key-value, graph, or document) differ from those used in relational databases, making some operations faster in NoSQL and others faster in relational databases. 


### 12. Explain the classical non-relational data models.
- The non-relational data model would look more like a sheet of paper. In fact, the concept of one entity and all the data that pertains to that one entity is known in Mongo as a “document”, so truly this is a decent way to think about it. You just add things whenever you need them. Your software doesn’t need to know ahead of time, you don’t need to know ahead of time. It all just kind of works, provided you know what you’re doing on the software level.

### 13. Give few examples of NoSQL databases and their pros and cons.
- MongoDB. Open-source document database.
- CouchDB. Database that uses JSON for documents, JavaScript for MapReduce queries, and regular HTTP for an API.
- GemFire. Distributed data management platform providing dynamic scalability, high performance, and database-like persistence.
- Redis. Data structure server wherein keys can contain strings, hashes, lists, sets, and sorted sets.
- Cassandra. Database that provides scalability and high availability without compromising performance. memcached. Open source high-performance, distributed-memory, and object-caching system.

