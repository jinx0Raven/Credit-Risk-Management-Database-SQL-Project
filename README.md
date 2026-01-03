Credit Risk Management Database Project

Overview
This project demonstrates how a relational SQL database can be designed and queried to analyze credit risk in a banking environment. The database models core banking entities such as customers, accounts, loans, payments, credit scores, and risk assessments, enabling analysis of delinquency, defaults, and customer risk profiles.

The focus of the project is on answering real-world credit risk questions using SQL rather than simple data storage.

Dataset
Sample banking-style data inspired by public Kaggle credit risk datasets was used to simulate realistic customer, loan, and payment behavior.

Database Design
The database is designed with normalized tables and clear relationships that reflect real banking systems:
Customers and their accounts
Loans linked to accounts
Payment schedules and actual payments
Credit scores tracked over time
Manual risk assessments per customer

Business Questions Answered
Identify customers with late or missed payments
Analyze loan exposure by status such as active, late, paid, or defaulted
Track changes in customer credit scores over time
Identify high-risk customers with active loans
Measure outstanding balances and payment performance
Analyze loan distribution by type and risk level

Skills Demonstrated
SQL table design and normalization
Primary and foreign key relationships
Complex joins across multiple tables
Aggregation and grouping for risk analysis
Data quality checks and validation queries
Business-oriented querying for credit risk use cases

Tools
SQL (MySQL, PostgreSQL, or SQLite compatible)
