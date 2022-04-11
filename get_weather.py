"""
MacGregor Winegard
get_weather.py

This function will take in a date and home team, and 
return the weather on that date at that team's home park
"""
from meteostat import Point, Daily
from datetime import datetime
#https://github.com/meteostat/meteostat-python/blob/master/examples/daily/point.py

#REMEMBER THESE ELEVATIONS ARE IN METERS FUCK


def get_park_loc(team):
    if team == 'ARI': 
        return Point(33.4, -112.1, 329.8)
    if team == 'ATL': 
        return Point(33.9, -84.5, 320.0)
    if team == 'BAL': 
        return Point(39.3, -76.6, 39.6)
    if team == 'BOS': 
        return Point(42.3, -71.0, 6.1)
    if team == 'CHC': 
        return Point(41.9, -87.7, 181.7)
    if team == 'CHW': 
        return Point(41.8, -87.6, 181.7)
    if team == 'CIN': 
        return Point(39.0, -84.5, 208.2)
    if team == 'CLE': 
        return Point(41.5, -81.7, 177.4)
    if team == 'COL':
        return Point(39.8, -105.0, 1579.8)
    if team == 'DET': 
        return Point(42.3, -83.0, 181.7)
    if team == 'HOU': 
        return Point(29.8, -95.4, 11.6)
    if team == 'KCR': 
        return Point(39.1, -94.5, 228.6)
    if team == 'LAA': 
        return Point(33.8, -117.9, 48.8)
    if team == 'LAD': 
        return Point(34.1, -118.2, 81.4)
    if team == 'MIA': 
        return Point(25.8, -80.2,  4.6)
    if team == 'MIL': 
        return Point(43.0, -88.0, 180.8)
    if team == 'MIN': 
        return Point(45.0, -93.3, 247.5)
    if team == 'NYM':
        return Point(40.8, -73.8, 16.5)
    if team == 'NYY': 
        return Point(40.8, -73.9, 16.5)
    if team == 'OAK': 
        return Point(37.8, -122.2, 12.8)
    if team == 'PHI': 
        return Point(39.9, -75.2, )
    if team == 'PIT': 
        return Point(40.4, -80.0, 2.7)
    if team == 'SDP': 
        return Point(32.7, -117.2, 4.0)
    if team == 'SEA':
        return Point(47.6, -122.3, 3.0)
    if team == 'SFG':
        return Point(37.8, -122.4, 19.2)
    if team == 'STL': 
        return Point(38.6, -90.2, 138.7)
    if team == 'TBR':
        return Point(27.8, -82.7, 13.4)
    if team == 'TEX': 
        return Point(32.7, -97.1, 187.8)
    if team == 'TOR': 
        return Point(43.6, -79.4, 75.3)
    if team == 'WSN':
        return Point(38.9, -77.0, 7.6)
    else: 
        print("Not a valid team")
        return None
    
    
def park_weather(home_team, date): 
    date = date.split("-")
    date = datetime(int(date[0]), 
        int(date[1]), 
        int(date[2]))
    
    weather = Daily(get_park_loc(home_team), date, date)
    
    return weather.fetch()