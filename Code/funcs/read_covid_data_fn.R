read_covid_data_fn <- function() {
  # Note from the data masters:
  # Our complete COVID-19 dataset is a collection of the COVID-19 data maintained by Our World in Data.
  # It is updated daily and includes data on confirmed cases, deaths, and testing, as well as 
  # other variables of potential interest.
  
  # Download the updated data from URL
  return(readr::read_csv(file = "https://covid.ourworldindata.org/data/owid-covid-data.csv",
                         guess_max = 100000))
}

read_covid_map_data_fn <- function() {
  # This data is taken from The New York Times. For more visuals, visit their website at
  # https://www.nytimes.com/interactive/2020/us/coronavirus-us-cases.html
  return(readr::read_csv(file = "https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-counties.csv"))
}