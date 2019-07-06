# luftdaten-sensor-extractor
Takes Luftdaten air quality JSON data and returns JSON listing locations of sensors

This quick and dirty piece of code takes the latest sensor readings from Luftdaten, merges them into a single object per location and then outputs them as a JSON file.

To set the area that sensor are requested for change the following in the code: 

    latitude = 57.165746
    longitude = -2.102081
    range = 10 # km
    
