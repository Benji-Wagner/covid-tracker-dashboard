# covid-tracker-dashboard
Creating an RShiny dashboard to help visualize COVID-19 cases in the US and its spread. The data used in the bar chart is taken from Our World In Data:
https://github.com/owid/covid-19-data/tree/master/public/data. The data used in the maps is taken from the New York Times: 
https://www.nytimes.com/interactive/2020/us/coronavirus-us-cases.html. 

# Running the dashboard
Clone the repository and open Code/app.R within RStudio. You should be able to run the app from the green launch button towards the top. 

# Next Steps
This project was made for fun, but there's a lot of room for improvement. I'd like to focus more on the 
maps, specifically allowing for individual states and their respective counties, as well as making the maps interactive using plotly. I'd also like to focus more on significant 
break points in our metrics--for example, adding indicators of when mask mandates started/ended, holidays and their lagging spikes, vaccine distribution milestones, etc.

# Feedback
Occasionally OWID or the NYT may update their schema for the available datasets, resulting in the app not working as intended. If you notice this, feel free to ping me at 
benjiwagner1234@gmail.com and I should be able to fix it within 24 hours. I hope this inspires you to get your hands dirty with RShiny! There's a lot of cool things you can do 
with this package!
