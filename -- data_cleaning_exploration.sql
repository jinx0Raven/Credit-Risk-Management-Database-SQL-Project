-- =============================================
-- Data Cleaning & Exploration
-- =============================================

-- 1. Check for duplicate customers
SELECT CustomerID, COUNT(*) AS Count
FROM Customers
GROUP BY CustomerID
HAVING COUNT(*) > 1;

-- 2. Check for missing emails or phone numbers
SELECT *
FROM Customers
WHERE Email IS NULL OR Phone IS NULL;

-- 3. Check for accounts with negative balance (except loans)
SELECT *
FROM Accounts
WHERE Balance < 0 AND AccountType <> 'Loan';

-- 4. Check for loans with end date before start date
SELECT *
FROM Loans
WHERE EndDate < StartDate;

-- 5. Check for payments linked to non-existing loans
SELECT *
FROM Payments p
LEFT JOIN Loans l ON p.LoanID = l.LoanID
WHERE l.LoanID IS NULL;

-- 6. Check for payment schedules with missing due amounts
SELECT *
FROM Payment_Schedule
WHERE DueAmount IS NULL;

-- 7. Summary statistics for credit scores
SELECT MIN(CreditScore) AS MinScore, MAX(CreditScore) AS MaxScore, AVG(CreditScore) AS AvgScore
FROM Credit_Scores;

-- 8. Count of customers by risk level
SELECT RiskLevel, COUNT(*) AS NumCustomers
FROM Risk_Assessment
GROUP BY RiskLevel;

-- 9. Count of loans by status
SELECT Status, COUNT(*) AS NumLoans
FROM Loans
GROUP BY Status;

-- 10. Total loan amounts by loan type
SELECT LoanType, SUM(Principal) AS TotalLoanAmount
FROM Loans
GROUP BY LoanType;

-- 11. Average days late per customer
SELECT a.CustomerID, AVG(ps.DaysLate) AS AvgDaysLate
FROM Accounts a
JOIN Loans l ON a.AccountID = l.AccountID
JOIN Payment_Schedule ps ON l.LoanID = ps.LoanID
GROUP BY a.CustomerID;

-- 12. Customers with late payments
SELECT DISTINCT a.CustomerID, c.FirstName, c.LastName
FROM Accounts a
JOIN Loans l ON a.AccountID = l.AccountID
JOIN Payment_Schedule ps ON l.LoanID = ps.LoanID
JOIN Customers c ON a.CustomerID = c.CustomerID
WHERE ps.DaysLate > 0;
