"""
MacGregor Winegard
Date: 2/5/2022

This file will download all of the raw data from 2017 through 2021


Some thoughts:
    I have two options:
        1) Download the data and cut it down/clean it to what it I want,
        2) Download the data, save that, then clean it and save that
        
        Option 1 is more memory efficient but option 1 is more time but 
        option 2 is more time efficient if/when I make mistakes
        
        So for now I'm going with option two and if that is super fast then I will
        delete that result and combine them into one script. Okay here goes
"""

import pybaseball
import pandas as pd



"""
Inputs:
    Start_year: The first year we scrape the data from
    end_year: The last year we get the data from
        If none is given, then it only scrapes for the start year
        
        
    Returns:
        pandas df of all of the years combined
"""
def get_data_from_mlb(start_year, end_year = None):
    
    if end_year == None:
        end_year = start_year + 1
    
    dfs = [] #https://github.com/jldbc/pybaseball/blob/master/EXAMPLES/imputed_derivation.ipynb
    for year in range(start_year, end_year + 1):
        print(f"Starting year {year}")
        dfs.append(pybaseball.statcast(start_dt=f'{year}-03-21', end_dt=f'{year}-12-01',verbose=False))
        #I'm overshooting the start and end here to make sure I don't miss anything
        
    # https://pandas.pydata.org/pandas-docs/stable/user_guide/merging.html
    print("Info succesfully downloaded from statcast")
    return pd.concat(dfs) 
    
    


if __name__ == '__main__':

    result = get_data_from_mlb(2017, 2021)
    
    print("Writing raw data to csv")
    result.to_csv("raw_data_from_statcast.csv", index = False)
    
    
    
    key_points = result[[ 
                            "game_date",
                            "description",
                            "home_team",
                            "away_team",
                            "game_year",
                            "plate_x",
                            "plate_z",
                            "sz_top",
                            "sz_bot",
                            "game_pk"
    ]]
    
    print("Writing key_points data to csv")
    key_points.to_csv("key_points.csv", index = False)
    
    
