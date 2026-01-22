HR Employee Attrition Prediction Dashboard

An interactive Shiny-based web dashboard built in R to analyze and visualize employee attrition trends. The application allows HR professionals to upload employee data, apply filters, and generate insights through dynamic visualizations.

📌 Project Overview

The HR Employee Attrition Prediction Dashboard helps organizations understand employee attrition patterns based on age and department. It provides an intuitive UI for HR teams to explore data, apply filters, and visualize attrition distribution using interactive plots.

🚀 Features

📂 CSV File Upload for employee datasets
🏢 Department-wise filtering
🎯 Age range filtering using slider
📊 Interactive visualizations using ggplot2 & Plotly
📋 Data preview table with pagination
🔍 Data validation for required columns


🧾 Dataset Requirements
The uploaded CSV file must contain the following columns:
- Column Name	Description
- Age	Employee age
- Attrition	Attrition status (Yes / No)
- Department	Employee department

🛠️ Tech Stack
Language: R
Framework: Shiny
Libraries Used:
shiny
ggplot2
shinythemes
DT
plotly

📁 Project Structure
HR-Employee-Attrition-Prediction/
│
├── app.R        # Main Shiny application file
├── README.md    # Project documentation

▶️ How to Run the Application

1️⃣ Install Required Libraries (Run once)
install.packages(c("shiny", "ggplot2", "shinythemes", "DT", "plotly"))

2️⃣ Run the Application
shiny::runApp("app.R")
OR simply open app.R in RStudio and click Run App ▶️

📊 Dashboard Preview
- The application includes:
- Data Preview Tab – View uploaded data in tabular format
- Visualization Tab – Histogram showing employee attrition by age with department-based filtering

🎯 Use Case
- HR analytics and workforce planning
- Identifying age groups with higher attrition
- Supporting HR decision-making through data visualization

👩‍💻 Author
- Siony Naresh Chaudhari
- 📧 siony.21.chaudhari@gmail.com
- 🔗 GitHub: https://github.com/siony-chaudhari

📌 Future Enhancements
- Add machine learning–based attrition prediction scores
- Export insights as PDF reports
- Include additional filters (salary, experience, job role)

📄 License
- This project is created for academic and learning purposes.