#! /usr/bin/python
import os
import pyowm
import re

OPENWEATHER_API_KEY=os.environ['OPENWEATHER_API_KEY']
CITY_NAME=os.environ['CITY_NAME']

owm=pyowm.OWM(OPENWEATHER_API_KEY)
observation=owm.weather_at_place(CITY_NAME)
weather=observation.get_weather()

data=weather.get_temperature('fahrenheit')
temps = [float(q) for q in re.findall(r"[+-]?\d+(?:\.\d+)?", str(data))]
temp=str(temps[1])

hum=str(weather.get_humidity())

print ('source=openweathermap, city="'+CITY_NAME+'", description="'+weather.get_status()+'", temp='+temp+', humidity='+hum)
