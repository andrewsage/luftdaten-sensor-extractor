require 'net/http'
require 'json'

latitude = 57.165746
longitude = -2.102081
range = 10 # km

url = "http://api.luftdaten.info/v1/filter/area=#{latitude},#{longitude},#{range}"
uri = URI(url)
response = Net::HTTP.get(uri)

objects = JSON.parse(response)

locations = []
location_hashes = {}
objects.each do |object|
	sensor_data = object["sensordatavalues"]
	location_data = object["location"]
	id = location_data["id"]
	location = location_hashes[id] || { "id": id }
	location["timestamp"] = object["timestamp"]
	location["latitude"] = location_data["latitude"]
	location["longitude"] = location_data["longitude"]
	location["altitude"] = location_data["altitude"]
	sensor_data.each do |sensor|
		location[sensor["value_type"]] = sensor["value"]
	end
	location_hashes[id] = location
end

location_hashes.each_value do |value|
	locations << value
end

File.open("extracted.json", "w") do |f|
	f.write(locations.to_json)
end