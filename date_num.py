def date_num(date):
    date = date.split("-")
    
    date[2] = int(date[2])
    if date[1] == '03':
        return 59 + date[2]
    if date[1] == '04':
        return 90 + date[2]
    if date[1] == '05':
        return 120 + date[2]
    if date[1] == '06':
        return 151 + date[2]
    if date[1] == '07':
        return 181 + date[2]
    if date[1] == '08':
        return 212 + date[2]
    if date[1] == '09':
        return 243 + date[2]
    if date[1] == '10':
        return 273 + date[2] 
    raise Exception("Invalid Date!")            