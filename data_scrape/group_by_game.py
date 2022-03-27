"""
MacGregor Winegard
27 Mar, 2022

This program will take the key_points.csv file 
group them by games, and then return a file that has the overall game data

"""

import pandas as pd
import numpy as np


"""
    Inputs:
        game_df: 
            pandas df of all of the pitches 
            In most cases this will be one game, but I guess I could use this to get overall averages too
        game_pk:
            ID of the game
    Output:
        A pandas series that will have the following information:
        game_pk, game_date, ump accuracy, ump consistency
"""
def grade_game(game_df, game_pk):
    sz_L = -.8308
    sz_R = .8308
    
    #https://stackoverflow.com/questions/30631841/pandas-how-do-i-assign-values-based-on-multiple-conditions-for-existing-columns
    game_df["accurate"] = np.where(
        (game_df["plate_x"] > sz_L) & \
        (game_df["plate_x"] < sz_R) & \
        (game_df["plate_z"] > game_df["sz_bot"]) & \
        (game_df["plate_z"] < game_df["sz_top"]),
        True, False
    ) 
    
    #Now we need to figure out consistency
    #Then build & return the series
    
    print(game_df)
    exit()
    
    
    


if __name__ == '__main__':
    key_points = pd.read_csv("key_points.csv")
    
    
    game_groups = key_points.groupby(['game_pk'])
    for game_pk, game_df in game_groups.__iter__(): #iters through every game
        #print(game_df)
        grade_game(game_df, game_pk)
        
        
        exit()