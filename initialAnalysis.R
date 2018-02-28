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
    wins = n(), # count of wins
    sPts = sum(WScore), # sum of points scored
    sWFGM = sum(WFGM), # sum of field goals made
    sWFGA = sum(WFGA), # sum of field goals attempted
    sWFGM3 = sum(WFGM3), # sum of 3 pointers made
    sWFGA3 = sum(WFGA3), # sum of 3 pointers attempted
    sWFTM = sum(WFTM), # sum of free throws made
    sWFTA = sum(WFTA), # sum of free throws attempted
    sWOR = sum(WOR), # sum of offensive rebounds
    sWDR = sum(WDR), # sum of defensive rebounds
    sWAst = sum(WAst), # sum of assists
    sWTO = sum(WTO), # sum of turnovers committed
    sWStl = sum(WStl), # sum of steals
    sWBlk = sum(WBlk), # sum of blocks
    sWPF = sum(WPF), # sum of personal fouls
    aPts = mean(WScore), # avg points scored
    aSpr = mean(Spr), # avg point spread
    aWFGM = mean(WFGM), # mean of field goals made
    aWFGA = mean(WFGA), # mean of field goals attempted
    aWFGM3 = mean(WFGM3), # mean of 3 pointers made
    aWFGA3 = mean(WFGA3), # mean of 3 pointers attempted
    aWFTM = mean(WFTM), # mean of free throws made
    aWFTA = mean(WFTA), # mean of free throws attempted
    aWOR = mean(WOR), # mean of offensive rebounds
    aWDR = mean(WDR), # mean of defensive rebounds
    aWAst = mean(WAst), # mean of assists
    aWTO = mean(WTO), # mean of turnovers committed
    aWStl = mean(WStl), # mean of steals
    aWBlk = mean(WBlk), # mean of blocks
    aWPF = mean(WPF) # mean of personal fouls
  )

# aggregate statistics from regular season by losing team
lossStats <- regularSeasonDetailedResultsM %>%
  group_by(LTeamID, Season) %>%
  summarise(
    losses = n(), # count of losses
    sPts = sum(LScore), # sum of points scored
    sLFGM = sum(LFGM), # sum of field goals made
    sLFGA = sum(LFGA), # sum of field goals attempted
    sLFGM3 = sum(LFGM3), # sum of 3 pointers made
    sLFGA3 = sum(LFGA3), # sum of 3 pointers attempted
    sLFTM = sum(LFTM), # sum of free throws made
    sLFTA = sum(LFTA), # sum of free throws attempted
    sLOR = sum(LOR), # sum of offensive rebounds
    sLDR = sum(LDR), # sum of defensive rebounds
    sLAst = sum(LAst), # sum of assists
    sLTO = sum(LTO), # sum of turnovers committed
    sLStl = sum(LStl), # sum of steals
    sLBlk = sum(LBlk), # sum of blocks
    sLPF = sum(LPF), # sum of personal fouls
    aPts = mean(LScore), # avg points scored
    aSpr = mean(Spr), # avg point spread
    aLFGM = mean(LFGM), # mean of field goals made
    aLFGA = mean(LFGA), # mean of field goals attempted
    aLFGM3 = mean(LFGM3), # mean of 3 pointers made
    aLFGA3 = mean(LFGA3), # mean of 3 pointers attempted
    aLFTM = mean(LFTM), # mean of free throws made
    aLFTA = mean(LFTA), # mean of free throws attempted
    aLOR = mean(LOR), # mean of offensive rebounds
    aLDR = mean(LDR), # mean of defensive rebounds
    aLAst = mean(LAst), # mean of assists
    aLTO = mean(LTO), # mean of turnovers committed
    aLStl = mean(LStl), # mean of steals
    aLBlk = mean(LBlk), # mean of blocks
    aLPF = mean(LPF) # mean of personal fouls
  )


ggplot(data = winStats, mapping = aes(x = wins, y = sWFGA3)) +
  geom_point(aes(size = aSpr), alpha = 1/3) + 
  geom_smooth(se = FALSE)

ggplot(data = lossStats, mapping = aes(x = losses, y = sLFGA3)) +
  geom_point(aes(size = aSpr), alpha = 1/3) + 
  geom_smooth(se = FALSE)

# bind winStats and lossStats.
# grouped by Team, Season, W/L
# stats
teamStats <- 