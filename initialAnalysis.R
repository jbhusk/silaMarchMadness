# Overview ----
# will outline work using following methodology:
# 1) Import, 2) Tidy, 3) Transform, 4) Visualize, 5) Model, 6) Communicate

# Import ----
setwd("~/marchMadness")

cities <- read.csv(file = "~/march/Data/Cities.csv")
conferences <- read.csv(file = "~/march/Data/Conferences.csv")
conferenceTourneyGames <- read.csv(file = "~/march/Data/ConferenceTourneyGames.csv")
events2010 <- read.csv(file = "~/march/Data/Events_2010.csv")
#events2011 <- read.csv(file = "~/march/Data/Events_2011.csv") #commenting out until i'm sure i'll use since the files are huge, skipping the rest of the 'events' files for now

gameCities <- read.csv(file = "~/march/Data/GameCities.csv")
massey <- read.csv(file = "~/march/Data/MasseyOrdinals.csv")
NCAATourneyCompactResults <- read.csv(file = "~/march/Data/NCAATourneyCompactResults.csv")
NCAATourneyDetailedResults <- read.csv(file = "~/march/Data/NCAATourneyDetailedResults.csv")
NCAATourneySeedRoundSlots <- read.csv(file = "~/march/Data/NCAATourneySeedRoundSlots.csv")
NCAATourneySeeds <- read.csv(file = "~/march/Data/NCAATourneySeeds.csv")
NCAATourneySlots <- read.csv(file = "~/march/Data/NCAATourneySlots.csv")
players2010 <- read.csv(file = "~/march/Data/Players_2010.csv")
#players2011 <- read.csv(file = "~/march/Data/Players_2011.csv")

regularSeasonCompactResults <- read.csv(file = "~/march/Data/RegularSeasonCompactResults.csv")
regularSeasonDetailedResults <- read.csv(file = "~/march/Data/RegularSeasonDetailedResults.csv")
seasons <- read.csv(file = "~/march/Data/Seasons.csv")
secondaryTourneyCompactResults <- read.csv(file = "~/march/Data/SecondaryTourneyCompactResults.csv")
secondaryTourneyTeams <- read.csv(file = "~/march/Data/SecondaryTourneyTeams.csv")
teamCoaches <- read.csv(file = "~/march/Data/TeamCoaches.csv")
teamConferences <- read.csv(file = "~/march/Data/TeamConferences.csv")
teams <- read.csv(file = "~/march/Data/Teams.csv")
teamSpellings <- read.csv(file = "~/march/Data/TeamSpellings.csv")

# Tidy ----
summary(massey)
summary(regularSeasonCompactResults)
summary(regularSeasonDetailedResults)