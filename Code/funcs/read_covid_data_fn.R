read_covid_data_fn <- function() {
  # Note from the data masters:
  # Our complete COVID-19 dataset is a collection of the COVID-19 data maintained by Our World in Data.
  # It is updated daily and includes data on confirmed cases, deaths, and testing, as well as 
  # other variables of potential interest.
  
  # Download the updated data from URL
  return(readr::read_csv(file = "https://covid.ourworldindata.org/data/owid-covid-data.csv"))
}