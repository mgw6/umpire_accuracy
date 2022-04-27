# This was a quick tutorial on how to use violplot that I sent to a friend

library(vioplot)#library for the plot
game_data  <- read.csv("C:/Users/User/ECON416/umpire_accuracy/data_files/final_data.csv", header=TRUE)
#Just loads my data

vioplot(game_data$umpire_accuracy[game_data$day == 0],#First condition
        game_data$umpire_accuracy[game_data$day == 1],#second condition
        names = c("Night", "Day"), #label for the conditons in order
        col = 'purple', #Can be whatever you want, I tried to use different colors for different graphs
        xlab = 'Day/Night', ylab = 'Umpire Accuracy',#axis labels
        main = "Box and Density of Day Vs. Night"#Graph title
)


# I haven't looked at your dataset, but if I remember correctly I suggested
# that you do a graph like this for dome vs no dome. So I would think it
# would be something like 
# 
# vioplot(game_data$pop_time[game_data$dome == 0],#First condition
#         game_data$pop_time[game_data$dome == 1],#second condition
#         names = c("No Dome", "Dome"), #label for the conditons in order
#         col = 'purple', #arbitrary
#         xlab = 'Dome/No Dome', ylab = 'Pop Time',#axis labels
#         main = "Pop Time Vs. Dome in Park"#Graph title
# )


# Dr. Niu also made a comment in my feedback that this looks cool but its a little hard to understand. 
# So maybe looking at a standard box plot would be a good idea. 
# See this website: https://www.datamentor.io/r-programming/box-plot/