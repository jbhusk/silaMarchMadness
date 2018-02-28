# Overview ----
# will outline work using following methodology:
# 1) Import, 2) Transform, 3) Visualize, 4) Model, 5) Communicate

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

# Transform ----
summary(massey)
str(massey)
summary(regularSeasonCompactResults) # aggregate the season data for each team
summary(regularSeasonDetailedResults)
summary(secondaryTourneyCompactResults) # could use as another source for model optimization - you wouldn't have these results to use ot predict
summary(NCAATourneyCompactResults)
NCAATourneyCompactResults
regularSeasonDetailedResults

# create a new variable on teams data representing number of years as D1 team
teams <- mutate(teams,
                yearsD1 = LastD1Season - FirstD1Season
)


# create a table that has a row per team with the aggregate statistics from the season

# adding variables to regularSeasonDetailedResults
regularSeasonDetailedResultsM <- mutate(regularSeasonDetailedResults, 
                                        Spr = WScore - LScore # point spread
                                        )

# aggregate statistics from regular season by winning team
winStats <- regularSeasonDetailedResultsM %>%
  group_by(WTeamID, Season) %>%
  summarise(
    games = n(), # count of wins/games
    sPts = sum(WScore), # sum of points scored
    sFGM = sum(WFGM), # sum of field goals made
    sFGA = sum(WFGA), # sum of field goals attempted
    sFGM3 = sum(WFGM3), # sum of 3 pointers made
    sFGA3 = sum(WFGA3), # sum of 3 pointers attempted
    sFTM = sum(WFTM), # sum of free throws made
    sFTA = sum(WFTA), # sum of free throws attempted
    sOR = sum(WOR), # sum of offensive rebounds
    sDR = sum(WDR), # sum of defensive rebounds
    sAst = sum(WAst), # sum of assists
    sTO = sum(WTO), # sum of turnovers committed
    sStl = sum(WStl), # sum of steals
    sBlk = sum(WBlk), # sum of blocks
    sPF = sum(WPF), # sum of personal fouls
    aPts = mean(WScore), # avg points scored
    aSpr = mean(Spr), # avg point spread
    aFGM = mean(WFGM), # mean of field goals made
    aFGA = mean(WFGA), # mean of field goals attempted
    aFGM3 = mean(WFGM3), # mean of 3 pointers made
    aFGA3 = mean(WFGA3), # mean of 3 pointers attempted
    aFTM = mean(WFTM), # mean of free throws made
    aFTA = mean(WFTA), # mean of free throws attempted
    aOR = mean(WOR), # mean of offensive rebounds
    aDR = mean(WDR), # mean of defensive rebounds
    aAst = mean(WAst), # mean of assists
    aTO = mean(WTO), # mean of turnovers committed
    aStl = mean(WStl), # mean of steals
    aBlk = mean(WBlk), # mean of blocks
    aPF = mean(WPF) # mean of personal fouls
  )

winStats <- mutate(winStats,
                   WL = "W" # create a Win/Loss variable for when binding
                   )

winStats <- rename(winStats,
                   TeamID = WTeamID # renaming WTeamID for binding
                   )

# aggregate statistics from regular season by losing team
lossStats <- regularSeasonDetailedResultsM %>%
  group_by(LTeamID, Season) %>%
  summarise(
    games = n(), # count of losses/games
    sPts = sum(LScore), # sum of points scored
    sFGM = sum(LFGM), # sum of field goals made
    sFGA = sum(LFGA), # sum of field goals attempted
    sFGM3 = sum(LFGM3), # sum of 3 pointers made
    sFGA3 = sum(LFGA3), # sum of 3 pointers attempted
    sFTM = sum(LFTM), # sum of free throws made
    sFTA = sum(LFTA), # sum of free throws attempted
    sOR = sum(LOR), # sum of offensive rebounds
    sDR = sum(LDR), # sum of defensive rebounds
    sAst = sum(LAst), # sum of assists
    sTO = sum(LTO), # sum of turnovers committed
    sStl = sum(LStl), # sum of steals
    sBlk = sum(LBlk), # sum of blocks
    sPF = sum(LPF), # sum of personal fouls
    aPts = mean(LScore), # avg points scored
    aSpr = mean(Spr), # avg point spread
    aFGM = mean(LFGM), # mean of field goals made
    aFGA = mean(LFGA), # mean of field goals attempted
    aFGM3 = mean(LFGM3), # mean of 3 pointers made
    aFGA3 = mean(LFGA3), # mean of 3 pointers attempted
    aFTM = mean(LFTM), # mean of free throws made
    aFTA = mean(LFTA), # mean of free throws attempted
    aOR = mean(LOR), # mean of offensive rebounds
    aDR = mean(LDR), # mean of defensive rebounds
    aAst = mean(LAst), # mean of assists
    aTO = mean(LTO), # mean of turnovers committed
    aStl = mean(LStl), # mean of steals
    aBlk = mean(LBlk), # mean of blocks
    aPF = mean(LPF) # mean of personal fouls
  )

lossStats <- mutate(lossStats,
                    WL = "L" # create a Win/Loss variable for when binding
                    )

lossStats <- rename(lossStats,
                    TeamID = LTeamID # renaming LTeamID for binding
                    )


# bind winStats and lossStats.
# grouped by Team, Season, W/L
setequal(winStats, lossStats)

teamStats <- bind_rows(winStats, lossStats)

# add new variables to teamStats
teamStats <- mutate(teamStats,
                    )





# Explore ----

ggplot(data = winStats, mapping = aes(x = games, y = sFGA3)) +
  geom_point(aes(size = aSpr), alpha = 1/3) + 
  geom_smooth(se = FALSE)

ggplot(data = lossStats, mapping = aes(x = games, y = sFGA3)) +
  geom_point(aes(size = aSpr), alpha = 1/3) + 
  geom_smooth(se = FALSE)

ggplot(data = teamStats, mapping = aes(x = games, y = sFGA3)) +
  geom_point(aes(size = aSpr), alpha = 1/3) +
  geom_smooth(se = FALSE) +
  facet_wrap(~ WL)

ggplot(data = teamStats, mapping = aes(x = WL, y = sFGA3)) +
  geom_boxplot() +
  facet_wrap(~ Season)

ggplot(data = teamStats, mapping = aes(x = aFGA3, colour = WL)) +
  geom_freqpoly()
