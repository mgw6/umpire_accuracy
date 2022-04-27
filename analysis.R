library(pastecs)
#install.packages("officer")
library(officer)
#library(stargazer)
library(psych)
library(vioplot)
library(ggplot2)
#install.packages("flextable")
library(flextable)

game_data  <- read.csv("C:/Users/User/ECON416/umpire_accuracy/data_files/final_data.csv", header=TRUE)


#########################################################
#Random Graphs and Tables
#########################################################
#stat.desc(game_data)
colnames(game_data)
stat.desc(game_data[,c('game_year',"umpire_accuracy","umpire_consistency", 'inn', 'day', 'attendance',
                       'total_cLI', 'avg_temp', 'precipitation', 'snow', 'wind_speed', 'day_num_of_year',
                       'yrs_experience', 'age', 'last_accuracy', 'last_consistency', 'days_between')])
hist(game_data$game_year, breaks = 6)
hist(game_data$inn, main = 'Histogram of Innigngs', xlab = 'Innings')
hist(game_data$day, breaks = 2)
summary(game_data)

data_summary = describeBy(game_data[,c('game_year',"umpire_accuracy","umpire_consistency", 'inn', 'day', 'attendance',
                        'total_cLI', 'avg_temp', 'precipitation', 'snow', 'wind_speed', 'day_num_of_year',
                        'yrs_experience', 'age', 'last_accuracy', 'last_consistency', 'days_between', 
                        'time_double', 'year_avg_consistency', 'year_avg_accuracy')])
write.csv(data_summary, file = 'C:/Users/User/ECON416/umpire_accuracy/data_summary.csv')



inning_table = describeBy(game_data$inn, group = game_data$game_year, mat = TRUE)
write.csv(inning_table, file = 'C:/Users/User/ECON416/umpire_accuracy/inning_table.csv')

boxplot(inn~game_year, data = game_data)
boxplot(umpire_consistency ~ game_year, data = game_data)
boxplot(umpire_accuracy ~ day, data = game_data)


vioplot(game_data$umpire_accuracy[game_data$game_year == 2017],
        game_data$umpire_accuracy[game_data$game_year == 2018],
        game_data$umpire_accuracy[game_data$game_year == 2019],
        game_data$umpire_accuracy[game_data$game_year == 2020],
        game_data$umpire_accuracy[game_data$game_year == 2021],
        names = c("2017", "2018", "2019", "2020", "2021"),
        col = 'light green',
        xlab = 'Year', ylab = 'Umpire Accuracy',
        main = "Box and Density of Umpire Accuracy"
        )

vioplot(game_data$umpire_consistency[game_data$game_year == 2017],
        game_data$umpire_consistency[game_data$game_year == 2018],
        game_data$umpire_consistency[game_data$game_year == 2019],
        game_data$umpire_consistency[game_data$game_year == 2020],
        game_data$umpire_consistency[game_data$game_year == 2021],
        names = c("2017", "2018", "2019", "2020", "2021"), 
        col = 'light blue', 
        xlab = 'Year', ylab = 'Umpire Consistency',
        main = "Box and Density of Umpire Consistency"
        
)

vioplot(game_data$umpire_consistency[game_data$day == 0],
        game_data$umpire_consistency[game_data$day == 1],
        names = c("Night", "Day"), 
        col = 'navy blue', 
        xlab = 'Day/Night', ylab = 'Umpire Consistency',
        main = "Box and Density of Day Vs. Night"
        
)

vioplot(game_data$umpire_accuracy[game_data$day == 0],
        game_data$umpire_accuracy[game_data$day == 1],
        names = c("Night", "Day"), 
        col = 'purple', 
        xlab = 'Day/Night', ylab = 'Umpire Accuracy',
        main = "Box and Density of Day Vs. Night"
        
)


ggplot(game_data, aes(x = inn, y = time_double)) + geom_point() + geom_smooth(method = lm) + labs(title ="Time as a Function of Innings") +  xlab("Innings") + ylab("Time of Game (hours)")


ggplot(game_data, aes(x = last_accuracy, y = umpire_accuracy)) + geom_point() + geom_smooth(method = lm) + labs(title ="Accuracy as a Function of Last Game's Accuracy") +  xlab("Last Game Accuracy") + ylab("Accuracy")

ggplot(game_data, aes(x = last_consistency, y = umpire_consistency)) + geom_point() + geom_smooth(method = lm) + labs(title ="Consistency as a Function of Last Game's Consistency") +  xlab("Last Game Consistency") + ylab("Consistency")


# ########################################################
# Regression Analysis
# ########################################################
library(estimatr)
library(huxtable)
library(jtools)
library(dplyr)
options("jtools-digits" = 4)

game_data$accuracy_consistency = .5*(game_data$umpire_accuracy) + .5*(game_data$umpire_consistency)

game_data$accuracy_consistency_pct = game_data$accuracy_consistency*100
game_data$last_accuracy_pct = game_data$last_accuracy*100
game_data$last_consistency_pct = game_data$last_consistency*100
game_data$attendance_k = game_data$attendance/1000
game_data$year_avg_accuracy_pct = game_data$year_avg_accuracy*100
game_data$year_avg_consistency_pct = game_data$year_avg_consistency*100
game_data$consistency_diff = game_data$last_consistency_pct - game_data$year_avg_consistency_pct
game_data$accuracy_diff = game_data$last_accuracy_pct - game_data$year_avg_accuracy_pct


############################################
# The first three models in the paper
############################################
reg1_accuracy <- summ(lm((100*umpire_accuracy) ~ inn + day + attendance_k + 
                total_cLI + avg_temp + precipitation + snow + wind_speed + day_num_of_year + 
                yrs_experience + age + last_accuracy_pct + last_consistency_pct + days_between + time_double, game_data), robust = "HC1")
reg1_accuracy

reg1_consistency <- summ(lm((100*umpire_consistency) ~ inn + day + attendance_k + 
                           total_cLI + avg_temp + precipitation + snow + wind_speed + day_num_of_year + 
                           yrs_experience + age + last_accuracy_pct + last_consistency_pct + days_between + time_double, game_data), robust = "HC1")
reg1_consistency


reg1_cons_acc <- summ(lm(accuracy_consistency_pct ~ inn + day + attendance_k + 
                              total_cLI + avg_temp + precipitation + snow + wind_speed + day_num_of_year + 
                              yrs_experience + age + last_accuracy_pct + last_consistency_pct + days_between + 
                                 time_double, game_data), robust = "HC1")
reg1_cons_acc


export_summs(reg1_accuracy, reg1_consistency, reg1_cons_acc,
             robust = "HC1", to.file = "xlsx", 
             file.name = "C:/Users/User/ECON416/umpire_accuracy/regoutput_comp_dep.xlsx",
             stars = c(`***` = 0.01, `**` = 0.05, `*` = 0.10),
             statistics = c(N ="nobs", AdjR2="adwj.r.squared"))
############################################
# The second set of  three models in the paper
############################################
reg1_accuracy_yr <- summ(lm((100*umpire_accuracy) ~ inn + day + attendance_k + 
                                 total_cLI + avg_temp + precipitation + snow + wind_speed + day_num_of_year + 
                                 yrs_experience + age + last_accuracy_pct + last_consistency_pct + days_between + 
                                    time_double + year_avg_accuracy_pct + year_avg_consistency_pct
                            , game_data), robust = "HC1")
reg1_accuracy_yr


reg1_consistency_yr <- summ(lm((100*umpire_consistency) ~ inn + day + attendance_k + 
                                    total_cLI + avg_temp + precipitation + snow + wind_speed + day_num_of_year + 
                                    yrs_experience + age + last_accuracy_pct + last_consistency_pct + days_between 
                               + time_double + year_avg_accuracy_pct + year_avg_consistency_pct
                            , game_data), robust = "HC1")

reg1_cons_acc_yr <- summ(lm(accuracy_consistency_pct ~ inn + day + attendance_k + 
                                 total_cLI + avg_temp + precipitation + snow + wind_speed + day_num_of_year + 
                                 yrs_experience + age + last_accuracy_pct + last_consistency_pct + days_between + 
                                 time_double + year_avg_accuracy_pct + year_avg_consistency_pct
                         , game_data), robust = "HC1")

export_summs(reg1_accuracy_yr, reg1_consistency_yr, reg1_cons_acc_yr,
             robust = "HC1", to.file = "xlsx", 
             file.name = "C:/Users/User/ECON416/umpire_accuracy/regoutput_comp_dep_yr.xlsx",
             stars = c(`***` = 0.01, `**` = 0.05, `*` = 0.10),
             statistics = c(N ="nobs", AdjR2="adwj.r.squared", R2="r.squared" ))




##########################################
# Below is where I start considering the 
##########################################
cons_acc_2_2 <- summ(lm(accuracy_consistency_pct ~ inn + day + attendance_k + 
                              total_cLI + avg_temp + precipitation + snow + wind_speed + day_num_of_year + 
                              yrs_experience + age + last_accuracy_pct + last_consistency_pct + days_between + 
                              time_double + time_double*day + I(yrs_experience^2) + I(last_accuracy_pct^2) + 
                              I(last_consistency_pct^2) + I(age^2) + inn*day + inn*time_double + 
                        year_avg_accuracy_pct + year_avg_consistency_pct + I(accuracy_diff^2) + I(consistency_diff^2)
                      , game_data), robust = "HC1")
cons_acc_2_2

cons_acc_2_3 <- summ(lm(accuracy_consistency_pct ~ inn + day + attendance_k + 
                                total_cLI + avg_temp + precipitation + snow + wind_speed + day_num_of_year + 
                                yrs_experience + last_accuracy_pct + last_consistency_pct + days_between + 
                                time_double + time_double*day + I(yrs_experience^2) + I(last_accuracy_pct^2) + 
                                I(last_consistency_pct^2) + inn*day + inn*time_double + 
                                year_avg_accuracy_pct + year_avg_consistency_pct + I(accuracy_diff^2) + I(consistency_diff^2)
                        , game_data), robust = "HC1")
cons_acc_2_3

cons_acc_2_4 <- summ(lm(accuracy_consistency_pct ~ inn + day + attendance_k + 
                                total_cLI + avg_temp + snow + wind_speed + day_num_of_year + 
                                yrs_experience + last_accuracy_pct + last_consistency_pct + days_between + 
                                time_double + time_double*day + I(yrs_experience^2) + I(last_accuracy_pct^2) + 
                                I(last_consistency_pct^2) + inn*day + inn*time_double + 
                                year_avg_accuracy_pct + year_avg_consistency_pct + I(accuracy_diff^2) + I(consistency_diff^2)
                        , game_data), robust = "HC1")
cons_acc_2_4

cons_acc_2_5 <- summ(lm(accuracy_consistency_pct ~ inn + day + attendance_k + 
                                total_cLI + avg_temp + precipitation + snow  + day_num_of_year + 
                                yrs_experience + last_accuracy_pct + last_consistency_pct + days_between + 
                                time_double + time_double*day + I(yrs_experience^2) + I(last_accuracy_pct^2) + 
                                I(last_consistency_pct^2) + inn*day + inn*time_double + 
                                year_avg_accuracy_pct + year_avg_consistency_pct + I(accuracy_diff^2) + I(consistency_diff^2)
                        , game_data), robust = "HC1")
cons_acc_2_5

cons_acc_2_6 <- summ(lm(accuracy_consistency_pct ~ inn + day + attendance_k + 
                                total_cLI + avg_temp + precipitation + snow  + day_num_of_year + 
                                yrs_experience + last_accuracy_pct + last_consistency_pct + 
                                time_double + time_double*day + I(yrs_experience^2) + I(last_accuracy_pct^2) + 
                                I(last_consistency_pct^2) + inn*day + inn*time_double + 
                                year_avg_accuracy_pct + year_avg_consistency_pct + I(accuracy_diff^2) + I(consistency_diff^2)
                        , game_data), robust = "HC1")
cons_acc_2_6

export_summs(cons_acc_2_2, cons_acc_2_3, cons_acc_2_4, cons_acc_2_5, cons_acc_2_6,
             robust = "HC1", to.file = "xlsx", 
             file.name = "C:/Users/User/ECON416/umpire_accuracy/regoutput_avg__.xlsx",
             stars = c(`***` = 0.01, `**` = 0.05, `*` = 0.10),
             statistics = c(N ="nobs", AdjR2="adj.r.squared"))




############################################
# More random analysis
############################################

reg2_cons_acc <- summ(lm(accuracy_consistency_pct ~ attendance +total_cLI + snow + day_num_of_year + 
                                 yrs_experience + last_accuracy_pct + last_consistency_pct + time_double, game_data), robust = "HC1")
reg2_cons_acc


reg2_cons_acc_age <- summ(lm((100*accuracy_consistency) ~ attendance +total_cLI + snow + day_num_of_year + age + I(age^2) +
                                     yrs_experience + I(100*last_accuracy) + I(100*last_consistency) + time_double, game_data), robust = "HC1")
reg2_cons_acc_age

temp_squared <- summ(lm(accuracy_consistency_pct ~ attendance +total_cLI + snow + day_num_of_year + 
                                yrs_experience + last_accuracy_pct + last_consistency_pct + time_double
                        +  I(yrs_experience^2) + I(last_accuracy_pct^2) + I(last_consistency_pct^2), 
                        game_data), robust = "HC1")
temp_squared

reg2_cons_acc_2 <- summ(lm(accuracy_consistency_pct ~ attendance +total_cLI + snow + day_num_of_year + 
                                   yrs_experience + last_accuracy_pct + last_consistency_pct + time_double, game_data), robust = "HC1")
reg2_cons_acc_2

export_summs(reg1_accuracy, reg1_consistency, reg1_cons_acc, reg2_cons_acc, reg2_cons_acc_age, temp_squared, reg2_cons_acc_2,
             robust = "HC1", to.file = "xlsx", 
             file.name = "C:/Users/User/ECON416/umpire_accuracy/regoutput.xlsx",
             stars = c(`***` = 0.01, `**` = 0.05, `*` = 0.10),
             statistics = c(N ="nobs", AdjR2="adj.r.squared"))

day_time_interaction <- summ(lm(accuracy_consistency_pct ~ total_cLI + snow + day_num_of_year + 
                                        last_accuracy_pct + last_consistency_pct + time_double + yrs_experience + 
                                        I(yrs_experience^2) + I(last_accuracy_pct^2) + I(last_consistency_pct^2) + 
                                        attendance_k + age + I(age^2), 
                                game_data), robust = "HC1")
day_time_interaction

cons_acc_2 <- summ(lm(accuracy_consistency_pct ~ inn + day + attendance_k + 
                              total_cLI + avg_temp + precipitation + snow + wind_speed + day_num_of_year + 
                              yrs_experience + age + last_accuracy_pct + last_consistency_pct + days_between + 
                              time_double + time_double*day + I(yrs_experience^2) + I(last_accuracy_pct^2) + 
                              I(last_consistency_pct^2) + I(age^2) + inn*day + inn*time_double
                      , game_data), robust = "HC1")
cons_acc_2

temp_squared_2 <- summ(lm(accuracy_consistency_pct ~ attendance_k +total_cLI + snow + day_num_of_year + 
                                  yrs_experience + last_accuracy_pct + last_consistency_pct + time_double
                          +  I(yrs_experience^2) + I(last_accuracy_pct^2) + I(last_consistency_pct^2)
                          + age + I(age^2) + day*inn
                          , game_data), robust = "HC1")
temp_squared_2

temp_squared_3 <- summ(lm(accuracy_consistency_pct ~ attendance_k +total_cLI + snow + day_num_of_year + 
                                  yrs_experience + last_accuracy_pct + last_consistency_pct + time_double
                          +  I(yrs_experience^2) + I(last_accuracy_pct^2) + I(last_consistency_pct^2)
                          + age + I(age^2) + day*time_double + day_num_of_year + I(day_num_of_year^2) 
                          , game_data), robust = "HC1")
temp_squared_3

temp_squared_4 <- summ(lm(accuracy_consistency_pct ~ attendance_k +total_cLI + snow + day_num_of_year + 
                                  yrs_experience + last_accuracy_pct + last_consistency_pct + time_double
                          +  I(yrs_experience^2) + I(last_accuracy_pct^2) + I(last_consistency_pct^2)
                          + age + I(age^2) + day*time_double + days_between + I(days_between^2) 
                          , game_data), robust = "HC1")
temp_squared_4

temp_squared_5 <- summ(lm(accuracy_consistency_pct ~ attendance_k +total_cLI + snow + day_num_of_year + 
                                  yrs_experience + last_accuracy_pct + last_consistency_pct + time_double
                          +  I(yrs_experience^2) + I(last_accuracy_pct^2) + I(last_consistency_pct^2)
                          + age + I(age^2) + day*inn + day*time_double #+ time_double*inn
                          , game_data), robust = "HC1")
temp_squared_5

temp_squared_6 <- summ(lm(accuracy_consistency_pct ~ attendance_k +total_cLI + snow + day_num_of_year + 
                                  yrs_experience + last_accuracy_pct + last_consistency_pct + time_double
                          +  I(yrs_experience^2) + I(last_accuracy_pct^2) + I(last_consistency_pct^2)
                          + age + I(age^2) + day*inn + day*time_double + time_double*inn
                          , game_data), robust = "HC1")
temp_squared_6

temp_squared_7 <- summ(lm(accuracy_consistency_pct ~ attendance_k +total_cLI + snow + day_num_of_year + 
                                  yrs_experience + last_accuracy_pct + last_consistency_pct + time_double
                          +  I(yrs_experience^2) + I(last_accuracy_pct^2) + I(last_consistency_pct^2)
                          + age + I(age^2) + day*inn + day*time_double + time_double*inn + 
                                  I(100*year_avg_accuracy) + I(100*year_avg_consistency)
                          , game_data), robust = "HC1")
temp_squared_7

temp_squared_8 <- summ(lm(accuracy_consistency_pct ~ attendance_k +total_cLI + snow + day_num_of_year + 
                                  yrs_experience + last_accuracy_pct + last_consistency_pct + time_double
                          +  I(yrs_experience^2) + I(last_accuracy_pct^2) + I(last_consistency_pct^2)
                          + age + I(age^2) + day*inn +
                                  I(100*year_avg_accuracy) + I(100*year_avg_consistency)
                          , game_data), robust = "HC1")
temp_squared_8

temp_squared_9 <- summ(lm(accuracy_consistency_pct ~ attendance_k +total_cLI + snow + day_num_of_year + 
                                  yrs_experience + last_accuracy_pct + last_consistency_pct + time_double
                          +  I(yrs_experience^2) + I(last_accuracy_pct^2) + I(last_consistency_pct^2)
                          + age + I(age^2) + day*inn + day*time_double + time_double*inn + 
                                  year_avg_accuracy_pct + year_avg_consistency_pct
                          , game_data), robust = "HC1")
temp_squared_9

temp_squared_10 <- summ(lm(accuracy_consistency_pct ~ attendance_k +total_cLI + snow + day_num_of_year + 
                                   yrs_experience + last_accuracy_pct + last_consistency_pct + time_double
                           +  I(yrs_experience^2) + I(last_accuracy_pct^2) + I(last_consistency_pct^2)
                           + age + I(age^2) + day*inn + day*time_double + time_double*inn + 
                                   year_avg_accuracy_pct + year_avg_consistency_pct
                           + I(accuracy_diff^2) + I(consistency_diff^2)
                           , game_data), robust = "HC1")
temp_squared_10

export_summs(day_time_interaction, cons_acc_2, temp_squared_2, temp_squared_3, temp_squared_4, temp_squared_5, temp_squared_6,
             temp_squared_7, temp_squared_8, temp_squared_9, temp_squared_10,
             robust = "HC1", to.file = "xlsx", 
             file.name = "C:/Users/User/ECON416/umpire_accuracy/regoutput_avg.xlsx",
             stars = c(`***` = 0.01, `**` = 0.05, `*` = 0.10),
             statistics = c(N ="nobs", AdjR2="adj.r.squared"))
