"""
MacGregor Winegard
2/5/2022

This file is where I am going to learn how to use the PyBaseball package
basically a scrathpad for my thoughts

"""

import pybaseball
import pandas as pd

if __name__ == '__main__':

    data = pybaseball.statcast(start_dt='2021-06-25', end_dt='2021-06-25') 
    #This returns a pandas df
    

    #print(type(data))
    #print(data.columns)
    #print(data.size)
    #print(data.shape)
    
    data.to_excel("test.xlsx", index = False)