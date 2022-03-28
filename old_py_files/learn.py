"""
MacGregor Winegard
2/5/2022

This file is where I am going to learn how to use the PyBaseball package
basically a scratchpad for my thoughts

"""

import pybaseball
import pandas as pd

if __name__ == '__main__': 

    # get statcast data for game_pk 
    data = pybaseball.team_game_logs(2018, "NYY")
    print(data)
    
    data.to_csv("test.csv", index = False)