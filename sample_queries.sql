-- =============================================
-- Sample Queries 
-- =============================================

-- 1. Check customers with late payments
SELECT c.CustomerID, c.FirstName, c.LastName, ps.LateDays
FROM Customers c
JOIN Accounts a ON c.CustomerID = a.CustomerID
JOIN Loans l ON a.AccountID = l.AccountID
JOIN Payment_Schedule ps ON l.LoanID = ps.LoanID
WHERE ps.LateDays > 0;

-- 2. High-risk customers with active loans
SELECT c.CustomerID, c.FirstName, c.LastName, ra.RiskLevel, l.Status, l.Principal
FROM Customers c
JOIN Risk_Assessment ra ON c.CustomerID = ra.CustomerID
JOIN Accounts a ON c.CustomerID = a.CustomerID
JOIN Loans l ON a.AccountID = l.AccountID
WHERE ra.RiskLevel = 'High' AND l.Status = 'Active';

-- 3. Customers with improving or declining credit scores
SELECT c.CustomerID, c.FirstName, c.LastName,
       MIN(cs.CreditScore) AS MinScore,
       MAX(cs.CreditScore) AS MaxScore
FROM Customers c
JOIN Credit_Scores cs ON c.CustomerID = cs.CustomerID
GROUP BY c.CustomerID
HAVING MAX(cs.CreditScore) > MIN(cs.CreditScore) OR MAX(cs.CreditScore) < MIN(cs.CreditScore);

-- 4. Total loan amount by loan status
SELECT l.Status, SUM(l.Principal) AS TotalLoanAmount
FROM Loans l
GROUP BY l.Status;

-- 5. Total interest expected per loan (simplified)
SELECT l.LoanID, l.Principal, l.InterestRate,
       (l.Principal * l.InterestRate / 100) AS ExpectedInterest
FROM Loans l;

-- 6. Average payment delay per customer
SELECT c.CustomerID, c.FirstName, c.LastName, AVG(ps.LateDays) AS AvgLateDays
FROM Customers c
JOIN Accounts a ON c.CustomerID = a.CustomerID
JOIN Loans l ON a.AccountID = l.AccountID
JOIN Payment_Schedule ps ON l.LoanID = ps.LoanID
GROUP BY c.CustomerID;

-- 7. Loan applications by status
SELECT Status, COUNT(*) AS TotalApplications
FROM Loan_Applications
GROUP BY Status;

-- 8. Customers with multiple active loans
SELECT c.CustomerID, c.FirstName, c.LastName, COUNT(l.LoanID) AS ActiveLoans
FROM Customers c
JOIN Accounts a ON c.CustomerID = a.CustomerID
JOIN Loans l ON a.AccountID = l.AccountID
WHERE l.Status = 'Active'
GROUP BY c.CustomerID
HAVING COUNT(l.LoanID) > 1;

-- 9. Payment performance: total due vs total paid
SELECT l.LoanID,
       SUM(ps.DueAmount) AS TotalDue,
       SUM(ps.PaidAmount) AS TotalPaid,
       SUM(ps.DueAmount) - SUM(ps.PaidAmount) AS Outstanding
FROM Loans l
JOIN Payment_Schedule ps ON l.LoanID = ps.LoanID
GROUP BY l.LoanID;

-- 10. Top 5 customers by outstanding balance
SELECT c.CustomerID, c.FirstName, c.LastName, SUM(a.Balance) AS TotalBalance
FROM Customers c
JOIN Accounts a ON c.CustomerID = a.CustomerID
GROUP BY c.CustomerID
ORDER BY TotalBalance ASC
LIMIT 5;
