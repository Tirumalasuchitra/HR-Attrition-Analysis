# HR Attrition Analysis: Identifying Key Turnover Drivers

This project leverages **SQL** and **Power BI** to analyze employee turnover. By processing raw HR data, I identified critical factors—such as overtime and job satisfaction—that contribute to attrition, providing actionable insights for retention strategies.

## Project Overview
The objective was to move beyond basic headcounts to understand *why* employees leave. The project involved transforming a 35-column dataset into meaningful categories to visualize risk factors across different departments and roles.

## Technical Workflow
*   **Data Ingestion & Cleaning (SQL):** Managed the end-to-end process of loading .csv data into MySQL, ensuring data integrity across 35 attributes.
*   **Feature Engineering:** Utilized complex **CASE statements** to create income and tenure buckets, allowing for more granular analysis.
*   **Visual Analytics:** Developed a Power BI dashboard to correlate work-life balance and compensation with attrition rates.

## Key SQL Insights
Below are snapshots of the analysis performed directly in the database:

### Monthly Income by Job Role
![Income vs Job Role](monthlyincome-vs-jobrole.png)

### Attrition Rate by Monthly Income
![Attrition Rate](attritionrate-by-monthlyincome.png)

---
**Interactive Dashboard:** 
<img width="1173" height="659" alt="heatmap_analysis" src="https://github.com/user-attachments/assets/a614a38b-e9fb-4bae-8c10-e1fa926291f3" />
<img width="1175" height="668" alt="employee_sentiment" src="https://github.com/user-attachments/assets/2d71ee88-7575-4e7d-b2f4-014e1e11fd16" />
<img width="1171" height="668" alt="Dashboard_Overview" src="https://github.com/user-attachments/assets/051edf9f-a28d-4ec0-b083-85b741e93525" />

Employee attrition is not driven by a single factor, but by the interaction of workload and dissatisfaction — employees working overtime with low job satisfaction show the highest attrition (~35–37%), making workload the most critical lever to reduce overall attrition across the organization






