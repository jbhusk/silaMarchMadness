# Overview ----
# will outline work using following methodology:
# 1) Import, 2) Tidy, 3) Transform, 4) Visualize, 5) Model, 6) Communicate

# Import ----
library(tidyverse)

cities <- read_csv(file = "~/march/Data/Cities.csv")
conferences <- read_csv(file = "~/march/Data/Conferences.csv")
conferenceTourneyGames <- read_csv(file = "~/march/Data/ConferenceTourneyGames.csv")
events2010 <- read_csv(file = "~/march/Data/Events_2010.csv")
#events2011 <- read_csv(file = "~/march/Data/Events_2011.csv") #commenting out until i'm sure i'll use since the files are huge, skipping the rest of the 'events' files for now

gameCities <- read_csv(file = "~/march/Data/GameCities.csv")
massey <- read_csv(file = "~/march/Data/MasseyOrdinals.csv")
NCAATourneyCompactResults <- read_csv(file = "~/march/Data/NCAATourneyCompactResults.csv")
NCAATourneyDetailedResults <- read_csv(file = "~/march/Data/NCAATourneyDetailedResults.csv")
NCAATourneySeedRoundSlots <- read_csv(file = "~/march/Data/NCAATourneySeedRoundSlots.csv")
NCAATourneySeeds <- read_csv(file = "~/march/Data/NCAATourneySeeds.csv")
NCAATourneySlots <- read_csv(file = "~/march/Data/NCAATourneySlots.csv")
players2010 <- read_csv(file = "~/march/Data/Players_2010.csv")
#players2011 <- read_csv(file = "~/march/Data/Players_2011.csv")

regularSeasonCompactResults <- read_csv(file = "~/march/Data/RegularSeasonCompactResults.csv")
regularSeasonDetailedResults <- read_csv(file = "~/march/Data/RegularSeasonDetailedResults.csv")
seasons <- read_csv(file = "~/march/Data/Seasons.csv")
secondaryTourneyCompactResults <- read_csv(file = "~/march/Data/SecondaryTourneyCompactResults.csv")
secondaryTourneyTeams <- read_csv(file = "~/march/Data/SecondaryTourneyTeams.csv")
teamCoaches <- read_csv(file = "~/march/Data/TeamCoaches.csv")
teamConferences <- read_csv(file = "~/march/Data/TeamConferences.csv")
teams <- read_csv(file = "~/march/Data/Teams.csv")
teamSpellings <- read_csv(file = "~/march/Data/TeamSpellings.csv")

# Tidy ----
summary(massey)
str(massey)
summary(regularSeasonCompactResults) # aggregate the season data for each team
summary(regularSeasonDetailedResults)
summary(secondaryTourneyCompactResults) # could use as another source for model optimization - you wouldn't have these results to use ot predict
summary(NCAATourneyCompactResults)
NCAATourneyCompactResults
regularSeasonDetailedResults
# create a table that has a row per team with the aggregate statistics from the season
teams

# Transform ----
# create a new variable on teams data representing number of years as D1 team
teams <- mutate(teams,
                yearsD1 = LastD1Season - FirstD1Season
                )


