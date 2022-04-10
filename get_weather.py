"""
MacGregor Winegard
get_weather.py

This function will take in a date and home team, and 
return the weather on that date at that team's home park
"""
from meteostat import Point, Hourly
from datetime import datetime
#https://github.com/meteostat/meteostat-python/blob/master/examples/daily/point.py

#REMEMBER THESE ELEVATIONS ARE IN METERS FUCK


def get_park_loc(team):
    if team == 'ARI': 
        return Point(33.4, -112.1, )
    if team == 'ATL': 
        return Point(33.9, -84.5, )
    if team == 'BAL': 
        return Point(39.3, -76.6, )
    if team == 'BOS': 
        return Point(42.3, -71.0, )
    if team == 'CHC': 
        return Point(41.9, -87.7, )
    if team == 'CHW': 
        return Point(41.8, -87.6, )
    if team == 'CIN': 
        return Point(39.0, -84.5, )
    if team == 'CLE': 
        return Point(41.5, -81.7, )
    if team == 'COL':
        return Point(39.8, -105.0, )
    if team == 'DET': 
        return Point(42.3, -83.0, )
    if team == 'HOU': 
        return Point(29.8, -95.4, )
    if team == 'KCR': 
        return Point(39.1, -94.5, )
    if team == 'LAA': 
        return Point(33.8, -117.9, )
    if team == 'LAD': 
        return Point(34.1, -118.2, )
    if team == 'MIA': 
        return Point(25.8, -80.2,  )
    if team == 'MIL': 
        return Point(43.0, -88.0, )
    if team == 'MIN': 
        return Point(45.0, -93.3, )
    if team == 'NYM':
        return Point(40.8, -73.8, )
    if team == 'NYY': 
        return Point(40.8, -73.9, )
    if team == 'OAK': 
        return Point(37.8, -122.2, )
    if team == 'PHI': 
        return Point(39.9, -75.2, )
    if team == 'PIT': 
        return Point(40.4, -80.0, )
    if team == 'SDP': 
        return Point(32.7, -117.2, )
    if team == 'SEA':
        return Point(47.6, -122.3, )
    if team == 'SFG':
        return Point(37.8, -122.4, )
    if team == 'STL': 
        return Point(38.6, -90.2, )
    if team == 'TBR':
        return Point(27.8, -82.7, )
    if team == 'TEX': 
        return Point(32.7, -97.1, )
    if team == 'TOR': 
        return Point(43.6, -79.4, )
    if team == 'WSN':
        return Point(38.9, -77.0, )
    else 
        print("Not a valid team")
        return None
    