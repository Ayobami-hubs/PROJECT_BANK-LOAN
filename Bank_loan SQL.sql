SELECT * FROM bank_loan_data

---1.calculate the total number of loan applications received during a specified period

SELECT COUNT(id) AS Total_application FROM bank_loan_data

---2.calculate the total number of loan applications received during a specified period, monitor the Month-to-Date (MTD) Loan Applications

SELECT COUNT(*) AS total_app_MTD FROM bank_loan_data
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021

---3.calculate the total number of loan applications received during a specified period track changes Month over month (MoM)
---MoM = MTD-PMTD

SELECT COUNT(*) AS total_app_pMTD FROM bank_loan_data
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021

---4.calculate the total amount of funds disbursed as loans

SELECT SUM(loan_amount) AS Total_loan_disbured FROM bank_loan_data

---5.calculate the total amount of funds disbursed as loans on the MTD 

SELECT SUM(loan_amount) AS Total_loan_disburedMTD FROM bank_loan_data
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021 

---6.Analyse the MoM changes in this metrics

SELECT SUM(loan_amount) AS Total_loan_disburedPMTD FROM bank_loan_data
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021 


---7.Track total amount received from borrowers to assess the bank's cash flow and loan repayment

SELECT SUM(total_payment) AS Total_amt_received 
FROM bank_loan_data

--- 8.Analyse the Month-to-Date (MTD) Total Amount Received and observe the Month-over-Month (MoM) changes.P-PREVIOUS

SELECT SUM(total_payment) AS Total_amt_receivedMTD 
FROM bank_loan_data
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021 

SELECT SUM(total_payment) AS Total_amt_receivedPMTD 
FROM bank_loan_data
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021 

---9.Calculate the average interest rate across all loans, MTD, and monitoring the Month-over-Month (MoM) variations

SELECT ROUND(AVG(int_rate),4) AS avg_int_rate 
FROM bank_loan_data

SELECT ROUND(AVG(int_rate),4) AS avg_int_rateMTD 
FROM bank_loan_data
where MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021

SELECT ROUND(AVG(int_rate),4) AS avg_int_ratePMTD 
FROM bank_loan_data
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021

---10.Compute the average DTI-(debt to income) for all loans, MTD, and track Month-over-Month (MoM) fluctuations

SELECT ROUND(AVG(dti),4) AS avg_dti FROM bank_loan_data

SELECT ROUND(AVG(dti),4) AS avg_dtiMTD FROM bank_loan_data
where MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021

SELECT ROUND(AVG(dti),4) AS avg_dtiPMTD FROM bank_loan_data
where MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021

---11.calculate the percentage of loan applications classified as 'Good Loans.' This category includes loans with a loan status of 'Fully Paid' and 'Current.

SELECT COUNT
		( 
	CASE
		WHEN loan_status = 'Fully Paid' OR loan_status = 'Current'
		THEN id
	END
	)* 100 / COUNT(id) AS Goodloan_application_percent
FROM bank_loan_data

---12.Identifying the total number of loan applications falling under the 'Good Loan' category, which consists of loans with a loan status of 'Fully Paid' and 'Current.'

SELECT COUNT
		( 
	CASE
		WHEN loan_status = 'Fully Paid' OR loan_status = 'Current'
		THEN id
	END
	) AS Goodloan_application FROM bank_loan_data

---13.Determine the total amount of funds disbursed as 'Good Loans.' This includes the principal amounts of loans with a loan status of 'Fully Paid' and 'Current.'

SELECT SUM(loan_amount) AS Disbursedfunds_Goodloan 
FROM bank_loan_data
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current'
	
---14.Track the total amount received from borrowers for 'Good Loans,' which encompasses all payments made on loans with a loan status of 'Fully Paid' and 'Current.'

SELECT SUM(total_payment) AS Receivedfunds_Goodloan 
FROM bank_loan_data
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current'


---15.calculate the percentage of loan applications classified as 'Bad Loans.' This category includes loans with a loan status of 'Charged off'.

SELECT COUNT 
(CASE WHEN loan_status ='Charged off' THEN ID
END)*100/COUNT(id) AS Badloan_applicationPercent
FROM bank_loan_data


---16.Identifying the total number of loan applications falling under the 'Bad Loan' category, which consists of loans with a loan status of  'Charged off'

SELECT COUNT 
(CASE WHEN loan_status ='Charged off' THEN ID
END) AS Badloan_application
FROM bank_loan_data

---17.Determine the total amount of funds disbursed as 'Bad Loans.' This includes the principal amounts of loans with a loan status of  'Charged off'

SELECT SUM(loan_amount) AS Badloan_disbursed FROM bank_loan_data
WHERE loan_status ='Charged off'

---18.Track the total amount received from borrowers for 'Bad Loans,' which encompasses all payments made on loans with a loan status of  'Charged off'

SELECT SUM(total_payment) AS Badloan_disbursed FROM bank_loan_data
WHERE loan_status ='Charged off'


---19.Create a Table to show, 'Total Loan Applications,' 'Total Funded Amount,' 'Total Amount Received,' 'Month-to-Date (MTD) Funded Amount,' 'MTD Amount Received,' 'Average Interest Rate,' and 'Average Debt-to-Income Ratio (DTI),' 

SELECT
	loan_status,
	COUNT(id) AS Loan_application,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_amount_recieved
FROM bank_loan_data
GROUP BY loan_status


---LOAN STATUS

SELECT loan_status,
SUM(total_payment) AS MTD_Amount_Received,
SUM(loan_amount) AS MTD_Funded_Amount
FROM bank_loan_data
where MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021
GROUP BY loan_status

---MONTH

SELECT 
	MONTH(issue_date) AS Month_Munber, 
	DATENAME(MONTH, issue_date) AS Month_name, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY MONTH(issue_date), DATENAME(MONTH, issue_date)
ORDER BY MONTH(issue_date)


---ADDRESS STATE

SELECT
	address_state,
	COUNT(id) AS Loan_application,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_amount_recieved
FROM bank_loan_data
GROUP BY address_state

---TERM

SELECT
	term,
	COUNT(id) AS Loan_application,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_amount_recieved
FROM bank_loan_data
GROUP BY term

---EMPLOYEE LENGTH

SELECT 
	emp_length AS Employee_Length, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY emp_length
ORDER BY emp_length

---PURPOSE

SELECT 
	purpose AS Purpose, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY purpose
ORDER BY purpose

---HOME OWNWERSHIP

SELECT 
	home_ownership AS Home_Ownership, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY home_ownership
ORDER BY home_ownership

